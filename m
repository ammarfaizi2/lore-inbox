Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTGNUNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270791AbTGNUDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:03:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33589 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270754AbTGNUBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:01:24 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307142016.h6EKGDe02631@devserv.devel.redhat.com>
Subject: Linux 2.6.0-test1-ac1
To: linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2003 16:16:12 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Linus is in hiding this is a collected set of diffs I'm using
right now. It has the worst of the current security stuff I know about 
fixed up but I've not looked into older stuff yet. Also a few things
I needed for my test hardware that went walkins like Zoom Video.

2.6.0-test1-ac1
	Merge Linus 2.6.0-test1
	Revert bogus changes to 3c574/3c589_cs
	Revert tcic removals (Linus comment is wrong - we know why and
	fixes are out 8))
	Revert Linus broken spelling change (it is separate)
	[Cite: Oxford English Dictionary]
	Revert btaudio change (my fault - btaudio
	memsets the struct)
o	sethostname and friends corrupted their data	(Stephan Maciej)
	on -EFAULT returns
o	Fix exec elf loader bugs/holes			(me)
o	Fix environ race crash				(me)
o	Fix various proc leaks of data			(Solar Designer)
o	Fix new style serial driver leaks of data	(me)
	| Found by Solar Designer, someone needs to fix other old style
	| drivers
o	Fix incorrect credits for ad1980 plugin		(me)
o	Fix license text for Kalhua driver		(me)
o	Fix make rpm					(Nathan Fredrickson)
o	Fix qla1280 corruption				(Arjan van de Ven)
o	Ad1889 clean up fix				(Fracois Romieu)
o	Remove ip2 dead wood				(Adrian Bunk)
o	Remove pcxx dead wood				(Adrian Bunk)
o	Fix watchdog warnings				(Jan Dittmer)
o	Device mapper updates				(Joe Thornber)
o	Update magic numbers table			(Fabian Frederick)
o	Fix logo bitdepth check				(Bob Tracy)
o	Fix sock done handling				(Jamie Lokier)
o	RLIMIT_NPROC fixes				(Neil Brown)
o	Fix xjack dependancies				(Adrian Bunk)
o	Remove dead serial stuff			(Adrian Bunk)
o	Add support for 82801EB/ER TCO timer		(Wim Van Sebroeck)
o	Backport ZoomVideo PCMCIA support		(me)
o	Backport fixes for yenta socket hang		(me)
o	Fix isapnp check_region abuse			(me)
o	Fix the sym53c8xx irq handler types		(me)
o	Fix aha1542 warnings				(me)
o	Remove escaped MOD_INC_USE_COUNT in cs5520	(me)
o	Fix pas16 and qlogicfas DMA warnings		(me)
o	Remove warnings in phonedev			(me)
	| Still need to make it lock the called module
o	Fix up ni65 driver				(me)

2.5.75-ac (never released) differences remaining unmerged
o	Possible sedlbauer fix				(me)
o	WM97xx touchscreen plugins			(Liam Girdwood)
o	CS4281 fixes for new audio (incomplete)		(me)
o	HAL2 OSS driver					(Ladislav Michl)
o	Harmony OSS driver	(Jean-Christoph Vaugeois, Matthieu Delahaye,
				 Helge Deller, Alex deVries)
o	Cyrix Kahlua audio driver			(me)

Stuff on the todo list
	Forward port aacraid fixes
	Forward port 82092 updates
	Check xjack is in sync
	Fix phonedev/xjack module handling
	Who broke NCR5380 again, more importantly how this time...
	Final sound polish and commit to mark OSS down as done for 2.6
	Look at the horribly out of date 2.5 DRM layer
	Investigate where some of the framebuffers from 2.4 vanished (eg
		stifb)
	Plip appears short 2.4 fixes
	hfsplus is still 2.4 only too
