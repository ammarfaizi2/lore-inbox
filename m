Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbQLERtO>; Tue, 5 Dec 2000 12:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbQLERtE>; Tue, 5 Dec 2000 12:49:04 -0500
Received: from cc993546-b.srst1.fl.home.com ([24.3.77.52]:13325 "EHLO
	comptechnews.com") by vger.kernel.org with ESMTP id <S129999AbQLERsy>;
	Tue, 5 Dec 2000 12:48:54 -0500
From: "Robert B. Easter" <reaster@comptechnews.com>
Date: Tue, 5 Dec 2000 12:25:32 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Daniel Sangenberg <daniel@datanova.se>, linux-kernel@vger.kernel.org
In-Reply-To: <5.0.1.4.2.20001205170724.00b30458@mail.datanova.se>
In-Reply-To: <5.0.1.4.2.20001205170724.00b30458@mail.datanova.se>
Subject: Re: 2.2.17 + ide patches + 61gb ibm disc = problem
MIME-Version: 1.0
Message-Id: <00120512253218.00289@comptechnews>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2000 11:15, Daniel Sangenberg wrote:
> Hi!
>
> I have a problem with 2.2.17 + the latest ide patches and 2 * 61 gb ibm ide
> discs, the discs are connected as slave on a two channels (onboard ide
> channels on a asus p2b (i440BX Chipset)), there is nohing else connected on
> the ide interface and the jumper settings are identical.
>
> dmesg output:
>
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 21
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
>      ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
> hdb: IBM-DTLA-307060, ATA DISK drive
> hdd: IBM-DTLA-307060, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hdb: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=7476/255/63, UDMA(33)
> hdd: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=119150/16/63, UDMA(33)
>
> hdd1 [events: 00000001](write) hdd1's sb offset: 60051456
> hdb1 [events: 00000001](write) hdb1's sb offset: 60050816
>


I don't understand why you have set them to be slaves when they are the only 
drives on the ports.  Shouldn't you be setting the jumpers on both drives 
into the Single Drive (default) settings?  I always thought the Master and 
Slave positions are to be used only when connecting two drives on one port.

hda and hdc should be the devices.

-- 
-------- Robert B. Easter  reaster@comptechnews.com ---------
- CompTechNews Message Board   http://www.comptechnews.com/ -
- CompTechServ Tech Services   http://www.comptechserv.com/ -
---------- http://www.comptechnews.com/~reaster/ ------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
