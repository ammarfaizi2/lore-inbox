Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbTCZBUh>; Tue, 25 Mar 2003 20:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264547AbTCZBUh>; Tue, 25 Mar 2003 20:20:37 -0500
Received: from adsl-67-117-70-243.dsl.sntc01.pacbell.net ([67.117.70.243]:12162
	"HELO top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S263230AbTCZBUg>; Tue, 25 Mar 2003 20:20:36 -0500
From: brian@worldcontrol.com
Date: Wed, 26 Mar 2003 01:30:27 -0800
To: linux-kernel@vger.kernel.org
Subject: Can't recover from broken ext3 journal
Message-ID: <20030326093027.GA14108@localhost.localdomain>
Mail-Followup-To: Brian Litzinger <brian@localhost.localdomain>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a harddrive develop hard IO errors in the section of the drive
that holds the ext3 journal.

If it try to fsck the filesystem, fsck eventually terminates after
trying to replay the journal.

I tried to use debugfs but that fails in similar way.

When I use tune2fs to try to turn off the journal, even with
the -f option, it simply reports 'the needs_recovery flag is
set, please run e2fsck'.

I've replaced the drive and restored from backups, however, it seems
rather poor design that I should lose *all* my data on the drive simply
because the journal won't replay due to an disk error.

The man pages for 'tune2fs' even implies you can use it for
the very purpose of removing a broken journal but it doesn't
work, as I reported above.

I could comment out the check in the tune2fs source code, however, is
there a proper way to do this?

Thanks,

-- 
Brian Litzinger
