Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132711AbRDCXAd>; Tue, 3 Apr 2001 19:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132713AbRDCXAW>; Tue, 3 Apr 2001 19:00:22 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:16627 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132711AbRDCXAJ>; Tue, 3 Apr 2001 19:00:09 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104032236.f33Ma6Y17555@webber.adilger.int>
Subject: Re: Question about SysRq
In-Reply-To: <20010404023911.A1260@Boris> from Boris Pisarcik at "Apr 4, 2001
 02:39:11 am"
To: Boris Pisarcik <boris@acheron.sk>
Date: Tue, 3 Apr 2001 16:36:06 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> Can you anyhow find something in your logs/console/serial console messages
> like 13.13.2000 kernel : Sysrq: Emergency Sync (this should be present - is 
> written within keyboard handler, not after shedule) and what's next logs ?
> We could determine, if the bdflush thread got scheduled and called emergency 
> syncing routine indeed.

It sounds like the kernel is stuck somewhere in a tight loop, so nothing
is being rescheduled.  If you have an SMP system (or an APIC) you may be
able to see where it is stuck with the NMI watchdog timer.

> Quick help against those corruptions, which comes on my mind, is use
> the reiserfs. I have no real experiences with that and its reliability,
> also as aj followed some of messages in this list about resierfs - it has
> some problems too - but in definition it shoudn't get corrupted by not-
> syncing reboot.

Actually, this is not true.  Reiserfs will only prevent corruption of the
filesystem metadata.  It does not guarantee that the file contents are
valid if they are being changed when the system crashes.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
