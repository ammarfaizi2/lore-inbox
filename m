Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUHWJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUHWJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUHWJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:37:28 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:18356 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S267621AbUHWJhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:37:22 -0400
Date: Mon, 23 Aug 2004 11:37:16 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: IEEE-1588
In-Reply-To: <200408230453.35598.gene.heskett@verizon.net>
Message-Id: <Pine.OSF.4.05.10408231112350.29749-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, NTP is a different protocol altogether. NTP runs on top of IP.
IEEE-1588 runs on the side IP and needs at least support in the driver
layer - if not the hardware layer!

NTP is supposed to be used over the wide area network. IEEE-1588 is for local 
area networks - mostly ethernet. NTP relies on IP for routing to
other networks, IEEE-1588 relies on "boundary" clocks between the
networks, i.e. the routers have IEEE-1588 implemented.

Take a look at
 http://ieee1588.nist.gov/

(Ethereal is mentioned as understanding IEEE-1588 :-)

Esben

On Mon, 23 Aug 2004, Gene Heskett wrote:

> On Monday 23 August 2004 03:51, Esben Nielsen wrote:
> >Does anyone know about that standard for time syncronization? Is
> > there any work on Linux-support?
> >
> >Esben
> 
> Sure.  There is ntpdate, intended for gross corrections at boot time, 
> and ntp, which finetunes things if you need microsecond accuracy all 
> day long.  I don't, so I just run ntpdate at boot time and 4x a day 
> with cron against 4 servers chosen at random from a list of 33, using 
> a script and a list of servers someone posted years ago now.
> 
> Both are installed in a normal full install, but not this script.  ntp 
> as I understand it needs configured before its used, but it can be 
> run from /etc/init.d by turning it on with chkconfig once its 
> configured.
> 
> -- 
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.24% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attorneys please note, additions to this message
> by Gene Heskett are:
> Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
> 


