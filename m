Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278617AbRJ1SYP>; Sun, 28 Oct 2001 13:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278633AbRJ1SX4>; Sun, 28 Oct 2001 13:23:56 -0500
Received: from arabuusi.tky.hut.fi ([130.233.24.169]:61855 "HELO
	arabuusi.tky.hut.fi") by vger.kernel.org with SMTP
	id <S278617AbRJ1SXn>; Sun, 28 Oct 2001 13:23:43 -0500
Date: Sun, 28 Oct 2001 20:35:52 +0200 (EET)
From: Janne Liimatainen <jeppe@arabuusimiehet.com>
X-X-Sender: <jeppe@arabuusi.tky.hut.fi>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Francois Romieu <romieu@cogenit.fr>, Janne Liimatainen <jannel@iki.fi>,
        <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 problems continued
In-Reply-To: <Pine.LNX.4.10.10110272003180.5826-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0110282034460.3429-100000@arabuusi.tky.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2001, Andre Hedrick wrote:

> > I'd say either mate->dma_base is set too soon for both mate (and they're both
> > guaranteed to generate dma_base = 0 as soon as they reach 794) or do_identify
> > is called too late (and dma_base = 0 because of 793).
> > I haven't found a lot of dma_base field setting and they seem to happen late.
> 
> Ueimor,
> 
> If the BIOS does not configure the PCI space or if it is not listed to be
> setup in the ./arch/*/kernel/pci-quirks.... then the driver ignores the
> HOST.  So in short you are wrong, and the driver is doing its job
> correctly.  The real problem is happening long before I ever get to touch
> the chipset.
> 
> Let me guess, you are using one of the soft-raid modes of that host.

Nope, seems to be the fault of the bios, as it works fine with another 
motherboard. Need to look at the quirks then...

/Janne


