Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272717AbRIGPfz>; Fri, 7 Sep 2001 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272716AbRIGPfm>; Fri, 7 Sep 2001 11:35:42 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:41226 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S272717AbRIGPf0>; Fri, 7 Sep 2001 11:35:26 -0400
Date: Fri, 7 Sep 2001 17:34:35 +0200
From: Kurt Roeckx <Q@ping.be>
To: Wietse Venema <wietse@porcupine.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010907173435.A469@ping.be>
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010906173948.502BFBC06C@spike.porcupine.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 01:39:48PM -0400, Wietse Venema wrote:
> Andrey Savochkin:
> > > That is not practical. Surely there is an API to find out if an IP
> > > address connects to the machine itself. If every UNIX system on
> > > this planet can do it, then surely Linux can do it.
> > 
> > Let me correct you: you need to recognize not addresses that result in
> > connecting to the _machine_ itself, but connecting to the same _MTA_.
> 
> The SMTP RFC requires that user@[ip.address] is correctly recognized
> as a final destination.  This requires that Linux provides the MTA
> with information about IP addresses that correspond with INADDR_ANY.

I see no such thing in the RFC.  What I do see is that you're
allow to use the [IP address] notation.  It can't see where it
says that if that IP address is an IP address of the local host,
that it should accept it as the final destination.

I can perfectly imagine that the same hosts runs serveral MTAs,
on different IP addresses, and that both might have the same
username, but it's for a different person.

If an MTA doesn't listen to INADDR_ANY, why should it need to
know all addresses that might correspond to it?  That shouldn't
mean that if it does listen to INADDR_ANY, it should know them
all, but that could be something an MTA might want to do.
Like Andrey says, it needs to go to the same MTA.

If for some reason it was needed to use the IP address in the
destination, it's very likely that when it reaches the final
host, it will be a connection to that IP address.  Atleast, seen
from the connecting host.  If it's using NAT, maybe there should
be some option to tell it to accept that IP address as a final
destination too.


Kurt

