Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWHPAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHPAXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWHPAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:23:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33189 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750726AbWHPAXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:23:09 -0400
Date: Wed, 16 Aug 2006 10:22:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org, xfs@oss.sgi.com
Subject: Re: [PATCH 0/2] Use 64-bit inode numbers internally in the kernel [try #2]
Message-ID: <20060816102224.F2740551@wobbly.melbourne.sgi.com>
References: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Tue, Aug 15, 2006 at 04:26:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 04:26:27PM +0100, David Howells wrote:
> 
> These patches make the kernel pass 64-bit inode numbers internally when
> communicating to userspace, even on a 32-bit system.  They are required
> because some filesystems have intrinsic 64-bit inode numbers: NFS3+ and XFS
> for example.  The 64-bit inode numbers are then propagated to userspace
> automatically where the arch supports it.

Thanks for doing this, David.  FWIW, for XFS its not directly a problem
today, we simply block attempts to mount filesystems on 32 bit systems
where the inums could get into the problematic ranges.  With several XFS
changes (main change will be switching to use iget5_locked) we will be
able to allow those mounts to go ahead - so, thanks again!

cheers.

-- 
Nathan
