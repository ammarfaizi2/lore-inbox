Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <218640-220>; Thu, 25 Mar 1999 10:11:33 -0500
Received: by vger.rutgers.edu id <217775-220>; Thu, 25 Mar 1999 10:11:24 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:1931 "HELO ms2.inr.ac.ru" ident: "IDENT-NONSENSE") by vger.rutgers.edu with SMTP id <161470-221>; Thu, 25 Mar 1999 10:10:26 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <199903251506.SAA32185@ms2.inr.ac.ru>
Subject: Re: NAT and 2.2?
To: gmaxwell@Martin.FL.US (Greg Maxwell)
Date: Thu, 25 Mar 1999 18:06:06 +0300 (MSK)
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.GSO.3.96.990325081514.5266A-100000@da1server> from "Greg Maxwell" at Mar 25, 99 05:13:09 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: owner-linux-kernel@vger.rutgers.edu

Hello!

> Can the new IP ROUTE stuff in 2.2 do ONE-ONE NAT insted of the standard
> good ole MASQ (MANY-ONE)? I got hit with having to set up a nat solution
> by Saturday AM, and it looks like Linux is the only thing that could hit
> that deadline within budget.

ONE-ONE is the only thing, which ROUTE_NAT is able. It is supposed to be
used for site renumbering and to facilitate policy routing, rather
then to compress ip address space or to split load.

The setup is very easy: micro-howto may be found
at http://www.compendium.com.ar/policy-routing.txt
It is very small, but contains basic hints.

Also: ftp://post.tepkom.ru/pub/vol2/Linux/docs/advanced-routing.txt

> I'll also need it to pass through port numbers unmolested. :( (stupid
> state security). 

I failed to parse it, but try to continue 8)

- it is stateless to be scalable. -> no dynamic nat, no load splitting.
- it does not touch packet payload to be fast and does not check
  it to be not ambigous. -> no active ftp in one direction and no passive
			    in backward.
- it is not intended to remap only range of ports, though
  it is possible with fwmark.

Alexey Kuznetsov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
