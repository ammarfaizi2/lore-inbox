Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273520AbRIYU0x>; Tue, 25 Sep 2001 16:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273519AbRIYU0g>; Tue, 25 Sep 2001 16:26:36 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:21396 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S273506AbRIYU0Z>; Tue, 25 Sep 2001 16:26:25 -0400
Date: Tue, 25 Sep 2001 16:20:50 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] airo.c code formatting
Message-ID: <20010925162050.A32335@alcove.wittsend.com>
Mail-Followup-To: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BAFFA6F.8D9DC309@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAFFA6F.8D9DC309@yahoo.co.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 11:30:55PM -0400, Thomas Hood wrote:
> I have received word that the Aironet driver in the kernel
> is the most up to date.

> The attached patch just corrects a few spelling mistakes and
> makes the coding style consistent within the file
> drivers/net/wireless/airo.c .  

> --
> Thomas Hood
> --- linux-2.4.9-ac13-mwave/drivers/net/wireless/airo.c_ORIG	Fri Sep 21 15:23:18 2001
> +++ linux-2.4.9-ac13-mwave/drivers/net/wireless/airo.c	Mon Sep 24 23:17:54 2001
> @@ -1,6 +1,7 @@
>  /*======================================================================
>  
> -    Aironet driver for 4500 and 4800 series cards
> +    Driver for Aironet 4500 and 4800 series cards
> +    and for Cisco Aironet 340 and 350 series cards

	Ok...  I've been meaning to ask something about this.  I've
been working with the Aironet cards on some wireless security projects.
I had been using a patched version of the aironet driver from the pcmcia
project with the 2.2 kernels but recently started looking at the 2.4.x
kernels and the drivers included there in.

	I'm a bit confused by this:

[mhw@alcove linux]$ find . -name airo\*
./drivers/net/aironet4500.h
./drivers/net/aironet4500_core.c
./drivers/net/pcmcia/aironet4500_cs.c
./drivers/net/aironet4500_card.c
./drivers/net/aironet4500_proc.c
./drivers/net/aironet4500_rid.c
./drivers/net/wireless/airo.c
./drivers/net/wireless/airo_cs.c

	I'm guessing that the aironet4500* stuff in the drivers/net
directory is for the ISA/PCI cards (which is really a PCMCIA adapter
with a card plugged into it) but what's the deal with the one in
pcmcia and how do all three sets of these (net, net/wireless, and net/pcmcia)
relate to one another?  Does the one in net supply the PCMCIA functions
and then depend on the one in net/wireless or do either of these
interrelate to the net/pcmcia.  All claim to be for the 4500 series
cards (at least) and I'm using 340/350s.  There also seem to be two
places to enable this.  One is under "Network Device Support" ->
"Wireless LAN" and the other under "PCMCIA Network Device Support"
"PCMCIA Wireless LAN".  But the 4500/4800/340/350 are all PCMCIA
cards with a PCMCIA adapter for PCI/ISA support.  Is there some
redundancy in here or are they all part and parcel of the same thing?

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

