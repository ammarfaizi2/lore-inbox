Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310434AbSCBUKQ>; Sat, 2 Mar 2002 15:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSCBUKG>; Sat, 2 Mar 2002 15:10:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17412 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310434AbSCBUJw>; Sat, 2 Mar 2002 15:09:52 -0500
Subject: Re: Network Security hole (was -> Re: arp bug )
To: erich@uruk.org
Date: Sat, 2 Mar 2002 20:22:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ja@ssi.bg (Julian Anastasov),
        szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E16hFeV-0000Nj-00@trillium-hollow.org> from "erich@uruk.org" at Mar 02, 2002 11:58:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hG1r-0008Kh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would argue that this is a work-around to a problem, serves no
> useful purpose, and in general this is violating the "principle of
> least surprise".

I strongly disagree. The RFCs _are_ expected behaviour (with the odd
exception like URG which BSD redefined by force)

>   2)  In my example above (and in fact any case of very asymmetric
>       bandwidth) it ends up causing weird and highly suboptimal
>       misbehavior.

Because you ran two different speed networks over the same cable without
any seperation ?

> Can you give me an argument for why these should be present?  (like
> some kind of use for it?)

Internet standards. Along with the fact your perceived safety isnt there
in the first place. Consider a source routed frame. Consider the fact
most of your daemons bind to INADDR_ANY. It would be a false and misleading
appearance of security at best.

If you want a firewall use firewall rules. If an end user is not sure how to
set up a basic firewall they can run tools like gnome-lokkit and answer simple
questions.

> the arp thing, because I saw warning messages from my FreeBSD boxen
> about these weird arps.

FreeBSD binds arp to the specific interface, but accepts packets on any
(from memory). The warnings it issues about the ARPs are a bug because the
RFC's make no assertions about ARP replies being host or address based.

> on reception, just check against the exact expected input address,
> would actually be a performance improvement on machines with multiple
> NICs.

Hardly. You can have multiple addresses per nic anyway so its all the same
routing hashes. You can also have multiple nics with the same address. Its
already many<->many.

Alan
