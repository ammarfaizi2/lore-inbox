Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWIZWWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWIZWWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWIZWWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:22:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:48066 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964869AbWIZWWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:22:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WjGOp8LbvKHxhus+lvtORReD21m6NkL65vvlzJTo+9+EvPhbjOL6vVx5AggvcvtXSCl4BGsuP7M/umCqpeG0VQ9iQwzSgwryGmzbFgzQ9BK2jOr7sH8GgPz5STgOrD/i74TEzDmiY27cqDOBmjf+WrdBkVj9JNxCHBQUvFUGwyI=
Date: Wed, 27 Sep 2006 00:21:49 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
Message-Id: <20060927002149.06c934e8.diegocg@gmail.com>
In-Reply-To: <1159305871.11049.316.camel@localhost.localdomain>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	<1159275010.11049.215.camel@localhost.localdomain>
	<45194DAD.6060904@garzik.org>
	<20060926212939.69b52f0d.diegocg@gmail.com>
	<1159300946.11049.300.camel@localhost.localdomain>
	<20060926223857.56b0047d.diegocg@gmail.com>
	<1159305871.11049.316.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Sep 2006 22:24:31 +0100,
Alan Cox <alan@lxorguk.ukuu.org.uk> escribió:

> Doh.. OSB4IDE not OSB4

That made things work! I can confirm I can read CDs, but I wasn't
able to read DVDs, though.

[   13.023296] ata3: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
[   13.023356] ata4: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
[   13.023407] scsi2 : pata_serverworks
[   13.213080] FDC 0 is a National Semiconductor PC87306
[   13.329056] ata3.00: ATAPI, max UDMA/33
[   13.484999] ata3.00: configured for UDMA/33
[   13.485030] scsi3 : pata_serverworks
[   13.647669] ATA: abnormal status 0x8 on port 0x177
[   13.658291] scsi 2:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A103 PQ: 0 ANSI: 5
[   13.693611] usbcore: registered new driver hiddev
[   13.699398] input: Forward USB Optical Mouse as /class/input/input2
[   13.699479] input: USB HID v1.10 Mouse [Forward USB Optical Mouse] on usb-0000:00:0f.2-2
[   13.705461] input: PS/2+USB Mouse as /class/input/input3
[   13.705556] input: USB HID v1.10 Mouse [PS/2+USB Mouse] on usb-0000:00:0f.2-1
[   13.705581] usbcore: registered new driver usbhid
[   13.705588] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   13.824876] ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 24 (level, low) -> IRQ 18
[   13.824928] Model 1006 Rev 00000000 Serial 10061102
[   14.066099] sr0: scsi3-mmc drive: 62x/62x writer dvd-ram cd/rw xa/form2 cdda tray
[   14.066113] Uniform CD-ROM driver Revision: 3.20
[   14.066260] sr 2:0:0:0: Attached scsi CD-ROM sr0
[   14.090382] ts: Compaq touchscreen protocol output
[   15.228271] NET: Registered protocol family 17
[   20.190245] ACPI: Power Button (FF) [PWRF]
[   20.190271] ACPI: Sleep Button (CM) [SLPB]
[   20.218224] Using specific hotkey driver
[   23.655420] [drm] Initialized drm 1.0.1 20051102
[   23.666922] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 30 (level, low) -> IRQ 19
[   23.668312] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[   24.847392] agpgart: Putting AGP V2 device at 0000:00:00.1 into 1x mode
[   24.847652] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[   25.158828] [drm] Setting GART location based on new memory map
[   25.159052] [drm] Loading R200 Microcode
[   25.159263] [drm] writeback test succeeded in 1 usecs
[   35.966143] NET: Registered protocol family 10
[   35.966719] lo: Disabled Privacy Extensions
[   35.967014] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   35.967276] IPv6 over IPv4 tunneling driver
[   39.931359] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'AMELI_SCN', timestamp 2002/04/05 17:04 (1078)
[   54.829894] PPP generic driver version 2.4.2
[   86.083878] PPP BSD Compression module registered
[   86.134263] PPP Deflate Compression module registered
[   98.782085] UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'AMELI_SCN', timestamp 2002/04/05 17:04 (1078)
[  129.270661] sr 2:0:0:0: SCSI error: return code = 0x08000002
[  129.270675] sr0: Current: sense key=0x3
[  129.270680]     ASC=0x10 <<vendor>> ASCQ=0x90
[  129.270689] end_request: I/O error, dev sr0, sector 86372
[  129.270698] Buffer I/O error on device sr0, logical block 21593
[  129.270713] Buffer I/O error on device sr0, logical block 21594
[  129.270724] Buffer I/O error on device sr0, logical block 21595
[  129.270731] Buffer I/O error on device sr0, logical block 21596
[  129.270738] Buffer I/O error on device sr0, logical block 21597
[  129.270745] Buffer I/O error on device sr0, logical block 21598
[  129.270751] Buffer I/O error on device sr0, logical block 21599
[  129.270758] Buffer I/O error on device sr0, logical block 21600
[  129.270765] Buffer I/O error on device sr0, logical block 21601
[  129.270772] Buffer I/O error on device sr0, logical block 21602
[  157.089352] sr 2:0:0:0: SCSI error: return code = 0x08000002
[  157.089365] sr0: Current: sense key=0x3
[  157.089374]     ASC=0x10 <<vendor>> ASCQ=0x90
[  157.089385] end_request: I/O error, dev sr0, sector 422912
[  157.089392] printk: 53 messages suppressed.
