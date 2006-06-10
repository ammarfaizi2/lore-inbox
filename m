Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWFJQG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWFJQG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWFJQG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:06:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751531AbWFJQG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:06:58 -0400
Date: Sat, 10 Jun 2006 17:05:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Gerrit Huizenga <gh@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610160558.GA20471@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
	Gerrit Huizenga <gh@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
	Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com> <20060610134645.GB11634@stusta.de> <20060610144228.GA6416@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610144228.GA6416@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 04:42:28PM +0200, Ingo Molnar wrote:
> Even ignoring all those arguments, i find your "ext3/ext4 is too 
> complex, use XFS or JFS" argument a bit naive. Please take a quick look 
> at the linecount of the filesystems in question:

That isn't interesting at all.  There's a lot more interesting features
in jfs and xfs.  XFS is still quite bloated even compared to it's features,
but it's doing much more than just and ext3+extents.  At a smaller scale
that's true for jfs aswell.

As mentioned a few times below just getting over the 8TB barrier is far
from enough forthe next gen linux filesystems.  XFS already goes on to
address the Petabyte barrier.  It's not like it couldn't address Petabytes
of storage from the very beginning but you have such problems as needing
a parallel fsck, fault tolerance, lots of parallelism in the filesystem
and things like delayed allocations to hit linerate on dozends of FC HBAs
in the system.

And not, I don't want to bitch about ext3, it's doing good work for my
on most of my machines, but it's definitly not what I would want to
scale to really large filesystems.  It's UFS done right, but the time
of UFS derivates is slowly passing.
