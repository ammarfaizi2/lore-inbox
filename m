Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUKZXyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUKZXyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbUKZTk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:40:58 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262455AbUKZT1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:49 -0500
Date: Fri, 26 Nov 2004 09:35:04 +1100
From: Nathan Scott <nathans@sgi.com>
To: Anders Saaby <as@cohaesio.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.9 Oops: Major problems with XFS and ext3 (VFS related?)
Message-ID: <20041125223504.GA953@frodo>
References: <200411241812.33529.as@cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411241812.33529.as@cohaesio.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 06:12:33PM +0100, Anders Saaby wrote:
> Hi Lists, (XFS list CC'ed)

Hi there,

> Here is the cituation:
> We have a high-load mailserver serving IMAP from Maildirs. We originally had 
> the maildirs on ext3 but the kernel eventually Oopsed every ~20 hours (Oops - 
> included) - we then moved the Maildirs to XFS thinking the problems where 
> history, but now we get a somewhat similar error from XFS (inluded). They 
> both look like a race to me but I am not able to get more out of it.
> ...
> Here is what XFS says:
> <SNIP>
> Filesystem "sdb1": xfs_trans_delete_ail: attempting to delete a log item that 
> is not in the AIL
> xfs_force_shutdown(sdb1,0x8) called from line 382 of file 
> fs/xfs/xfs_trans_ail.c.  Return address = 0xc0216a56
> @Linux version 2.6.9 (root@mail1.domain.tld) (gcc version 2.96 20000731 (Red 
> Hat Linux 7.3 2.96-113)) #1 SMP Tue Oct 19 16:04:55 CEST 2004
> ...
> I will be happy to supply any info and do some testing - if anyone catches 
> interest! :-)

Yep, very interested.  So, "serving IMAP from Maildirs" - from
the filesystems perspective, can you describe that in detail for
me?  I would guess that means a shallow directory tree, with quite
large directories (how large?) and many (how many?) small files?
(how small on average?)  How frequently are files added/removed?

Is this easily reproducible for you?  If so, can you send me
enough details that I can try to reproduce it locally?

thanks.

-- 
Nathan
