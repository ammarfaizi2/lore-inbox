Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWDEWTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWDEWTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWDEWTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:19:53 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:7116 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932106AbWDEWTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:19:53 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: USB 2.0 CF card reader gets reset+offlined immediately with 2.6.16
Date: Thu, 6 Apr 2006 00:12:04 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604060012.04300.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to use a USB 2.0 CF card reader in 2.6.16 and 2.6.16-mm2 (known to 
work back in 2.4 days, unused since) results in this:

usb 1-6: new high speed USB device using ehci_hcd and address 2
usb 1-6: new device found, idVendor=0dda, idProduct=2005
usb 1-6: new device strings: Mfr=3, Product=4, SerialNumber=5
usb 1-6: Product: Card Reader
usb 1-6: Manufacturer: Hama
usb 1-6: SerialNumber: 000000000013
usb 1-6: configuration #1 chosen from 1 choice
usbcore: registered new driver libusual
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
  Vendor: Hama      Model: CF  Card Reader   Rev: 9317
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sda : READ CAPACITY failed.
sda : status=0, message=00, host=1, driver=00
sda : sense not available.
sd 0:0:0:0: rejecting I/O to offline device
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
sd 0:0:0:0: Attached scsi removable disk sda
  Vendor: Hama      Model: SM  Card Reader   Rev: 9317
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
sd 0:0:0:1: scsi: Device offlined - not ready after error recovery
sd 0:0:0:1: rejecting I/O to offline device
sd 0:0:0:1: rejecting I/O to offline device
sd 0:0:0:1: rejecting I/O to offline device
sdb : READ CAPACITY failed.
sdb : status=0, message=00, host=1, driver=00
sdb : sense not available.
sd 0:0:0:1: rejecting I/O to offline device
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
sdb: assuming drive cache: write through
sd 0:0:0:1: Attached scsi removable disk sdb
usb 1-6: reset high speed USB device using ehci_hcd and address 2
  Vendor: Hama      Model: SD  Card Reader   Rev: 9317
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
sd 0:0:0:2: scsi: Device offlined - not ready after error recovery
sd 0:0:0:2: rejecting I/O to offline device
sd 0:0:0:2: rejecting I/O to offline device
sd 0:0:0:2: rejecting I/O to offline device
sdc : READ CAPACITY failed.
sdc : status=0, message=00, host=1, driver=00
sdc : sense not available.
sd 0:0:0:2: rejecting I/O to offline device
sdc: Write Protect is off
sdc: Mode Sense: 00 00 00 00
sdc: assuming drive cache: write through
sd 0:0:0:2: Attached scsi removable disk sdc
usb 1-6: reset high speed USB device using ehci_hcd and address 2
  Vendor: Hama      Model: MS  Card Reader   Rev: 9317
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
usb 1-6: reset high speed USB device using ehci_hcd and address 2
sd 0:0:0:3: scsi: Device offlined - not ready after error recovery
sd 0:0:0:3: rejecting I/O to offline device
sd 0:0:0:3: rejecting I/O to offline device
sd 0:0:0:3: rejecting I/O to offline device
sdd : READ CAPACITY failed.
sdd : status=0, message=00, host=1, driver=00
sdd : sense not available.
sd 0:0:0:3: rejecting I/O to offline device
sdd: Write Protect is off
sdd: Mode Sense: 00 00 00 00
sdd: assuming drive cache: write through
sd 0:0:0:3: Attached scsi removable disk sdd
usb-storage: device scan complete


Any attempt to access the devices afterwards results in ENXIO (but 
the /sys/block entries for sda to sdd remain there).
