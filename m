Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274868AbTHKWVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTHKWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:21:38 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:47293 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S274868AbTHKWVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:21:25 -0400
Date: Tue, 12 Aug 2003 00:21:35 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030811222134.GA10481@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	linux-kernel@vger.kernel.org
References: <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030810211745.GA5327@gamma.logic.tuwien.ac.at> <20030810154343.351aa69d.akpm@osdl.org> <20030811053437.GA19040@gamma.logic.tuwien.ac.at> <20030811145940.GF4562@www.13thfloor.at> <20030811154009.GE6763@gamma.logic.tuwien.ac.at> <20030811185326.GB25186@www.13thfloor.at> <20030811215058.GA24474@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030811215058.GA24474@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:50:58PM +0200, Norbert Preining wrote:
> On Mon, 11 Aug 2003, Herbert Pötzl wrote:
> > your config seems reasonable to me ...
> 
> Good to know.
> 
> > -----------
> > VFS: Cannot open root device "hdb1" or unknown-block(0,0)
> > Please append a correct "root=" boot option
> > -----------
> 
> Yes, it is like this.

like or exactly like? 

unfortunately this line is missing in your copy ...
(as well as the lines regarding hdb discovery ;)

best,
Herbert

> 
> > maybe you could attach a serial console (line)
> > and capture the boot process, and report it ...
> 
> I copied most of it to paper, so here it is, for sure with some typing
> errors:
> 
> Everything up to hear I couldn't read (maybe I find a laptop or other
> device for serial communication):
> VP_IDE: IDE controller at PCI slot 0000:00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on
> pci0000::00:07.1
>     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IC35L040AVER07-0 ....
> hda: IRQ probe failed (0xfffffcfa)  **** this line only with acpi
>                                     **** when running with acpi=off it
>                                     **** does not occur
> hdb: IC35L040AVER07-0 ....
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
> hdd: PLEXTOR CD-R PREMIUM, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> HPT370A: IDE controller at PCI slot 0000:00:0e.0
> HPT370A: chipset revision 4
> HPT37X: using 33MHz PCI clock
> HPT370A: 100% native mode on IRQ 11
>     ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:DMA, hdh:pio
> hde: Maxtor 52049H4, ATA DISK drive
> ide2 at 0xd000-0xd007,0xd402 on irq 11
> hdg: IBM-DTTA-350840, ATA DISK drive
> ide3 at 0xd800-0xd807,0xdc02 on irq 11
> hda: max request size 128 KiB
> hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63,
> UDMA(100)
>         hda: hda1 hda2 hda3
> hdb: max request size 128 KiB
> hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63,
> UDMA(100)
>         hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11
> hdb12>
> hde: max request size 128 KiB
> hde: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63,
> UDMA(100)
>         hde: hde1
> hdg: max request size 128 KiB
> hdg: 16514064 sectors (8455 MB) w/467KiB Cache, CHS=16383/16/63,
> UDMA(33)
>         hdg: hdg1
> hdc: ATAPI 40X DVD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.31
> hdd: ATAPI 40X CD-ROM ....
> Console ...
> ...
> blabla
> ...
> VFS: cannot mount ...
> 
> 
> So it looks like my disks are recognized, the partitions are recognized,
> but somehow I am missing the
> 	ide-disk attached
> or similar message.
> 
> 
> Maybe this helps someone to have an idea!
> 
> Best wishes and thanks a lot
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> WIVENHOE (n.)
> The cry of alacrity with which a sprightly eighty-year-old breaks the
> ice on the lake when going for a swim on Christmas Eve.
> 			--- Douglas Adams, The Meaning of Liff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
