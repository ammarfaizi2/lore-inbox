Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbRCFJ3Y>; Tue, 6 Mar 2001 04:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130503AbRCFJ3P>; Tue, 6 Mar 2001 04:29:15 -0500
Received: from www.wen-online.de ([212.223.88.39]:62479 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130469AbRCFJ3A>;
	Tue, 6 Mar 2001 04:29:00 -0500
Date: Tue, 6 Mar 2001 10:29:00 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-ac12 unknown southbridge
In-Reply-To: <20010306101654.A1281@suse.cz>
Message-ID: <Pine.LNX.4.33.0103061020310.2291-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Vojtech Pavlik wrote:

> On Tue, Mar 06, 2001 at 10:09:05AM +0100, Mike Galbraith wrote:
>
> > The driver forget what it always called a vt82c596b before.  Reverting
> > the below brought it back on-line, and all seems well again.  (hope I
> > don't receive any unpleasant suprises.. I've not the foggiest clue what
> > that number means;)
> >
> > -	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x12, 0x2f, VIA_UDMA_66 },
> > +	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, VIA_UDMA_66 },
>
> Can you verify it's a 596b and not 596a? Preferably by looking on the
> chip? This change was brought in because I wasn't sure for the 10 and 11
> revisions. 586a doesn't have a functional UDMA66 engine and causes
> crashes if programmed to UDMA66.

*blur* SQUINT (I _definitely_ need new glasses) it's a 596b.

Probably dumb question wrt hdparm -i output...

/dev/hda:

 Model=IBM-DJNA-352030, FwRev=J58OA30K, SerialNo=GQ0GQFP8740
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4

Why is it defaulting to udma4, and :) why the heck does it work?

	-Mike

