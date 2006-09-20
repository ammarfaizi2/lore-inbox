Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWITS6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWITS6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWITS6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:58:14 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:37019 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S932263AbWITS6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:58:06 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: Very slow write on flash drive in sync mode???
Date: Wed, 20 Sep 2006 20:58:05 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202058.05816.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use SanDisk cruzer Titanium 2 GB mounted as sync in fstab

usb 4-2: new high speed USB device using ehci_hcd and address 5
usb 4-2: configuration #1 chosen from 1 choice
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
  Vendor: SanDisk   Model: U3 Titanium       Rev: 2.16
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 4001425 512-byte hdwr sectors (2049 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 4001425 512-byte hdwr sectors (2049 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
 sda: sda1
sd 1:0:0:0: Attached scsi removable disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
  Vendor: SanDisk   Model: U3 Titanium       Rev: 2.16
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 8x/40x writer xa/form2 cdda tray
sr 1:0:0:1: Attached scsi CD-ROM sr0
sr 1:0:0:1: Attached scsi generic sg1 type 5
usb-storage: device scan complete

/dev/sda1       /mnt/cruzer_sync      vfat    user,noauto,sync                
0       0
/dev/sda1       /mnt/cruzer     auto    user,noauto             0       0


When I use flash drive in sync mode, it writes on it only 64kB/s. When I 
umount it and mount it in not sync mode but do sync manually after it writes 
into memory, kernel writes on flash drive 11 MB/s!!! What is wrong in my 
configuration?

Kernel 2.6.18, Debian testing

Thanks for help

Michal
