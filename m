Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272518AbRIFTd1>; Thu, 6 Sep 2001 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272523AbRIFTdR>; Thu, 6 Sep 2001 15:33:17 -0400
Received: from spike.porcupine.org ([168.100.189.2]:44810 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272521AbRIFTdF>; Thu, 6 Sep 2001 15:33:05 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
In-Reply-To: <Pine.LNX.4.33.0109061208310.24712-100000@twinlark.arctic.org>
 "from dean gaudet at Sep 6, 2001 12:15:56 pm"
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Date: Thu, 6 Sep 2001 15:33:24 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906193324.51AA9BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet:
> On Thu, 6 Sep 2001, Wietse Venema wrote:
> 
> > Andrey Savochkin:
> > > > That is not practical. Surely there is an API to find out if an IP
> > > > address connects to the machine itself. If every UNIX system on
> > > > this planet can do it, then surely Linux can do it.
> > >
> > > Let me correct you: you need to recognize not addresses that result in
> > > connecting to the _machine_ itself, but connecting to the same _MTA_.
> >
> > The SMTP RFC requires that user@[ip.address] is correctly recognized
> > as a final destination.  This requires that Linux provides the MTA
> > with information about IP addresses that correspond with INADDR_ANY.
> >
> > I am susprised that it is not possible to ask such information up
> > front (same with netmasks), and that an application has to actually
> > query a complex oracle, again and again, for every IP address.
> 
> how does your MTA figure out that it's behind a NAT?  it doesn't matter
> what unix it's running on, there's no standard way for it to know that an
> address translation has occured before getting to its front-door.

The MTA does not have to know. The DNS on the inside of the NAT
gateway should list "inside" machines by their "inside" address.

That eliminates a lot of other problems as well.

	Wietse
