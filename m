Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbQL1XYT>; Thu, 28 Dec 2000 18:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132643AbQL1XYJ>; Thu, 28 Dec 2000 18:24:09 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:13986 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S132642AbQL1XYA>; Thu, 28 Dec 2000 18:24:00 -0500
Date: Thu, 28 Dec 2000 23:53:33 +0100
To: indyj@oragroup.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12: PCMCIA IRQ assignments?
Message-ID: <20001228235333.C1368@storm.local>
Mail-Followup-To: indyj@oragroup.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012260719440.29885-100000@merlot.oragroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012260719440.29885-100000@merlot.oragroup.com>; from indyj@oragroup.com on Tue, Dec 26, 2000 at 07:24:39AM -0500
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2000 at 07:24:39AM -0500, indyj@oragroup.com wrote:
> 
> Hello,
> 
> I have a Sager NP9820 laptop with an ALI chipset and a TI PCI1251BGFN
> PCMCIA chipset.  For some reason, when I use the yenta module under 2.4.0,
> it gets an incorrect IRQ assignment.  It uses IRQ11, which is also used by
> my ATI Rage Pro card... therefore, when you install this module, the
> machine locks up.
> 
> If I use the pcmcia card services under 2.2.16, then the PCMCIA bridge
> gets a correct assignment of IRQ 10.  I've poked around a bit and haven't
> found a way to force the 2.4.0 module to use a specific IRQ... is there a
> way to do this without hardcoding it?

Do you have a sound driver loaded?  I can use my CardBus Ethernet card
only without a sound driver, then the CardBus bridge and Ethernet card
show up on IRQ10.  Mysteriously however loading the i810_audio driver
(for a 440MX chip) moves the bridge to IRQ11 (the same as the 440MX).

No lockup, but the bridge and Ethernet card don't work then.  I'd be
interested what happens in your case.

More specifically, as the PCI code enables the 440MX sound device it
logs that it uses the same IRQ as the cb bridge, meaning the IRQ changed
already.  This is 2.4.0-test12.

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
