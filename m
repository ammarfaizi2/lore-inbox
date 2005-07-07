Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVGGUJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVGGUJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVGGUJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:09:41 -0400
Received: from mail.cable4u.nl ([62.145.212.5]:51345 "EHLO midget.cable4u.nl")
	by vger.kernel.org with ESMTP id S261387AbVGGUJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:09:31 -0400
Message-ID: <42CD8AF6.2000106@Cable4U.nl>
Date: Thu, 07 Jul 2005 22:05:10 +0200
From: Martijn Ras <Martijn.Ras@Cable4U.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Martijn.Ras@Cable4U.nl
Subject: E-IDE probing succeeds at first, then fails ...
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heya Folks,

I just started using kernel version 2.6.12.2 and am noticing new
unexpected behaviour of my E-IDE system. The system is more I/O bound
locking briefly from time, than it is with older kernel versions and
swamping the logs with ATAPI errors. The problems is most noticeable in
playing songs from the hard disk, there's a lot of short pauses/hickups
at the moments the system freezes.

Strangest of all is the first probing of the IDE interface ide0
returning all models absolutely correct, as shown by this excerpt from
dmesg:

[   29.597238] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   29.597241] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[   29.597647] Probing IDE interface ide0...
[   29.861673] hda: SAMSUNG SP8004H, ATA DISK drive
[   30.116620] hdb: ARW4424P, ATAPI CD/DVD-ROM drive
[   30.167415] Probing IDE interface ide1...
[   30.431620] hdc: IOMEGA ZIP 250 ATAPI, ATAPI CD/DVD-ROM drive
[   31.146410] hdd: IDE/ATAPI CD-ROM 50XS, ATAPI CD/DVD-ROM drive
[   31.198202] Probing IDE interface ide2...
[   31.711095] Probing IDE interface ide3...
[   32.222989] Probing IDE interface ide4...
[   32.735886] Probing IDE interface ide5...
[   33.248806] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   33.248835] ide1 at 0x170-0x177,0x376 on irq 15
[   33.249652] hda: max request size: 128KiB
[   33.251923] hda: 156368016 sectors (80060 MB) w/2048KiB Cache,
CHS=65535/16/63
[   33.251995] hda: cache flushes supported
[   33.252059]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   33.293237] hdb: ATAPI 17X DVD-ROM DVD-R-RAM CD-R/RW changer w/187
slots, 48059kB Cache
[   33.293245] Uniform CD-ROM driver Revision: 3.20
[   33.298027] ATAPI device hdb:
[   33.298029]   Unknown Error Type: Aborted command -- (Sense key=0x0b)
[   33.298033]   (vendor-specific error) -- (asc=0xbb, ascq=0xbb)
[   33.298054]   The failed "Read Cd/Dvd Capacity" packet command was:
[   33.298055]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
[   33.302393] hdc: packet command error: status=0x51 { DriveReady
SeekComplete Error }
[   33.302399] hdc: packet command error: error=0x50 {
LastFailedSense=0x05 }
[   33.302402] ide: failed opcode was: unknown
[   33.304502] hdc: packet command error: status=0x51 { DriveReady
SeekComplete Error }
[   33.304506] hdc: packet command error: error=0x50 {
LastFailedSense=0x05 }
[   33.304508] ide: failed opcode was: unknown
[   33.312088] hdd: ATAPI 11X CD-ROM drive, 128kB Cache

Have any of you experienced similar things, and perhaps come up with a
solution?

In case more information is needed, please let me know so i can provide it.

Mazzel,

Martijn.
P.S. I'd appreciate responses to this message being CC-ed to me.
