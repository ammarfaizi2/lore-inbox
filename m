Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266381AbRGFVOU>; Fri, 6 Jul 2001 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRGFVOK>; Fri, 6 Jul 2001 17:14:10 -0400
Received: from [199.26.153.10] ([199.26.153.10]:10245 "HELO fourelle.com")
	by vger.kernel.org with SMTP id <S266381AbRGFVOE>;
	Fri, 6 Jul 2001 17:14:04 -0400
Message-ID: <3B4629A0.2AFB3AF9@fourelle.com>
Date: Fri, 06 Jul 2001 14:12:00 -0700
From: "Adam D. Scislowicz" <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: adams@fourelle.com
Subject: Re: IDE0/Slave Detection Fails in 2.4.x(2.4.4, 2.4.5, and 2.4.5-ac18 
 tested)
In-Reply-To: <3B4605E5.DDA1B8CA@fourelle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an update: I have now tested it with the 2.4.6 kernel and the problem

persists :(

I failed to mention in the previous email that the machine is an 2
processor SMP machine.

 -Adam

"Adam D. Scislowicz" wrote:

> I am having a problem where the 2.4.x(2.4.4, and 2.4.5, and 2.4.5-ac18)
> kernel does not detect the IDE0/primary slave device. If I put a third
> drive in the system as IDE1/secondary master then that is detected.
> However
> the IDE0/primary slave is never detected.
>
> Using the 2.2.19 kernel the IDE0/primary slave device IS detected
> properly. This
> can be seen below in the 2.2.19 Kernel Init Messages.
>
> Below is some more detailed info.
>  *Note: Please CC me in any replay as I am not subscribed to this
> mailiing list ;)
>
>  -Adam Scislowicz
>
> [ My IDE Controller Info (2.2.19:/proc/pci) ]
>   Bus  0, device   7, function  1:
>     IDE interface: Intel 82371AB PIIX4 IDE (rev 1).
>       Medium devsel.  Fast back-to-back capable.  Master Capable.
> Latency=64.
>       I/O at 0xffa0 [0xffa1].
>
> [ The 2.2.19 Kernel Init Messages ]
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hda: TOSHIBA THNCF032MAA, ATA DISK drive
> hdb: IBM-DARA-206000, ATA DISK drive
> hdc: ST320420A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: TOSHIBA THNCF032MAA, 31MB w/2kB Cache, CHS=496/4/32
> hdb: IBM-DARA-206000, 5729MB w/418kB Cache, CHS=730/255/63, UDMA
> hdc: ST320420A, 19458MB w/2048kB Cache, CHS=39535/16/63, UDMA
>
> [ The 2.4.5-ac18 Kernel Init Messages ]
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hda: TOSHIBA THNCF032MAA, ATA DISK drive
> hdc: ST320420A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 63488 sectors (33 MB) w/2KiB Cache, CHS=496/4/32, DMA
> hdc: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63,
> UDMA(33)

