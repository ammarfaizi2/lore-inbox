Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWCFL4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWCFL4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCFL4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:56:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751278AbWCFL4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:56:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060304041647.6894ca62.akpm@osdl.org> 
References: <20060304041647.6894ca62.akpm@osdl.org>  <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #3] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Mon, 06 Mar 2006 11:55:54 +0000
Message-ID: <29932.1141646154@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> The same happens with just #1 and #2 applied.  The .config is at
> http://www.zip.com.au/~akpm/linux/patches/stuff/config-vmm.

Just #1 and #2? That's decidedly odd.

Also odd is that it's _nfsd_ that's affected, not nfs. It also affects
binfmt_misc, so it appears that it's something to do with get_sb_single(), and
looking at that function, I can sort of see why it might be. I'll look into it further.

> The kernel won't compile with just patch #1 applied.  Patches shouldn't go
> into git in that manner.

It's easier to review them in that manner. If you don't think git is up to it,
then combine them.

David
