Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWHXMSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWHXMSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWHXMSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:18:33 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:58320 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751191AbWHXMSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:18:33 -0400
Subject: Motorola v360 external USB storage
From: Luca Corti <luca@leenoox.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:16:59 +0200
Message-Id: <1156421819.7974.5.camel@cdevo.cdlan.it>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got a Motorola v360 phone I can connect via USB to access its
Transflash storage. This works flawlessly under Windows, while under
linux 2.6.17 I can not mount it.

Froma quick search on the web I could not find anything relevant.

This is what I get in the logs:

Aug 24 13:11:25 cdevo kernel: [17182081.328000] ohci_hcd 0000:02:02.1:
wakeup
Aug 24 13:11:25 cdevo kernel: [17182081.712000] usb 3-1: new full speed
USB device using ohci_hcd and address 2
Aug 24 13:11:26 cdevo kernel: [17182081.940000] usb 3-1: configuration
#1 chosen from 2 choices
Aug 24 13:11:26 cdevo kernel: [17182082.180000] usbcore: registered new
driver libusual
Aug 24 13:11:26 cdevo kernel: [17182082.324000] SCSI subsystem
initialized
Aug 24 13:11:26 cdevo kernel: [17182082.332000] Initializing USB Mass
Storage driver...
Aug 24 13:11:26 cdevo kernel: [17182082.332000] scsi0 : SCSI emulation
for USB Mass Storage devices
Aug 24 13:11:26 cdevo kernel: [17182082.332000] usbcore: registered new
driver usb-storage
Aug 24 13:11:26 cdevo kernel: [17182082.332000] USB Mass Storage support
registered.
Aug 24 13:11:26 cdevo kernel: [17182082.332000] usb-storage: device
found at 2
Aug 24 13:11:26 cdevo kernel: [17182082.332000] usb-storage: waiting for
device to settle before scanning
Aug 24 13:11:31 cdevo kernel: [17182087.332000] usb-storage: device scan
complete
Aug 24 13:11:31 cdevo kernel: [17182087.424000]   Vendor: Motorola
Model: Motorola Phone    Rev: 2.31
Aug 24 13:11:31 cdevo kernel: [17182087.424000]   Type:   Direct-Access
ANSI SCSI revision: 02
Aug 24 13:11:32 cdevo kernel: [17182088.136000] SCSI device sda: 246017
512-byte hdwr sectors (126 MB)
Aug 24 13:11:32 cdevo kernel: [17182088.232000] sda: Write Protect is
off
Aug 24 13:11:32 cdevo kernel: [17182088.232000] sda: Mode Sense: 0b 00
00 08
Aug 24 13:11:32 cdevo kernel: [17182088.232000] sda: assuming drive
cache: write through
Aug 24 13:11:32 cdevo kernel: [17182088.284000] SCSI device sda: 246017
512-byte hdwr sectors (126 MB)
Aug 24 13:11:32 cdevo kernel: [17182088.296000] sda: Write Protect is
off
Aug 24 13:11:32 cdevo kernel: [17182088.296000] sda: Mode Sense: 0b 00
00 08
Aug 24 13:11:32 cdevo kernel: [17182088.296000] sda: assuming drive
cache: write through
Aug 24 13:11:32 cdevo kernel: [17182088.300000]  sda: sda1
Aug 24 13:11:32 cdevo kernel: [17182088.356000] sd 0:0:0:0: Attached
scsi removable disk sda
Aug 24 13:11:32 cdevo kernel: [17182088.396000] sd 0:0:0:0: Attached
scsi generic sg0 type 0
Aug 24 13:11:33 cdevo kernel: [17182089.380000] sd 0:0:0:0: SCSI error:
return code = 0x8000002
Aug 24 13:11:33 cdevo kernel: [17182089.380000] sda: Current: sense key:
Medium Error
Aug 24 13:11:33 cdevo kernel: [17182089.380000]     Additional sense: No
additional sense information
Aug 24 13:11:33 cdevo kernel: [17182089.380000] end_request: I/O error,
dev sda, sector 245953
Aug 24 13:11:33 cdevo kernel: [17182089.380000] Buffer I/O error on
device sda1, logical block 245856
Aug 24 13:11:33 cdevo kernel: [17182089.528000] sd 0:0:0:0: SCSI error:
return code = 0x8000002
Aug 24 13:11:33 cdevo kernel: [17182089.528000] sda: Current: sense key:
Medium Error
Aug 24 13:11:33 cdevo kernel: [17182089.528000]     Additional sense: No
additional sense information
Aug 24 13:11:33 cdevo kernel: [17182089.528000] end_request: I/O error,
dev sda, sector 245954
Aug 24 13:11:33 cdevo kernel: [17182089.528000] Buffer I/O error on
device sda1, logical block 245857
Aug 24 13:11:34 cdevo kernel: [17182089.760000] sd 0:0:0:0: SCSI error:
return code = 0x8000002
Aug 24 13:11:34 cdevo kernel: [17182089.760000] sda: Current: sense key:
Medium Error
Aug 24 13:11:34 cdevo kernel: [17182089.760000]     Additional sense: No
additional sense information
Aug 24 13:11:34 cdevo kernel: [17182089.760000] end_request: I/O error,
dev sda, sector 245955
Aug 24 13:11:34 cdevo kernel: [17182089.760000] Buffer I/O error on
device sda1, logical block 245858
Aug 24 13:11:34 cdevo kernel: [17182089.908000] sd 0:0:0:0: SCSI error:
return code = 0x8000002
Aug 24 13:11:34 cdevo kernel: [17182089.908000] sda: Current: sense key:
Medium Error
Aug 24 13:11:34 cdevo kernel: [17182089.908000]     Additional sense: No
additional sense information
Aug 24 13:11:34 cdevo kernel: [17182089.908000] end_request: I/O error,
dev sda, sector 245956
Aug 24 13:11:34 cdevo kernel: [17182089.908000] Buffer I/O error on
device sda1, logical block 245859

I am willing to test any patch if you happen to need it.

thanks

