Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTBGPN5>; Fri, 7 Feb 2003 10:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTBGPN5>; Fri, 7 Feb 2003 10:13:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45585 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265708AbTBGPN4>; Fri, 7 Feb 2003 10:13:56 -0500
Date: Fri, 7 Feb 2003 16:23:33 +0100
From: Jan Kara <jack@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some curiosities on the filesystems layout in kernel config
Message-ID: <20030207152333.GP24384@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell> <200301120649.h0C6nULE005008@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301120649.h0C6nULE005008@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 12 Jan 2003 01:00:40 EST, "Robert P. J. Day" <rpjday@mindspring.com>  said:
> 
> > 3) currently, since quotas are only supported for ext2, ext3 and
> >    reiserfs, shouldn't quotas depend on at least one of those
> >    being selected?
  Quotas work also for other filesystems...

> Because if we did that, we'd be setting ourselves up for a mess when
> fs/xfs/xfs_qm.c eventually shows up - like it already has ;)
> 
> Also, from my (possibly incorrect) reading of kernel/sys.c and
> fs/quota.c, there won't be a sys_quotactl() in the kernel.  As a
> result, if you have users who have 'quota -v' in their .login, things
> might get interesting.  So you might want a config where the quota
> system call is there, even if it doesn't do anything incredibly
> useful...
  You're right that it won't be in the kernel but in that case 'quota
-v' will just say 'Disk quotas for user test (uid 1000): none' (in case
you haven't any filesystem mounted with usrquota option which is
reasonable if you haven't quotas in kernel).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
