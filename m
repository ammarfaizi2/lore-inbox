Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbSI3Opu>; Mon, 30 Sep 2002 10:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbSI3Opu>; Mon, 30 Sep 2002 10:45:50 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:12043 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262087AbSI3Opt>; Mon, 30 Sep 2002 10:45:49 -0400
Date: Mon, 30 Sep 2002 11:50:46 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, "David S. Miller" <davem@redhat.com>,
       mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930145046.GE11312@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	"David S. Miller" <davem@redhat.com>, mingo@elte.hu,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, wli@holomorphy.com,
	kuznet@ms2.inr.ac.ru
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain> <20020930004559.A19071@in.ibm.com> <20020929.172022.23984844.davem@redhat.com> <20020930100317.A21939@in.ibm.com> <20020930043829.GG9920@conectiva.com.br> <1033390556.16266.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033390556.16266.36.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2002 at 01:55:56PM +0100, Alan Cox escreveu:
> On Mon, 2002-09-30 at 05:38, Arnaldo Carvalho de Melo wrote:
> > I'm working on Appletalk, will be fixed after X.25, humm, in fact Appletalk
> > only uses SNAP on Ethernet, so it is only broken for ppptalk and ltalk, does
> > anybody still uses these later two?
> 
> ppptalk is relevant to the modern world, localtalk is basically for
> talking to old macintoshes many of which don't have any capability for
> ethernet. I don't think either of them are even going to be performance
> matters.

OK, but even those will be taken care of, as the changes had to be done anyway
for SNAP, so I'll just stick the (void*)1 to its packet_types.
 
> > Nobody working on this, as far as I know
> > >         econet/af_econet.c
> 
> Ancient BBC micro protocol, could probably be done just as well in user
> space. 

As some of the other protocols, but at this point it may well be easier to
fix it in the kernel where it sits 8)

Oh, dang, I forgot that these other protocols can work on fast lines these
days 8)

- Arnaldo
