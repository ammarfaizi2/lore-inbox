Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbUCSSdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbUCSSdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:33:47 -0500
Received: from mail.cyclades.com ([64.186.161.6]:11394 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263067AbUCSSdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:33:44 -0500
Date: Fri, 19 Mar 2004 15:14:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: David Hinds <dhinds@sonic.net>
Cc: rmk+lkml@arm.linux.org.uk, <daniel.ritz@gmx.ch>,
       <linux-kernel@vger.kernel.org>
Subject: REMINDER: 2.4.25 and 2.6.x yenta detection issue
Message-ID: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

It seems the problem reported by Silla Rizzoli is still present in 2.6.x
and 2.4.25 (both include the voltage interrogation patch by rmk).

Daniel Ritz made some efforts to fix it, but did not seem to get it right. 

Just a reminder.

Maybe we should add it to the bugzilla? 

---------- Forwarded message ----------
Date: Fri, 20 Feb 2004 11:36:03 +0100
From: Silla Rizzoli <s.rizzoli@communicationvalley.it>
To: David Hinds <dhinds@sonic.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
     linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.4.25 yenta problem and small fix/workaround

> That is a pisser.  What brand and model of laptop is this, exactly?
> Did you ever use the pcmcia-cs modules on this laptop, and if so, did
> they behave the same?  Does this happen with a specific card?  Which
> one(s) are you using?  Does it happen if you hot insert the card, or
> only if the card is inserted at startup?  What CardBus bridge do you
> have (use 'lspci -v')?
>
> As Marcello said, the change was introduced specifically to avoid this
> sort of problem, on certain other laptops.
>
> -- Dave

The laptop is an IBM R40 2681-BDG. That means P4 1.8 GHz (non-Centrino), with 
chipset 845.


I own two pc cards, a Cisco Aironet 350 (AIR-PCM352) and a Option Globetrotter 
GSM/GPRS card, driven using serial_cs.

The cards always get correctly recognized in they are already inserted at boot 
time, but rarely if plug them in when my Gentoo has finished booting. To make 
them work a cardctl insert 0 (I only have one socket) usually helps, 
sometimes I have to unload/reload the pcmcia modules, and very very rarely a 
reboot is needed; this happens with 2.6.x and 2.4.25. The two PC Cards behave 
the same, maybe the Cisco one is a bit more picky.

You'll find a complete lspci here: 
http://www.communicationvalley.it/lspci.txt

The kernel config for 2.6.3 here:
http://www.communicationvalley.it/2.6.3-oldradeon.cfg

The kernel config for 2.4.25 here:
http://www.communicationvalley.it/2.4.25.config

I only used pcmcia-cs on a distant past, but I'm downloading them now, I'll 
let you know how they work very soon.

Thanks,
-- 
Silla Rizzoli
Communication Valley SpA
Strada Quarta 6/1D
43100 Parma
Tel: +39-0521-4980
Fax: +39-0521-498080
http://www.communicationvalley.it/



