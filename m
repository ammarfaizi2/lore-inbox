Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJURfI>; Mon, 21 Oct 2002 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJURe7>; Mon, 21 Oct 2002 13:34:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:56540 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261582AbSJURd5>;
	Mon, 21 Oct 2002 13:33:57 -0400
Date: Mon, 21 Oct 2002 10:39:50 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 orinoco_cs with Lucent WaveLAN "bronze"
Message-ID: <20021021173949.GC20616@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200210190922.g9J9M4p15225@Port.imtp.ilyichevsk.odessa.ua> <20021019105938.A14830@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019105938.A14830@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 10:59:38AM +0100, Russell King wrote:
> On Sat, Oct 19, 2002 at 02:14:57PM +0000, Denis Vlasenko wrote:
> > Today I played with wireless LAN euqipment for the first time.
> > I have ISA-to-PCMCIA converter and a Lucent (IEEE) PCMCIA card.
> > I set up everything as directed by HOWTOs. I do:

	Most problem is XXX-to-Pcmcia converters are interrupt
problems. Make sure irqs are delivered to the driver.

> Yes, I also noticed many problems with the current orinoco_cs driver.
> I've reported them to David, but had very little response thus far.
> Basically, iwconfig ethx essid foo appears to crash the cards firmware
> (I get really interesting series of words in the chips registers giving
> a nice ASCII string.)
> 
> I did find that if I took the wvlan_cs driver from a Red Hat kernel and
> drop it into 2.5, it works (as far as I can tell) quite nicely.
> 
> Unfortunately, I haven't been able to do any further investigation of
> this; I'm not too bothered because wvlan_cs gets me working.
> 
> (My card is a Lucent WaveLAN Silver)
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html

	Which firmware is on the card ?
	For me, the most usable orinoco.c was release 8b, which was a
long while back. I personally want to see HostAP in the kernel, which
should take care of PrismII cards, but we still need to get our
Orinoco support on track, so send the reports to David.
	Thanks...

	Jean

