Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSENQFb>; Tue, 14 May 2002 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315793AbSENQFa>; Tue, 14 May 2002 12:05:30 -0400
Received: from ns.ithnet.com ([217.64.64.10]:50950 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S315792AbSENQF2>;
	Tue, 14 May 2002 12:05:28 -0400
Date: Tue, 14 May 2002 18:05:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB lockup in 2.4.18-pre8
Message-Id: <20020514180526.4b1691a0.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

beginning with 2.4.18-pre7 I notice a complete system lockup using a SANDISK
SDDR-05 compactflash USB adapter.
I used the device in earlier kernel versions with the "UHCI Alternate Driver",
but in 2.4.18-pre7 I experienced a complete system lockup when mounting the
flash card. So I switched over to "UHCI (Intel ..." device, which worked ok in
2.4.18-pre7.
Unfortunately starting with 2.4.18-pre8 I had to find out that now both
UHCI-drivers produce the lockup. Since I did not find any hints in lkml from
others I thought it might be worth dropping a note...

I am willing to try out whatever is necessary.

Regards,
Stephan


some system infos:

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)

May  3 13:40:44 admin kernel: usb.c: registered new driver usbdevfs
May  3 13:40:44 admin kernel: usb.c: registered new driver hub
May  3 13:40:44 admin kernel: usb-uhci.c: $Revision: 1.275 $ time 13:31:52 May  3 2002
May  3 13:40:44 admin kernel: usb-uhci.c: High bandwidth mode enabled
May  3 13:40:44 admin kernel: usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
May  3 13:40:44 admin kernel: usb-uhci.c: Detected 2 ports
May  3 13:40:44 admin kernel: usb.c: new USB bus registered, assigned bus number 1
May  3 13:40:44 admin kernel: hub.c: USB hub found
May  3 13:40:44 admin kernel: hub.c: 2 ports detected
May  3 13:40:44 admin kernel: usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 5
May  3 13:40:44 admin kernel: usb-uhci.c: Detected 2 ports
May  3 13:40:44 admin kernel: usb.c: new USB bus registered, assigned bus number 2
May  3 13:40:44 admin kernel: hub.c: USB hub found
May  3 13:40:44 admin kernel: hub.c: 2 ports detected
May  3 13:40:44 admin kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
May  3 13:40:44 admin kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
May  3 13:40:44 admin kernel: usb.c: USB device 2 (vend/prod 0x781/0x1) is not claimed by any active driver.
May  3 13:40:44 admin kernel: Initializing USB Mass Storage driver...
May  3 13:40:44 admin kernel: usb.c: registered new driver usb-storage
May  3 13:40:44 admin kernel: scsi3 : SCSI emulation for USB Mass Storage devices
May  3 13:40:44 admin kernel:   Vendor:           Model:                   Rev:  
May  3 13:40:44 admin kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May  3 13:40:44 admin kernel: Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0  
May  3 13:40:44 admin kernel: usb-uhci.c: interrupt, status 3, frame# 1433
May  3 13:40:44 admin kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
May  3 13:40:44 admin kernel: sdb : READ CAPACITY failed.
May  3 13:40:44 admin kernel: sdb : status = 1, message = 00, host = 0, driver = 08
May  3 13:40:44 admin kernel: Current sd00:00: sns = 70  2
May  3 13:40:44 admin kernel: ASC=3a ASCQ= 0
May  3 13:40:44 admin kernel: Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x08 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00
May  3 13:40:44 admin kernel: sdb : block size assumed to be 512 bytes, disk size 1GB.  
May  3 13:40:44 admin kernel:  sdb: I/O error: dev 08:10, sector 0
May  3 13:40:44 admin kernel:  I/O error: dev 08:10, sector 0
May  3 13:40:44 admin kernel:  unable to read partition table
May  3 13:40:44 admin kernel: WARNING: USB Mass Storage data integrity not assured
May  3 13:40:44 admin kernel: USB Mass Storage device found at 2
May  3 13:40:44 admin kernel: USB Mass Storage support registered.


