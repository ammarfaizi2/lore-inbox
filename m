Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRBAGj6>; Thu, 1 Feb 2001 01:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129660AbRBAGjs>; Thu, 1 Feb 2001 01:39:48 -0500
Received: from styx.suse.cz ([195.70.145.226]:40951 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129290AbRBAGji>;
	Thu, 1 Feb 2001 01:39:38 -0500
Date: Thu, 1 Feb 2001 07:39:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Byron Stanoszek <gandalf@winds.org>
Cc: safemode <safemode@voicenet.com>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010201073933.A980@suse.cz>
In-Reply-To: <3A78945F.C82E7CAF@voicenet.com> <Pine.LNX.4.21.0101311937380.21983-100000@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101311937380.21983-100000@winds.org>; from gandalf@winds.org on Wed, Jan 31, 2001 at 07:46:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 07:46:31PM -0500, Byron Stanoszek wrote:

> > yea i know. . same mode       i also had a big problem with DMA timeouts on
> > 2.4 so  .. i dont know what's up with 2.4 and my motherboard ...    2.2
> > hasn't shown a single irq or DMA error yet since going back to it.
> > currently 2.2.19-pre7 is using UDMA4     i just flashed the bios today so ..
> > hopefully that should have fixed any problems.  I get 24MB/s each according
> > to hdparm -t   on my hdd's and both are on the same channel.   This is much
> > better than i ever got with 2.4 even when only one drive was on a channel.
> > Right now my k7-2 750 is at 849mhz with a FSB of 114Mhz and PCI at 34Mhz.
> > my nbench performance under 2.2 is comparable to results for 1Ghz t-bird's so
> > i'm happy with 2.2.  The only thing that would make me want to upgrade would
> > be latency patches.  I'm convinced 2.4 has performance issues so i guess i'll
> > be using 2.2 until 2.5 begins.      Is it really only 1 or 2 people having
> > this Via corruption problem?   i doubt it's a bios problem because wouldn't
> > 2.2 be effected by a bios bug if 2.4 is?   In either case the changelogs dont
> > show any  fixes for it.
> 
> If your FSB is running at 114 MHz, you should try the kernel parameter
> idebus=37 to get DMA working correctly. Otherwise you'll see an ide-reset error
> on bootup because the instructions are too fast. The VIA driver on 2.2 doesn't
> correctly program the PCI card, so you don't see weird behavior running 2.2
> with a faster PCI clock.
> 
> (Note: 1.14 * 33 = 37.6 PCI Clk)

It's 38:

114 / 3 == 38 == 1.14 * 33.333333

But definitely it isn't 34 or the default 33.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
