Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130257AbRCCDio>; Fri, 2 Mar 2001 22:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130261AbRCCDie>; Fri, 2 Mar 2001 22:38:34 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16914
	"EHLO gateway.matchmail.com") by vger.kernel.org with ESMTP
	id <S130257AbRCCDi3>; Fri, 2 Mar 2001 22:38:29 -0500
Message-ID: <3AA06720.77D94BFE@matchmail.com>
Date: Fri, 02 Mar 2001 19:38:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Advanced Routing and Trafic Control <lartc@mailman.ds9a.nl>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [LARTC] 1 adsl + 1 sdsl + masq + simultaneous incomming routes]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phil@optimumdata.com wrote:
> 
> On Fri, 2 Mar 2001, Mike Fedyk wrote:
> 
> > I have two dsl links, each with one ip, and a single gateway is assigned the ip
> > for each.
> >
> >  ______    ______
> > | ADSL |  | SDSL |
> > |______|  |______|
> >        \  /
> >         \/
> >      ___||____
> >     | gateway |
> >     |_________|
> >         ||
> >         ||
> >         ||
> >        _||__
> >       | web |
> >       |_____|
> >
> > OK.
> >
> > The problem: I am able to have the web server use one or the other dsl, but not
> > both at the same time.
> >
> > If I have web set to sdsl, replies to queries that came from adsl go out on the
> > sdsl link. Also since masq is involved, it also responds with the sdsl ip.
> >
> > How can I have replies go back on the correct internet link?  OH, btw, the web
> > server is NT, so I won't be able to modify any packets there...
> 
> What I've done is to put two IPs on the server (your web server, in this
> case). You would then have the gateway send one IP out via ADSL, and the
> out via SDSL.
> 
> There is no way I know of to make that work.
> 
> --
> -----------------------------------------------------------------------
> Phil Brutsche                                      phil@optimumdata.com

There has to be a better way.  I'm forwarding this to LKML.  Maybe they have a
better idea...

I know the kernel keeps a route cache, is there something like a reverse MASQ
feature somewhere.  Storing which incoming route + port number and keeping a
dynamic list...

TIA,

Mike
