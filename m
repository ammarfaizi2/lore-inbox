Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130266AbRCCEUK>; Fri, 2 Mar 2001 23:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRCCEUA>; Fri, 2 Mar 2001 23:20:00 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:37832 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130266AbRCCETr>; Fri, 2 Mar 2001 23:19:47 -0500
Message-ID: <3AA06FCE.C47C194A@coplanar.net>
Date: Fri, 02 Mar 2001 23:15:10 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Advanced Routing and Trafic Control <lartc@mailman.ds9a.nl>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [LARTC] 1 adsl + 1 sdsl + masq + simultaneous incomming 
 routes]
In-Reply-To: <3AA06720.77D94BFE@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> phil@optimumdata.com wrote:
> >
> > On Fri, 2 Mar 2001, Mike Fedyk wrote:
> >
> > > I have two dsl links, each with one ip, and a single gateway is assigned the ip
> > > for each.
> > >
> > >  ______    ______
> > > | ADSL |  | SDSL |
> > > |______|  |______|
> > >        \  /
> > >         \/
> > >      ___||____
> > >     | gateway |
> > >     |_________|
> > >         ||
> > >         ||
> > >         ||
> > >        _||__
> > >       | web |
> > >       |_____|
> > >
> > > OK.
> > >
> > > The problem: I am able to have the web server use one or the other dsl, but not
> > > both at the same time.
> > >
> > > If I have web set to sdsl, replies to queries that came from adsl go out on the
> > > sdsl link. Also since masq is involved, it also responds with the sdsl ip.
> > >
> > > How can I have replies go back on the correct internet link?  OH, btw, the web
> > > server is NT, so I won't be able to modify any packets there...
> >
> > What I've done is to put two IPs on the server (your web server, in this
> > case). You would then have the gateway send one IP out via ADSL, and the
> > out via SDSL.
> >
> > There is no way I know of to make that work.
> >
> > --
> > -----------------------------------------------------------------------
> > Phil Brutsche                                      phil@optimumdata.com
>
> There has to be a better way.  I'm forwarding this to LKML.  Maybe they have a
> better idea...
>
> I know the kernel keeps a route cache, is there something like a reverse MASQ
> feature somewhere.  Storing which incoming route + port number and keeping a
> dynamic list...

try www.liuxdoc.org search for iproute2 and netfilter.

with 2.4. kernel, you can mark packets *before* they go through routing table,
and the routing tablecan use mark value to choose which route to use,
so if you use set up the NT box with two IP's, your firewall can
mark packets based on destination (on webserver) IP.
think of it like having two default routes...

