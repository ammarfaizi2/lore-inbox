Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310442AbSCBUcf>; Sat, 2 Mar 2002 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310443AbSCBUcZ>; Sat, 2 Mar 2002 15:32:25 -0500
Received: from trillium-hollow.org ([209.180.166.89]:56253 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310442AbSCBUcH>; Sat, 2 Mar 2002 15:32:07 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: ja@ssi.bg (Julian Anastasov), szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: Your message of "Sat, 02 Mar 2002 20:22:51 GMT."
             <E16hG1r-0008Kh-00@the-village.bc.nu> 
Date: Sat, 02 Mar 2002 12:31:48 -0800
From: erich@uruk.org
Message-Id: <E16hGAW-0000Rw-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I would argue that this is a work-around to a problem, serves no
> > useful purpose, and in general this is violating the "principle of
> > least surprise".
> 
> I strongly disagree. The RFCs _are_ expected behaviour (with the odd
> exception like URG which BSD redefined by force)

Hmm.

My general contention is that the system should, by default, behave as
non-experts would expect, but this might be a point where we can't
agree.

It is, unfortunately, the cardinal rule when designing any usable
interfaces.  I reference Donald Norman's "The Design of Everyday
Things".  But I digress.


> >   2)  In my example above (and in fact any case of very asymmetric
> >       bandwidth) it ends up causing weird and highly suboptimal
> >       misbehavior.
> 
> Because you ran two different speed networks over the same cable without
> any seperation ?

I'll give up on this one relatively easily (though it was a switch,
so this is relevant)...  but a more pertinent example would be
if you have IP aliasing going on with 2 cards on the same network
for failover capability, and they might be asymmetric.  Again,
the expectation is that the "primary" one would be what is mainly
used.


> > Can you give me an argument for why these should be present?  (like
> > some kind of use for it?)
> 
> Internet standards. Along with the fact your perceived safety isnt there
> in the first place. Consider a source routed frame. Consider the fact
> most of your daemons bind to INADDR_ANY. It would be a false and misleading
> appearance of security at best.
> 
> If you want a firewall use firewall rules. If an end user is not sure
> how to set up a basic firewall they can run tools like gnome-lokkit
> and answer simple questions.

The firewall rules aren't as fine-grained as you're implying.  They
only accept packets or not, with the assumption that all programs
on the box are equally untrusted.

A good example is, you want a trivial high-security firewall, but
you want it to be a DNS and email server, knowing you only have
to be really careful about those 2 programs.

If the TCP/IP stack filters itself by what you've assigned it, then
you have the flexibility of using things like tcp wrappers (for
example) to allow one program but not another to accept things
from particular ports as well.   Though tcp wrappers have their
own host of problems.


> > on reception, just check against the exact expected input address,
> > would actually be a performance improvement on machines with multiple
> > NICs.
> 
> Hardly. You can have multiple addresses per nic anyway so its all the same
> routing hashes. You can also have multiple nics with the same address. Its
> already many<->many.

OK.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
