Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTIKI2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbTIKI2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:28:31 -0400
Received: from pop.gmx.net ([213.165.64.20]:64159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261161AbTIKI2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:28:22 -0400
From: "Sebastian Piecha" <spi@gmxpro.de>
To: "Eric Bickle" <ebickle@healthspace.ca>, <linux-kernel@vger.kernel.org>
Date: Thu, 11 Sep 2003 10:28:25 +0200
MIME-Version: 1.0
Subject: Re: Problem: IDE data corruption with VIA chipsets on 2.4.20-19.8+others
Message-ID: <3F604E49.14444.F8BCBBB@localhost>
In-reply-to: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Sep 2003 at 22:32, Eric Bickle wrote:

> The core issue:
> ----------------
> Random crashes, general operating system instability with a RedHat 8 Linux
> install running a moderately heavy-use database server (IBM Lotus Domino 5
> or 6). All current indications point to a data
> corruption/ide-incompatibility between the linux IDE driver and various VIA
> chipsets. The problem only occurs during heavy database server load.
> ...
I reported a problem to the lkml (see "PROBLEM: Powerquest Drive 
Image let the kernel panic" and "PROBLEM: kernel panic when accessing 
data via samba") describing a kernel panic when accessing a huge 
amount of data via samba. Unfortunately I didn't get any response 
yet.

I'm using a SuSE 8.2 distribution with kernel 2.4.20.

> 
> We also get various IDE errors in the /var/log files, such as: (also another
> weird IRQ error - except we're running a stock config! (ie/ no PCI devices
> other than one NIC... No idea if they're related to the IDE thing <sigh>.
> The IRQ thing appears to be USB related)
> == during server runtime ==
> kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150637065,
> sector=150636992
> kernel: end_request: I/O error, dev 16:01 (hdc), sector 150636992
> kernel: hdc: dma_intr: status=0x53 { DriveReady SeekComplete Index Error }
> kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150630007,
> sector=150629920
> kernel: end_request: I/O error, dev 16:01 (hdc), sector 150629920
> == during server boot ==
> kernel: usb.c: new USB bus registered, assigned bus number 3
> kernel: hub.c: USB hub found
> kernel: hub.c: 2 ports detected
> kernel: PCI: Found IRQ 3 for device 00:10.2
> kernel: IRQ routing conflict for 00:10.0, have irq 9, want irq 3
> kernel: IRQ routing conflict for 00:10.1, have irq 9, want irq 3
> kernel: IRQ routing conflict for 00:10.2, have irq 9, want irq 3
> kernel: IRQ routing conflict for 00:10.3, have irq 9, want irq 3
> kernel: usb-uhci.c: USB UHCI at I/O 0x9400, IRQ 9
> ...

I'm getting similar errors:
kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: drive_cmd: error=0x04Aborted Command 

I don't get any IRQ routing conflicts.

But in my configuration hdc is a cd-rom attached to the onboard IDE. 

> ...
> We tried various motherboards, including the following chipsets:
> VIA KT333
> VIA KT400
> SiS 745
> 
> ...
My onboard IDE is an Intel 82371AB/EB/MB PIIX4 IDE. My two harddisks 
(each 120GB of size) are attached to a Promise Ultra 133TX2 
controller.

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

