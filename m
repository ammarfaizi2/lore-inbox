Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312350AbSC3BwP>; Fri, 29 Mar 2002 20:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312355AbSC3Bv4>; Fri, 29 Mar 2002 20:51:56 -0500
Received: from mail.getnet.net ([63.137.32.10]:54512 "HELO mail.getnet.net")
	by vger.kernel.org with SMTP id <S312350AbSC3Bvq>;
	Fri, 29 Mar 2002 20:51:46 -0500
Message-ID: <3CA51A31.80405@westek-systems.com>
Date: Fri, 29 Mar 2002 18:51:45 -0700
From: Art Wagner <awagner@westek-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac[23] do not boot
In-Reply-To: <Pine.LNX.4.10.10203291313430.10681-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------040505020008090600050505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505020008090600050505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi;
I seem to have the identical problem with system hangs on boot. The 
problem I see occurs on a Abit BP6
on the first access of the first drive on the HPT-366 interface. The 
problem occurs on all -ac-x revisions
1 through 3.  The attached log is from an boot on 2.4.19-pre4 which did 
not hang but the log is identical
except for the fact that the hang occurs with only the "hde:" portion of 
the last line displayed.
If I can provide any further information pleas let me know via the list 
or direct email.
Art Wagner

Andre Hedrick wrote:

>On Fri, 29 Mar 2002, Alan Cox wrote:
>
>>>This is possible, however one of the problems encountered is the
>>>following under several chipsets.  If there is no pio timing set at all,
>>>then we can run into host lock issues if the driver drops out of dma.
>>>Thus, if it is going to lockup here it would/could lock up in other
>>>places when one trys to program the host for PIO.
>>>
>>Well right at the moment the ALi locks up on boot reliably. That means a
>>fix has to be found, or the ALi changes reverted 
>>
>
>Pull out the GOOF-UP of mine :-/
>
>autotune is enabled and does the same thing, Gurrr....
>
>Cheers,
>
>Andre Hedrick
>LAD Storage Consulting Group
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


--------------040505020008090600050505
Content-Type: text/plain;
 name="boot_hang.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot_hang.log"

Mar 29 18:32:43 Apollo kernel: PIIX4: not 100%% native mode: will probe irqs later
Mar 29 18:32:43 Apollo kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Mar 29 18:32:43 Apollo kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Mar 29 18:32:43 Apollo xinetd[780]: Service ntalk: missing '{' [line=5]
Mar 29 18:32:43 Apollo kernel: HPT366: onboard version of chipset, pin1=1 pin2=2
Mar 29 18:32:43 Apollo kernel: HPT366: IDE controller on PCI bus 00 dev 98
Mar 29 18:32:43 Apollo kernel: HPT366: chipset revision 1
Mar 29 18:32:43 Apollo kernel: HPT366: not 100%% native mode: will probe irqs later
Mar 29 18:32:43 Apollo kernel:     ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:DMA
Mar 29 18:32:43 Apollo kernel: HPT366: IDE controller on PCI bus 00 dev 99
Mar 29 18:32:43 Apollo kernel: HPT366: chipset revision 1
Mar 29 18:32:43 Apollo kernel: HPT366: not 100%% native mode: will probe irqs later
Mar 29 18:32:43 Apollo kernel:     ide3: BM-DMA at 0xc400-0xc407, BIOS settings: hdg:DMA, hdh:pio
Mar 29 18:32:44 Apollo kernel: hda: WDC AC31200F, ATA DISK drive
Mar 29 18:32:44 Apollo kernel: hdb: Maxtor 88400D8, ATA DISK drive
Mar 29 18:32:44 Apollo kernel: hdc: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
Mar 29 18:32:44 Apollo kernel: hde: Maxtor 34098H4, ATA DISK drive
Mar 29 18:32:44 Apollo kernel: hdf: Maxtor 5T060H6, ATA DISK drive
Mar 29 18:32:44 Apollo kernel: hdg: ST320413A, ATA DISK drive
Mar 29 18:32:44 Apollo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 29 18:32:44 Apollo kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 29 18:32:44 Apollo kernel: ide2 at 0xb000-0xb007,0xb402 on irq 18
Mar 29 18:32:44 Apollo kernel: ide3 at 0xbc00-0xbc07,0xc002 on irq 18
Mar 29 18:32:44 Apollo kernel: hda: 2503872 sectors (1282 MB) w/64KiB Cache, CHS=621/64/63, DMA
Mar 29 18:32:44 Apollo kernel: hdb: 16408224 sectors (8401 MB) w/256KiB Cache, CHS=1021/255/63, UDMA(33)
Mar 29 18:32:44 Apollo kernel: hde: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63, UDMA(66)
Mar 29 18:32:44 Apollo kernel: hdf: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, UDMA(66)
Mar 29 18:32:44 Apollo kernel: hdg: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=38792/16/63, UDMA(66)
Mar 29 18:32:44 Apollo kernel: hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Mar 29 18:32:44 Apollo xinetd: xinetd startup succeeded
Mar 29 18:32:44 Apollo kernel: Uniform CD-ROM driver Revision: 3.12
Mar 29 18:32:44 Apollo kernel: Partition check:
Mar 29 18:32:44 Apollo kernel:  hda: hda1 hda2
Mar 29 18:32:44 Apollo kernel:  hdb:
Mar 29 18:32:44 Apollo kernel:  hde: [EZD] [remap 0->1] [4982/255/63] hde1

--------------040505020008090600050505--

