Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWEYVKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWEYVKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEYVKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:10:19 -0400
Received: from agmk.net ([217.73.31.34]:61970 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1751258AbWEYVKS (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Thu, 25 May 2006 17:10:18 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kerneL@vger.kernel.org
Subject: [USB disks] FAT: invalid media value (0x01)
Date: Thu, 25 May 2006 23:10:00 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200605252310.00568.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have two usb devices: photo camera (nikkon d70s)
and mobile phone (motorola e398). Both have worked perfect with 2.6.14.7.
With recent 2.6.16.18 none of them work, e.g.:

(...)
usb 2-4: new full speed USB device using ohci_hcd and address 15
usb 2-4: configuration #1 chosen from 1 choice
scsi11 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 15
usb-storage: waiting for device to settle before scanning
  Vendor: Motorola  Model: Motorola Phone    Rev: 2.31
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdc: 121857 512-byte hdwr sectors (62 MB)
sdc: Write Protect is off
sdc: Mode Sense: 0b 00 00 08
sdc: assuming drive cache: write through
SCSI device sdc: 121857 512-byte hdwr sectors (62 MB)
sdc: Write Protect is off
sdc: Mode Sense: 0b 00 00 08
sdc: assuming drive cache: write through
 sdc: sdc1
sd 11:0:0:0: Attached scsi removable disk sdc
usb-storage: device scan complete
FAT: invalid media value (0x01)
VFS: Can't find a valid FAT filesystem on dev sdc.

I've checked the FAT table and everything looks fine.

00000000  eb 3c 90 4d 53 44 4f 53  35 2e 30 00 02 08 01 00  |.<.MSDOS5.0.....|
00000010  02 00 02 00 00 f8 3c 00  20 00 08 00 20 00 00 00  |......<. ... ...|
                         ^^ fixed disk.
00000020  e0 da 01 00 80 00 29 01  d0 c3 14 53 41 4e 56 4f  |......)....SANVO|
00000030  4c 20 20 20 20 20 46 41  54 31 36 20 20 20 7c 8e  |L     FAT16   |.|
00000040  c0 8e d8 fb fc be 6a 00  81 c6 00 7c ac 0a c0 74  |......j....|...t|
00000050  0a b4 0e b7 00 b3 07 cd  10 eb f1 33 c0 cd 16 cd  |...........3....|
00000060  19 be b3 00 81 c6 00 7c  eb e2 0d 0a 4e 6f 6e 2d  |.......|....Non-|
00000070  53 79 73 74 65 6d 20 64  69 73 6b 20 6f 72 20 64  |System disk or d|
00000080  69 73 6b 20 65 72 72 6f  72 0d 0a 52 65 70 6c 61  |isk error..Repla|
00000090  63 65 20 61 6e 64 20 73  74 72 69 6b 65 20 61 6e  |ce and strike an|
000000a0  79 20 6b 65 79 20 77 68  65 6e 20 72 65 61 64 79  |y key when ready|
000000b0  0d 0a 00 0d 0a 44 69 73  6b 20 42 6f 6f 74 20 66  |.....Disk Boot f|
000000c0  61 69 6c 75 72 65 0d 0a  00 00 00 00 00 00 00 00  |ailure..........|
000000d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|

Linux vmx 2.6.16.18-1 #1 Mon May 22 22:04:24 UTC 2006 x86_64
AMD_Athlon(tm)_64_Processor_3700+ unknown PLD Linux

Any ideas?

Regards,
Paweł.
