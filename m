Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTBLDmi>; Tue, 11 Feb 2003 22:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTBLDmi>; Tue, 11 Feb 2003 22:42:38 -0500
Received: from relief.getitback.org ([208.49.116.17]:26372 "EHLO
	relief.getitback.org") by vger.kernel.org with ESMTP
	id <S266224AbTBLDmh>; Tue, 11 Feb 2003 22:42:37 -0500
Date: Tue, 11 Feb 2003 22:52:17 -0500
From: Paul <set@pobox.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <mzyngier@freesurf.fr>
Subject: Re: 2.5.60 3c509 & net/Space.c problem
Message-ID: <20030212035217.GE1733@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Marc Zyngier <mzyngier@freesurf.fr>
References: <200302110144.CAA15199@kim.it.uu.se> <20030210182619.3b6791cc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210182619.3b6791cc.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com>, on Mon Feb 10, 2003 [06:26:19 PM] said:
[...]
> 
> I'm looking for someone to pump some bytes through this fix.
> 
> 
> 
> Patch from Marc Zyngier <mzyngier@freesurf.fr>
> 
> 
>  drivers/net/3c509.c |   66 +++++++++++++++++++++++++++++-----------------------
>  drivers/net/Space.c |    3 --
>  2 files changed, 37 insertions(+), 32 deletions(-)

	Hi;

	Tested this under 2.5.60, and Marc's other patch against
2.5.59 -- compiles and works.

eth0      Link encap:Ethernet  HWaddr 00:60:8C:CB:99:78  
          inet addr:192.168.2.21  Bcast:192.168.2.255 Mask:255.255.255.0
          UP BROADCAST NOTRAILERS RUNNING  MTU:1500  Metric:1
          RX packets:946103 errors:62 dropped:0 overruns:56 frame:62
          TX packets:360895 errors:0 dropped:0 overruns:0 carrier:0
          collisions:45706 txqueuelen:100 
          RX bytes:1190605511 (1135.4 Mb)  TX bytes:357493752 (340.9 Mb)
          Interrupt:10 Base address:0x300 

	RX errors increase under just about any load, similar to
2.4 kernel-- this traffic is over effectively a 2 computer
network. The machine is a k6-II 333. I dont think Ive ever
noticed errors with a wd8013 in this box....

Paul
set@pobox.com

