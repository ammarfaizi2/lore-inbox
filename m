Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTDHSZJ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 14:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbTDHSZJ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 14:25:09 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:36296 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261492AbTDHSZI (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 14:25:08 -0400
From: Scott Lee <scottlee@redhot.rose.hp.com>
Message-Id: <200304081836.LAA26103@redhot.rose.hp.com>
Subject: Re: Debugging hard lockups (hardware?)
To: linux-kernel@vger.kernel.org
Date: Tue, 8 Apr 2003 11:36:44 -0700 (PDT)
X-Mailer: ELM [$Revision: 1.17.214.2 $]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too am experiencing hard lockups.  

I'm using 2.4.18-rc1-ac2 (2.4.18-18.7.x) on multiple units with fairly uniform HW.   (HW differences being PGA vs BGA processor and RAM/HD size.)  Because of the stage of software development I'm not really able roll the kernel.  It seems unlikely that it is bad hardware because it is happening on multiple units and those same units are rock solid if running older (2.0 kernel) based firmware.

Unfortunately I'm on a National GX1 processor so I don't have NMI capability.  The lockups are very sporatic and can not be reproduced at will.  Additionally most of the units are headless which complicates matters.  I've looked at the state of SUSPA# on a locked up box and it is not asserted which indicates that the CPU is not halted.  I can't be 100% sure but it looks like the only memory activity is refresh related so it seems like the CPU is in a loop that runs out of its puny 16K unified cache.

Since this is an embedded device it is running a fairly stripped kernel.  I suppose I can post the config if necessary but it's basically using ide, ext3, and pcnet32.  (Yes I know about the ext3 patches but they don't seem to help in my case.)

Also, recently, Jerry Carter (of Samba) has asked me for some help regarding one of his personal systems as he too is seeing hard lockups.  He hasn't yet had time to try the nmi_watchdog but I'll prod him some more on this.  His system has a SiS 730 chipset with Athlon 200XP+ and Promise IDE ultra 100 controller.  He has ATI Rage II PCI video but he has also seen the problem when using the onboard video.  As for kernels he is using 2.4.20 and has seen the problem w/ and w/o the ext3 patches and acl patches.  Additionally, he reverted his fs to ext2 at one point and still saw the problem.  He generally sees the problem when playing back mp3s but it has happened at other times.

Regards,

Scott Lee
