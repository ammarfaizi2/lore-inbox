Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUABO1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 09:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUABO1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 09:27:13 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:3597 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S265590AbUABO1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 09:27:10 -0500
Date: Fri, 2 Jan 2004 22:25:33 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
In-Reply-To: <20040102103949.GL5523@suse.de>
Message-ID: <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
 <20040102103949.GL5523@suse.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/02/2004
 10:27:06 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/02/2004
 10:27:08 PM,
	Serialize complete at 01/02/2004 10:27:08 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jan 2004, Jens Axboe wrote:

> > GetASF failed
> > N/A, invalidating: Function not implemented
> > N/A, invalidating: Function not implemented
> > N/A, invalidating: Function not implemented
> > Request AGID [1]...     Request AGID [2]...     Request AGID [3]...
> > Cannot get AGID


> > This error happens only on USB DVD drive using /dev/scd0 ...

USB drive is a Pioneer DVR-SK11B-J. It's reported as ...

scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02

I've tried at least 2 other USB drives (Plextor PX-208U, and Sony CRX85U),
and both of these drives also exhibit the same problem.


> > Linux version is 2.4.24-pre3.


> I can't say what goes wrong from the info above. Do you get any kernel
> messages?

No kernels oops. Just those "GetASF failed" messages above.

Detailed dmesg as follows ...

Yenta ISA IRQ mask 0x0638, PCI irq 11
Socket status: 30000820
Yenta ISA IRQ mask 0x0638, PCI irq 11
Socket status: 30000006
cs: cb_alloc(bus 2): vendor 0x1033, device 0x0035
PCI: Enabling device 02:00.0 (0000 -> 0002)
PCI: Enabling device 02:00.1 (0000 -> 0002)
PCI: Enabling device 02:00.2 (0000 -> 0002)
cs: IO port probe 0x0100-0x03ff: excluding 0x170-0x177 0x370-0x37f
cs: IO port probe 0x0a20-0x0a27: clean.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
ehci_hcd 02:00.2: PCI device 1033:00e0
ehci_hcd 02:00.2: irq 11, pci mem f969b000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 02:00.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 02:00.2-1, assigned address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2


Thanks,
Jeff

