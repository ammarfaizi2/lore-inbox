Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWA2TYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWA2TYq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWA2TYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:24:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25103 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751123AbWA2TYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:24:46 -0500
Date: Sun, 29 Jan 2006 20:24:17 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Willy Tarreau <wtarreau@exosec.fr>, linux-kernel@vger.kernel.org,
       Syed Ahemed <kingkhan@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [ANNOUNCE] Linux 2.4.32-hf32.2
Message-ID: <20060129192417.GZ7142@w.ods.org>
References: <20060129175647.GA21999@exosec.fr> <43DD144C.9010709@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DD144C.9010709@drugphish.ch>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roberto,

On Sun, Jan 29, 2006 at 08:15:24PM +0100, Roberto Nibali wrote:
> Hi Willy,
> 
> >Changelog from 2.4.32-hf32.1 to 2.4.32-hf32.2
> 
> Which of those are you going to push to Marcelo for inclusion?

They're all in Marcelo's tree (at least in -git). I try to avoid publishing
patches which can escape from mainline because it's harder to re-include
them afterwards. That's also why one of them got missed in hf32.1.

> I've found two subtle IPVS bugs (using a persistency setup on SMP 
> combined with sharp TCP state transition timeouts), one of which is 
> fixed in my tree and has been running in production for over 1 month 
> now. The other is still in discussion phase with Horms and Julian 
> Anastasov.

OK, I hope you'll be able to send the fixes early enough for inclusion
in 2.4.33.

> >+ 2.4.32-bond_alb-hash-table-corruption-1                (ODonnell, 
> >Michael)
> >
> >  Our systems have been crashing during testing of PCI HotPlug
> >  support in the various networking components. We've faulted in
> >  the bonding driver due to a bug in bond_alb.c:tlb_clear_slave().
> >  In that routine, the last modification to the TLB hash table is
> >  made without protection of the lock, allowing a race that can
> >  lead tlb_choose_channel() to select an invalid table element.
> 
> This is correct. Funny, It never triggered on my systems, but I only 
> have a bonding setup on three SMP systems, probably none of them using 
> ALB.

I've never used ALB either.

> Thanks for your hard work,
> Roberto Nibali, ratz

Thanks,
Willy

