Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSLGT3r>; Sat, 7 Dec 2002 14:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSLGT3r>; Sat, 7 Dec 2002 14:29:47 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:33925 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264706AbSLGT3q> convert rfc822-to-8bit; Sat, 7 Dec 2002 14:29:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.20-BK
Date: Sat, 7 Dec 2002 20:36:08 +0100
User-Agent: KMail/1.4.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200212071434.11514.m.c.p@wolk-project.de>
In-Reply-To: <200212071434.11514.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212072036.08500.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 December 2002 14:35, Marc-Christian Petersen wrote:

Hi Alan,

ok, just another bug I hit:

pdc202xx_new: static build, module build do not have Special FastTrack 
features so the system will say neither IDE port enabled (BIOS) so it won't 
work.

PDC20270: IDE controller at PCI slot 01:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
PDC20270: ROM enabled at 0xefdd0000
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:pio, hdd:pio
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hda:pio, hdb:DMA
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
 hda:

HANG! Nothing more happens. I wait for ~ 5 minutes.


same with disabled IRQ11 for PCI in BiOS:

PDC20270: IDE controller at PCI slot 01:01.0
PDC20270: chipset revision 2
PDC20270: not 100% native mode: will probe irqs later
PDC20270: ROM enabled at 0xefdd0000
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:pio, hdd:pio
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hda:pio, hdb:DMA
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
 hda:<3>hda: lost interrupt
hda: lost interrupt
 hda1

<going ahead>

hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
cramfs: wrong magic
Kernel panic: VFS: Unable to mount root fs on 03:03
 <0> Rebooting in 60 seconds..


P.S.: Is this appreciated for -BK tree's to reports bugs? I assume yes :)

ciao, Marc


