Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSB0Sex>; Wed, 27 Feb 2002 13:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292881AbSB0Sed>; Wed, 27 Feb 2002 13:34:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54281
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292876AbSB0SeX>; Wed, 27 Feb 2002 13:34:23 -0500
Date: Wed, 27 Feb 2002 10:21:05 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Gunther Mayer <gunther.mayer@gmx.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: pcmcia problems with IDE & cardbus
In-Reply-To: <3C7D2432.3A5DA1D7@gmx.net>
Message-ID: <Pine.LNX.4.10.10202271019260.19407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gunther,

I gave this the heads up and verified a long time ago.
I am puzzled why this has not been adopted.
It at least made it into 2.5.3.

Marcelo, please take this fix!


On Wed, 27 Feb 2002, Gunther Mayer wrote:

> Herbert Rosmanith wrote:
> 
> > hi,
> >
> > I've been trying to get a CompactFlash act as an IDE-drive, 2nd or 3rd
> > ide-channel, that is, IDE1 or IDE2 resp. Didn't work. Seems to be driver
> > related.
> >
> > I downloaded 2.4.18 and pcmcia-3.1.31, from the later I got "ide_cs.o"
> >
> > The hardware I am using a a two socket PCI to PCMCIA bridge:
> >
> > hale-bopp:~ # cat /proc/interrupts
> > [...]
> >  10:          1          XT-PIC  Texas Instruments PCI1221, Texas Instruments PCI1221 (#2)
> > ...
> >    : hde: SanDisk SDCFB-16, ATA DISK drive
> >    : ide2: Disabled unable to get IRQ 10.
> >   ...
> >    : ide_cs: ide_register() at 0x100 & 0x10e, irq 10 failed
> >    : Trying to free nonexistent resource <00000100-0000010f>
> >
> > "unable to get IRQ 10" is somewhat funny, since IRQ-10 is used by
> > the cardbus device. what I don't understand is if the IDE-drive
> > sould get its own interrupt or not.
> 
> With PCI-PCMCIA bridges you only have _one_ PCI irq, but linux
> falsely fails to share irq in this case.
> 
> This patch exists since 6 months but due to communiation problems
> between Linux and IDE maintainer nobody cared to include it.
> 
> Find my patch for 2.4.15 appended.
> -
> Gunther
> 
> 
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

