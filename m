Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272508AbRIFTPz>; Thu, 6 Sep 2001 15:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272509AbRIFTPp>; Thu, 6 Sep 2001 15:15:45 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:26120 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S272508AbRIFTPh>; Thu, 6 Sep 2001 15:15:37 -0400
Date: Thu, 6 Sep 2001 12:15:56 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Wietse Venema <wietse@porcupine.org>
cc: Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip
 alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906173948.502BFBC06C@spike.porcupine.org>
Message-ID: <Pine.LNX.4.33.0109061208310.24712-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Wietse Venema wrote:

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
>
> I am susprised that it is not possible to ask such information up
> front (same with netmasks), and that an application has to actually
> query a complex oracle, again and again, for every IP address.

how does your MTA figure out that it's behind a NAT?  it doesn't matter
what unix it's running on, there's no standard way for it to know that an
address translation has occured before getting to its front-door.

i've dealt with almost the exact same problem you're dealing with now when
i was correcting apache's virtual hosting mechanism.  the only solution
which i found to work *always* was to force the administrator to
explicitly list the addresses.

-dean

