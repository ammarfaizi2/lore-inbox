Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbSI0Ir1>; Fri, 27 Sep 2002 04:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSI0Ir1>; Fri, 27 Sep 2002 04:47:27 -0400
Received: from dclient217-162-208-99.hispeed.ch ([217.162.208.99]:35390 "EHLO
	alder.intra.bruli.net") by vger.kernel.org with ESMTP
	id <S261380AbSI0Ir0>; Fri, 27 Sep 2002 04:47:26 -0400
From: "Martin Brulisauer" <martin@bruli.net>
To: Ernst Herzberg <earny@net4u.de>, Marco Colombo <marco@esi.it>
Date: Fri, 27 Sep 2002 10:52:41 +0200
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Reply-to: martin@bruli.net
CC: Adam Goldstein <Whitewlf@Whitewlf.net>, <linux-kernel@vger.kernel.org>
Message-ID: <3D943879.10625.35E0D4C@localhost>
References: <200209260503.02474.earny@net4u.de>
In-reply-to: <Pine.LNX.4.44.0209262035060.26363-100000@Megathlon.ESI>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Turn on extended status in your apache configuration file:
-> ExtendedStatus On
so you can see more information on what the server is
doing. The information looks like:

Current Time: Friday, 27-Sep-2002 10:48:59 CEST
Restart Time: Tuesday, 27-Aug-2002 17:42:47 CEST
Parent Server Generation: 32 
Server uptime: 30 days 17 hours 6 minutes 12 seconds
Total accesses: 256966 - Total Traffic: 1.7 GB
CPU Usage: u11.3027 s6.76172 cu14.4033 cs2.29785 - .00131% CPU 
load
.0968 requests/sec - 702 B/second - 7.1 kB/request
1 requests currently being processed, 5 idle servers 

Martin


On 26 Sep 2002, at 20:36, Marco Colombo wrote:

> On Thu, 26 Sep 2002, Ernst Herzberg wrote:
> 
> > First reconfigure your apache, with
> > 
> > MaxClients 256  # absolute minimum, maybe you have to recompile apache
> > MinSpareServers 100  # better 150 to 200
> > MaxSpareServers 200 # bring it near MaxClients
> 
> KeepAlive		On
> MaxKeepAliveRequests	1000
> 
> .TM.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


