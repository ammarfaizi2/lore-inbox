Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWA2TP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWA2TP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWA2TP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:15:26 -0500
Received: from drugphish.ch ([69.55.226.176]:43728 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751118AbWA2TP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:15:26 -0500
Message-ID: <43DD144C.9010709@drugphish.ch>
Date: Sun, 29 Jan 2006 20:15:24 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Willy Tarreau <wtarreau@exosec.fr>
Cc: linux-kernel@vger.kernel.org, Syed Ahemed <kingkhan@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [ANNOUNCE] Linux 2.4.32-hf32.2
References: <20060129175647.GA21999@exosec.fr>
In-Reply-To: <20060129175647.GA21999@exosec.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

> Changelog from 2.4.32-hf32.1 to 2.4.32-hf32.2

Which of those are you going to push to Marcelo for inclusion?

I've found two subtle IPVS bugs (using a persistency setup on SMP 
combined with sharp TCP state transition timeouts), one of which is 
fixed in my tree and has been running in production for over 1 month 
now. The other is still in discussion phase with Horms and Julian Anastasov.

> + 2.4.32-bond_alb-hash-table-corruption-1                (ODonnell, Michael)
> 
>   Our systems have been crashing during testing of PCI HotPlug
>   support in the various networking components. We've faulted in
>   the bonding driver due to a bug in bond_alb.c:tlb_clear_slave().
>   In that routine, the last modification to the TLB hash table is
>   made without protection of the lock, allowing a race that can
>   lead tlb_choose_channel() to select an invalid table element.

This is correct. Funny, It never triggered on my systems, but I only 
have a bonding setup on three SMP systems, probably none of them using ALB.

Thanks for your hard work,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc
