Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUKGJFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUKGJFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 04:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUKGJFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 04:05:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:51154 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261561AbUKGJEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 04:04:34 -0500
From: =?iso-8859-1?q?J=F6rg_Spilker?= <js@jetsys.de>
Organization: JetSys
To: linux-kernel@vger.kernel.org
Subject: Apple Ipod doesn't work with USB on linux (but works with FireWire)
Date: Sun, 7 Nov 2004 10:04:14 +0100
User-Agent: KMail/1.7.1
Cc: linux-usb-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411071004.15605.js@jetsys.de>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.28.0.12; VDF: 6.28.0.59; host: daolin)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6a16b48ab260b2defb04d898181c7cb6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i recently purchased a new Ipod Mini which i initially used via Firewire on my Laptop with windows.
Then i tried to change to Linux (using gtkpod for managing my playlists). Because i want to leave the
firewire cable connected to the laptop, i tried using the USB variant on Linux. My first try was with
SuSE 9.0 and a 2.4.x kernel. Unfortunately with no success. Same errors as you see here (now with
SuSE 9.2 and kernel 2.6.8).

Nov  7 00:45:17 lotus kernel: usb 4-5: new high speed USB device using address 8
Nov  7 00:45:17 lotus kernel: usb 4-5: Product: iPod mini
Nov  7 00:45:17 lotus kernel: usb 4-5: Manufacturer: Apple
Nov  7 00:45:17 lotus kernel: usb 4-5: SerialNumber: 0000009056D9
Nov  7 00:45:17 lotus kernel: scsi4 : SCSI emulation for USB Mass Storage devices
Nov  7 00:45:17 lotus kernel:   Vendor: Apple     Model: iPod              Rev: 1.61
Nov  7 00:45:17 lotus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Nov  7 00:45:18 lotus kernel: SCSI device sda: 7999488 512-byte hdwr sectors (4096 MB)
Nov  7 00:45:18 lotus kernel: sda: Write Protect is off
Nov  7 00:45:18 lotus kernel: sda: Mode Sense: 64 00 00 08
Nov  7 00:45:18 lotus kernel: sda: assuming drive cache: write through
Nov  7 00:45:18 lotus kernel:  sda:end_request: I/O error, dev sda, sector 7999480
Nov  7 00:45:18 lotus kernel: Buffer I/O error on device sda, logical block 999935
Nov  7 00:45:18 lotus kernel: end_request: I/O error, dev sda, sector 7999480
Nov  7 00:45:18 lotus kernel: Buffer I/O error on device sda, logical block 999935
Nov  7 00:45:18 lotus kernel:  sda1 sda2
Nov  7 00:45:18 lotus kernel: Attached scsi removable disk sda at scsi4, channel 0, id 0, lun 0
Nov  7 00:45:18 lotus kernel: Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
Nov  7 00:45:18 lotus kernel: USB Mass Storage device found at 8
Nov  7 00:45:28 lotus /etc/dev.d/block/50-hwscan.dev[17084]: new block device /block/sda/sda1
Nov  7 00:45:28 lotus /etc/dev.d/block/50-hwscan.dev[17085]: new block device /block/sda/sda2
Nov  7 00:45:28 lotus /etc/dev.d/block/51-subfs.dev[17100]: mount block device /block/sda/sda1
Nov  7 00:45:28 lotus /etc/dev.d/block/51-subfs.dev[17105]: mount block device /block/sda/sda2
Nov  7 00:45:28 lotus kernel: end_request: I/O error, dev sda, sector 80325
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 0
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 1
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 2
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 3
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 4
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 5
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 6
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 7
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 8
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 9
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 10
Nov  7 00:45:28 lotus kernel: Buffer I/O error on device sda2, logical block 11

so i removed the firewire cable from the laptop and attached it to my workstation. As you can 
see everything is fine now. I suspect it has something to do with the usb mass storage
driver. 

Nov  7 07:37:24 lotus kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Nov  7 07:37:26 lotus kernel: ieee1394: Node changed: 0-01:1023 -> 0-00:1023
Nov  7 07:37:28 lotus kernel: ohci1394: fw-host0: SelfID received, but NodeID invalid (probably new bus reset occurred): 0800FFC0
Nov  7 07:37:28 lotus kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Nov  7 07:37:31 lotus kernel: ieee1394: Node added: ID:BUS[0-00:1023]  GUID[000a2700029056d9]
Nov  7 07:37:36 lotus /sbin/hotplug[4751]: ... no drivers for IEEE1394 product 0x/0x/0x
Nov  7 07:37:36 lotus /sbin/hotplug[4777]: ... no drivers for IEEE1394 product 0x/0x/0x
Nov  7 07:37:37 lotus kernel: sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
Nov  7 07:37:37 lotus kernel: scsi5 : SCSI emulation for IEEE-1394 SBP-2 Devices
Nov  7 07:37:38 lotus kernel: ieee1394: sbp2: Logged into SBP-2 device
Nov  7 07:37:38 lotus kernel: ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
Nov  7 07:37:38 lotus kernel:   Vendor: Apple     Model: iPod              Rev: 1.61
Nov  7 07:37:38 lotus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Nov  7 07:37:38 lotus kernel: SCSI device sda: 7999488 512-byte hdwr sectors (4096 MB)
Nov  7 07:37:38 lotus kernel: sda: Write Protect is off
Nov  7 07:37:38 lotus kernel: sda: Mode Sense: 04 00 00 00
Nov  7 07:37:38 lotus kernel: SCSI device sda: drive cache: write through
Nov  7 07:37:38 lotus kernel:  sda:end_request: I/O error, dev sda, sector 7999480
Nov  7 07:37:38 lotus kernel: Buffer I/O error on device sda, logical block 999935
Nov  7 07:37:39 lotus kernel: end_request: I/O error, dev sda, sector 7999480
Nov  7 07:37:39 lotus kernel: Buffer I/O error on device sda, logical block 999935
Nov  7 07:37:39 lotus kernel:  sda1 sda2
Nov  7 07:37:39 lotus kernel: Attached scsi removable disk sda at scsi5, channel 0, id 0, lun 0
Nov  7 07:37:39 lotus kernel: Attached scsi generic sg0 at scsi5, channel 0, id 0, lun 0,  type 0
Nov  7 07:37:48 lotus /etc/dev.d/block/50-hwscan.dev[5078]: new block device /block/sda/sda1
Nov  7 07:37:48 lotus /etc/dev.d/block/50-hwscan.dev[5079]: new block device /block/sda/sda2
Nov  7 07:37:48 lotus /etc/dev.d/block/50-hwscan.dev[5080]: new block device /block/sda
Nov  7 07:37:48 lotus /etc/dev.d/block/51-subfs.dev[5091]: mount block device /block/sda/sda1
Nov  7 07:37:48 lotus /etc/dev.d/block/51-subfs.dev[5101]: mount block device /block/sda/sda2
Nov  7 07:37:48 lotus /etc/dev.d/block/51-subfs.dev[5167]: mount block device /block/sda
Nov  7 07:37:59 lotus /etc/dev.d/block/51-subfs.dev[5101]: mount disk/by-path/ieee1394-000a2700029056d9-0-0p2
Nov  7 07:41:24 lotus kernel: ieee1394: Node changed: 0-01:1023 -> 0-00:1023
Nov  7 07:41:24 lotus kernel: ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[000a2700029056d9]
Nov  7 07:41:34 lotus /etc/dev.d/block/51-subfs.dev[6235]: umount block device /block/sda/sda1
Nov  7 07:41:34 lotus /etc/dev.d/block/51-subfs.dev[6276]: umount block device /block/sda
Nov  7 07:41:34 lotus /etc/dev.d/block/51-subfs.dev[6251]: umount block device /block/sda/sda2
Nov  7 07:41:34 lotus /etc/dev.d/block/51-subfs.dev[6235]: umount: /dev/sda1: not mounted
Nov  7 07:41:35 lotus /etc/dev.d/block/51-subfs.dev[6276]: umount: /dev/sda: not mounted

so any idea why the Ipod is not working as a storage device?  Other devices like my digicam
(USB 1.0) are working as storage device.

Greetings, Joerg
