Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSEAB72>; Tue, 30 Apr 2002 21:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315286AbSEAB71>; Tue, 30 Apr 2002 21:59:27 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:40605 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S315285AbSEAB70>;
	Tue, 30 Apr 2002 21:59:26 -0400
Message-ID: <3CCF4BFD.6C7F67EB@bigfoot.com>
Date: Tue, 30 Apr 2002 18:59:25 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ide <-> via VT82C693A/694x problems?
In-Reply-To: <Pine.LNX.4.10.10204301754310.2107-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> You have an AEC6280 or AEC6880 depending of if it is raid or not.
> 
> That Chipset is supported jsut you need patches.

  are you referring to the pci ide card? that one seeems to be working
correctly (at least for cd audio ripping). so I guess the patch would be
for proper pci id?

  the MB uses via chips so I included via82cxxx driver (as a module). is
that correct?

  however, I just checked and via82cxxx is NOT loaded. What do I need to
do to make ide driver is using via82cxxx module?

  I have ide driver compiled in (booting from ide hd), does via82cxxx
have to be compiled in?

	erik

> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Tue, 30 Apr 2002, Erik Steffl wrote:
> 
> >   it looks like the CD audio ripping doesn't work on my via
> > VT82C693A/694x based motherboard, even though it works fine when I
> > connect cd drive to PCI ide controller.
> >
> >   when doing audio ripping on MB's ide there are 'lost interrupt'
> > messages in syslog and ripping is VERY slow (hours per song), there is
> > an interrupt lost every 40 - 100 ide commands (it seems the timing
> > doesn't matter, when I stepped through cdparanoia using debugger it was
> > the same as when just running cdparanoia).
> >
> >   internal MB's ide works fine for everything else: harddrives work OK,
> > data cd, cd burning all work properly. only audio ripping doesn't work
> > (regardless of whether I use hdc or ide-scsi)
> >
> >   I tried to use different CD drive, different ide cable, different ide
> > slot, HDs in different ide slots etc. nothing makes any difference, the
> > audio ripping on the internal ide doesn't work, everything else works.
> >
> >   any ideas what might be wrong? is it a ide driver <-> motherboard
> > problem?
> >
> >   TIA
> >
> >   system info:
> >
> >   kernel 2.4.17 and 2.4.18 (same behaviour)
> >   MB: VIA Technologies, Inc. VT82C693A/694x (abit)
> >   cd drive: TDK CDRW321040B, ATAPI CD/DVD-ROM drive
> >   alternative cd drive: old mitsumi
> >   kernel config: CONFIG_BLK_DEV_VIA82CXXX=y
> >   dma access both on and off (same problem)
> >   32 bit access both on and off (same problem)
> >
> > jojda:/dev# lspci
> > 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
> > PRO133x] (rev c4)
> > 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
> > MVP3/Pro133x AGP]
> > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> > (rev 40)
> > 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> > 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> > (rev 40)
> > 00:09.0 SCSI storage controller: Artop Electronic Corp: Unknown device
> > 0009 (rev 02)
> > 00:0b.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
> > 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
> > (rev 10)
> > 00:0f.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
> > 01)
> >
> >   btw for some reason the additional ide controller is listed as SCSI
> > storage controller: Artop Electronic Corp in the lspci output above.
> >
> >       erik
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
