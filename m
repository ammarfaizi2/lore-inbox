Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSLERSH>; Thu, 5 Dec 2002 12:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267323AbSLERSH>; Thu, 5 Dec 2002 12:18:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62216 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261678AbSLERSF>; Thu, 5 Dec 2002 12:18:05 -0500
Date: Thu, 5 Dec 2002 12:24:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 gets duplex wrong on NIC
In-Reply-To: <3DED4698.60209@pobox.com>
Message-ID: <Pine.LNX.3.96.1021205120739.18090D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002, Jeff Garzik wrote:

> Bill Davidsen wrote:
> > In spite of modules.conf the system boots with the NIC in half duplex. I 
> > verified this with the mii-tool, I can set it full with mii-tool and it 
> > works right (copied a CD image 650MB), and the blade in the switch has 
> > been set either full or auto without gain. Yes, I tried the e100 driver as 
> > well.
> > 
> > Info I think shows this attached to prevent munging, let me know if more 
> > is needed.
> 
> 
> Lots of feedback/questions/response:
> 
> When you're on a network, more is always needed :)
> 
> Please give _plenty_ of details about what is on the other side of the 
> cable: hub? switch? vendor of hub/switch?  crossover to another NIC? 
> what is the port configuration and what are the capabilities of the 
> other end?  is it set to autonegotiate (on the other end)?

Cisco 5509 set auto.
> 
> Why do you force full duplex?  It is often the wrong thing to do.

It gives about 4x throughput...

The network folks say they have the same problem with most NICs and OS, so
they have to teach Windows users to diddle the NIC. At least I came to
them with the workaround. It's possible a known problem with those 10baseT
blades.

> 
> For eepro100, you should use module option 'options' to specify 
> 10baseT-FD... full_duplex appears to be somewhat redundant in the 
> context of your problem.

Okay, I assumed that since a grep showed:
  MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
that the option was supported. What does it do, if I need to diddle bits
in the options?

> For e100, you should use 'e100_speed_duplex' module option to specify media.
> 
> Finally, I would be very interested to know the results of using ethtool 
> to set, and get, your media settings.  It's in every distro these days, 
> plus you can d/l it from http://sf.net/projects/gkernel/

Well, it's not installed at any rate, so I'll have to download it. Timing
uncertain, I'm "off" for the next five days and leaving the site for home
shortly because I have a 131 mile commute and heavy snow. Perhaps from
home tonight.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

