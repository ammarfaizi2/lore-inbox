Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUBTKgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 05:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUBTKgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 05:36:45 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:14049 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S261154AbUBTKgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 05:36:43 -0500
From: Silla Rizzoli <s.rizzoli@communicationvalley.it>
Organization: Communication Valley spa
To: David Hinds <dhinds@sonic.net>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Date: Fri, 20 Feb 2004 11:36:03 +0100
User-Agent: KMail/1.6
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
References: <200402191222.45709.silla@netvalley.it> <Pine.LNX.4.58L.0402191011470.29796@logos.cnet> <20040219203234.GC1819@sonic.net>
In-Reply-To: <20040219203234.GC1819@sonic.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402201136.03774.s.rizzoli@communicationvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
