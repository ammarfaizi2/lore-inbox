Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTBOSpl>; Sat, 15 Feb 2003 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTBOSpl>; Sat, 15 Feb 2003 13:45:41 -0500
Received: from adsl-64-168-240-37.dsl.sntc01.pacbell.net ([64.168.240.37]:30446
	"EHLO porky.localdomain") by vger.kernel.org with ESMTP
	id <S264863AbTBOSpk>; Sat, 15 Feb 2003 13:45:40 -0500
Date: Sat, 15 Feb 2003 12:03:05 -0800
From: Brian Craft <bcboy@thecraftstudio.com>
To: linux-kernel@vger.kernel.org
Subject: ide cdrom problem, cured by reboot
Message-ID: <20030215200305.GA2387@porky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ide dvd drive on my system is getting into an unusable state, which is cured
by reboot. When it's mucked up, I get endless messages as follows, and
processes accessing the drive remain in uninterruptable sleep for several
minutes.

Feb 15 01:00:58 porky kernel: hdd: ATAPI reset complete
Feb 15 01:01:07 porky kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Feb 15 01:01:07 porky kernel: hdd: cdrom_decode_status: error=0x30
Feb 15 01:01:15 porky kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Feb 15 01:01:15 porky kernel: hdd: cdrom_decode_status: error=0x30
Feb 15 01:01:23 porky kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Feb 15 01:01:23 porky kernel: hdd: cdrom_decode_status: error=0x30
Feb 15 01:01:23 porky kernel: hdd: ATAPI reset complete

The drive remains unusable until reboot. I've tried reloading the kernel
modules (cdrom, ide-cd) and issuing "hdparm -w", both of which have no effect.
Momentarily ejecting the disc sometimes allows it to work for a bit, but
rebooting seems to be the best workaround.
 
I see in the archive that there have been posts about these error messages, but
I didn't find any replies that address them. Is there a faq somewhere that
covers this?

The kernel is the redhat kernel-smp-2.4.18-24.8.0 release. The mainboard is an
Asus P2B-D (IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 1)).

Any ideas?

b.c.
