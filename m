Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTIPVPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTIPVPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:15:16 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:52490 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262498AbTIPVPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:15:10 -0400
Date: Tue, 16 Sep 2003 18:16:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Olivier Galibert <galibert@limsi.fr>
cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: <20030916195345.GB68728@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.44.0309161814410.15569-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Sep 2003, Olivier Galibert wrote:

> On Tue, Sep 16, 2003 at 07:10:57PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > Well, I do understand the bounce buffer problem, but honestly the current way
> > > > of handling the situation seems questionable at least. If you ever tried such a
> > > > system you notice it is a lot worse than just dumping the additional ram above
> > > > 4GB. You can really watch your network connections go bogus which is just
> > > > unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> > > > do something useful with the beyond-4GB ram parts?
> > > 
> > > The 2.6 tree is somewhat better about this but at the end of the day if
> > > your I/O subsystem can't do the job your box will not perform ideally.
> > > For some workloads its a huge win to have the extra RAM, for others the
> > > I/O is a real pain. 
> > 
> > If he has trouble logging in, then there's a bug somewhere.
> > Bounce buffers should not slow machine down more than
> > 2x, and from his description it looks like way worse slowdown. 
> 
> The box does not just slowdown, the box crawls on the floor wimpering.
> Nothing works except ping until the i/os are finished (and they seem
> to crawl too), then everything works perfectly again.
> 
> We're quite eager to fix the problem too, if you want us to test some
> things.

Which card and driver are you using for IO? 3ware?

How much RAM do you have?

I remember I tested heavy IO loads (heavy swapping and dbench) on 8GB
machine and all worked fine (interactive terminal, etc) but that was a
looong time ago back in 2.4.







