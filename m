Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310972AbSCTBac>; Tue, 19 Mar 2002 20:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSCTBaW>; Tue, 19 Mar 2002 20:30:22 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24324
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310972AbSCTBaR>; Tue, 19 Mar 2002 20:30:17 -0500
Date: Tue, 19 Mar 2002 17:29:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ken Brownfield <ken@irridia.com>, m.knoblauch@TeraPort.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
 (RH7.2)
In-Reply-To: <E16nUx8-0000w4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203191726290.525-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Alan Cox wrote:

> > We're seeing this with Tyan 2410s and Seagate drives.  I think Tyan just
> > can't get DMA right.  Luckily we mainly lost docs or man pages before we
> > disabled DMA, although losing the rpm database sucked.  MDMA2 seems okay
> > but we haven't tested it long enough to form a lasting impression.
> > I'm actually patching the ServerWorks driver to honor the CONFIG flag,
> > since even with hdparm there is a narrow risk to the fs during the boot
> > process before DMA is disabled.
> 
> I can confirm problems with serverworks OSB4 and UDMA. With UDMA and
> a seagate disk you see 4 bytes repeat from one transfer into the next
> shuffling all the data up 4 bytes (which since it includes inode and
> metadata is *messy*). Current 2.4 has detect code that sometimes traps this
> and panics to avoid fs death.
> 
> With MWDMA all was fine.
> 
> This was observed across a large number of boxes in a rendering farm so its
> not a one off flawed box, and across two board vendors. I reported it to
> serverworks who were interested but couldnt reproduce it in their lab.

I am in their lab trying to reproduce the error and I have found some docs
which could help address the error of the 4byte FIFO issue in the engine.
It looks fixable on paper.

As for the AMD driver, who knows which version is in that kernel.

Next, that config option is a distro addition not mine, but it has creeped
in so it is here.

Regards,

Andre Hedrick
LAD Storage Consulting Group

