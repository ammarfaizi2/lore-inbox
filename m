Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272401AbTHIPuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272402AbTHIPuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:50:03 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:37138 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S272401AbTHIPuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:50:00 -0400
Date: Sat, 9 Aug 2003 17:57:08 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wes Janzen <superchkn@sbcglobal.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
Message-ID: <20030809155708.GA3606@hh.idb.hist.no>
References: <16128.19218.139117.293393@charged.uio.no> <3F007EBF.9020506@sbcglobal.net> <3F10729F.7070701@sbcglobal.net> <3F34E6D1.7030900@sbcglobal.net> <1060439826.4938.88.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060439826.4938.88.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 03:37:07PM +0100, Alan Cox wrote:
> On Sad, 2003-08-09 at 13:19, Wes Janzen wrote:
> > I don't know why I didn't google for this in the first place, but it 
> > looks like it is a known issue.  Just apparently not well-known.
> > 
> > Probably not especially important though, I wonder just how many people 
> > are still running this setup...  With Linux, I'd say even fewer.
> 
> I'm running MVP4 without problems. I've got an old MVP3 board I need to
> dig out and play with. Certainly MVP3 has problems with some AGP and
> some other high load PCI situations. 

I have a pc with a VIA MVP3, that I use as an x-terminal.
Using dma is not an option, I got the impression that ide
developers consider the chip so broken they don't want to
try make that work. That is ok with me, I wouldn't consider
running anything needing good io performance on that old thing.

What is worse is that 2.6 ide don't work with it at all.
Booting attempts die early of io errors, sometimes it don't
even find the root fs superblock, other times dies a little later.
So it is sort of left behind, running 2.5.69-mm3 which at least works
in pio mode. The harddisk is a old 240MB thing with debian
shoehorned onto it.

There is no AGP card in the machine, so AGP is clearly not necessary
to get io trouble.

Here's the lspci output, if anyone is interested:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] 
(rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
64)
00:0b.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)

Helge Hafting

