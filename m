Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSHZK26>; Mon, 26 Aug 2002 06:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSHZK26>; Mon, 26 Aug 2002 06:28:58 -0400
Received: from msgbas1x.net.europe.agilent.com ([192.25.19.109]:41928 "EHLO
	msgbas1.net.europe.agilent.com") by vger.kernel.org with ESMTP
	id <S318031AbSHZK25>; Mon, 26 Aug 2002 06:28:57 -0400
Message-ID: <C12D24916888D311BC790090275414BB0B724758@oberon.britain.agilent.com>
From: barrie_spence@agilent.com
To: szepe@pinerecords.com, barrie_spence@agilent.com
Cc: andre@linux-ide.org, mru@users.sourceforge.net,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: RE: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
Date: Mon, 26 Aug 2002 12:33:06 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying an append with LILO - I didn't realise that IDE was built as a module (I normally run SCSI :)). I've added "options ide-mod ide2=ata66 ide3=ata66" to /etc/modules.conf, but that doesn't give me the forced messages and doesn't allow me to force it with hdparm.

Barrie

-----Original Message-----
From: Tomas Szepe [mailto:szepe@pinerecords.com]
Sent: 26 August 2002 11:10
To: barrie_spence@agilent.com
Cc: andre@linux-ide.org; mru@users.sourceforge.net;
linux-kernel@vger.kernel.org; alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33


> I've already tried "ideX=ata66" with no effect and they are definitely 80
> pin cables (I thought the driver would complain if they weren't).

I have the exact same problem and loading the IDE core mod like this:

modprobe ide-mod options="ide2=ata66 ide3=ata66"

solves it.

->
Aug 12 05:58:58 beth kernel: PDC20268: IDE controller on PCI bus 00 dev 30
Aug 12 05:58:58 beth kernel: PDC20268: chipset revision 2
Aug 12 05:58:58 beth kernel: PDC20268: not 100%% native mode: will probe irqs later
Aug 12 05:58:58 beth kernel: PDC20268: ATA-66/100 forced bit set (WARNING)!!
Aug 12 05:58:58 beth kernel:     ide2: BM-DMA at 0xf8b0-0xf8b7, BIOS settings: hde:pio, hdf:pio
Aug 12 05:58:58 beth kernel: PDC20268: ATA-66/100 forced bit set (WARNING)!!
Aug 12 05:58:58 beth kernel:     ide3: BM-DMA at 0xf8b8-0xf8bf, BIOS settings: hdg:pio, hdh:pio
Aug 12 05:58:58 beth kernel: hde: WDC WD205BA, ATA DISK drive
Aug 12 05:58:58 beth kernel: hdg: IBM-DJNA-351520, ATA DISK drive
Aug 12 05:58:58 beth kernel: ide2 at 0xf898-0xf89f,0xf8aa on irq 9
Aug 12 05:58:58 beth kernel: ide3 at 0xf8a0-0xf8a7,0xf8ae on irq 9
Aug 12 05:58:58 beth kernel: hde: host protected area => 1
Aug 12 05:58:58 beth kernel: hde: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
Aug 12 05:58:58 beth kernel: hdg: host protected area => 1
Aug 12 05:58:58 beth kernel: hdg: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=29795/16/63, UDMA(33)

Are you getting the ATA66 bit forced warnings?

T.
