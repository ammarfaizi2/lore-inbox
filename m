Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVEPPWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVEPPWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEPPUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:20:42 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:62569 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261696AbVEPPMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:12:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=nANmlIaf4fQeUf4Umq7/xMoJzGcjOeLEOVQCnbhT9+r6RvU+v+s8XX18eMOeNQQBV8HHgfUvawPUzP0FgoQfrnUHzLhBFZZI1SfVfTVZ9owaBap8MlY3JtKkSDXyXjwzdjPvVTwzgU1MyNsAAWF5JsExnX4Vpc5Mma7HK2yfTY8=
Date: Mon, 16 May 2005 17:12:01 +0200
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ? (on amd64 ?)
Message-ID: <20050516151201.GD9558@gmail.com>
References: <20050516085832.GA9558@gmail.com> <Pine.LNX.4.62.0505161701410.2390@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0505161701410.2390@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 05:03:56PM +0200, Jesper Juhl wrote:

> Not me, it works perfectly here, but then I have different hardware (but 
> using the aic7xxx driver).

You are lucky, maybe I should also mention that I am under x86_64 ?

Here under 2.6.12-rc2 :

ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
(scsi0:A:15): 80.000MB/s transfers (40.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.10 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD000 irq 20
ata2: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xD008 irq 20
ata1: no device found (phy stat 00000000)
scsi2 : sata_via
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4043 85:7c69 86:3e01 87:4043 88:407f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi3 : sata_via
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 15, lun 0
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 2, lun 0
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi1, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 15, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg4 at scsi1, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg5 at scsi3, channel 0, id 0, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xcfffe900
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000bc00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.

Anyone has aic7xxx working post 2.6.12-rc2 on amd64 ?

Thank you very much and please keep CC to me as I am not on this ml.
-- 
	Grégoire Favre
