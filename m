Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUFIAdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUFIAdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUFIAdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:33:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:18677 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265483AbUFIAdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:33:01 -0400
Date: Wed, 9 Jun 2004 10:32:52 +1000
From: Nathan Scott <nathans@sgi.com>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Increasing number of inodes after format?
Message-ID: <20040609103252.H1200131@wobbly.melbourne.sgi.com>
References: <40C62F2F.4090801@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40C62F2F.4090801@techsource.com>; from miller@techsource.com on Tue, Jun 08, 2004 at 05:27:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 05:27:11PM -0400, Timothy Miller wrote:
> I was involved in a discussion a while back where it was explained that 
> ext2/3 allocate a certain maximum number of inodes at format time, and 
> you cannot increase that number later.
> 
> It was also mentioned that one or more of the journaling file systems 
> (XFS, JFS, Reiser, etc.) either dynamically allocated inodes or could 
> increase the maximum later if the pre-allocated set got used up.
> 
> Could someone please repeat for me which filesystems have dynamic 
> maximum inode counts?

XFS does dynamic inode allocation, there is no preallocated set.
Steve also recently implemented dynamic space reclaim for ondisk
inode clusters too, once they're no longer used.  XFS puts a cap
on the amount of space that can be used for inodes at mkfs time
(25% iirc), and this can be adjusted later via "xfs_growfs -m".

I don't know enough about the other filesystems to answer for them
though.

cheers.

-- 
Nathan
