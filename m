Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSIKHes>; Wed, 11 Sep 2002 03:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSIKHes>; Wed, 11 Sep 2002 03:34:48 -0400
Received: from robur.slu.se ([130.238.98.12]:15376 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S318487AbSIKHer>;
	Wed, 11 Sep 2002 03:34:47 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15742.62693.570789.558310@robur.slu.se>
Date: Wed, 11 Sep 2002 09:46:45 +0200
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       hadi@cyberus.ca, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <3D7E2407.6060209@colorfullife.com>
References: <3D78F55C.4020207@colorfullife.com>
	<20020906.113829.65591342.davem@redhat.com>
	<3D790499.8020501@colorfullife.com>
	<20020906.123428.28085660.davem@redhat.com>
	<15741.57164.402952.136812@robur.slu.se>
	<3D7E2407.6060209@colorfullife.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 >  > Load   "Mode"
 >  > -------------------
 >  > Lo  1) RxIntDelay=0
 >  > Mid 2) RxIntDelay=fix (When we had X pkts on the RX ring)
 >  > Hi  3) Consecutive polling. No RX interrupts.

Manfred Spraul writes:

 > Sounds good.
 > 
 > The difficult part is when to go from Lo to Mid. Unfortunately my tulip 
 > card is braindead (LC82C168), but I'll try to find something usable for 
 > benchmarking

 21143 for tulip's. Well any NIC with "RxIntDelay"  should do.

 > In my tests with the winbond card, I've switched at a fixed packet rate:
 > 
 > < 2000 packets/sec: no delay
 >  > 2000 packets/sec: poll rx at 0.5 ms

 I was experimenting with all sorts of moving averages but never got a good 
 correlation with bursty network traffic as this level of resolution. The 
 only measure I found fast and simple enough for this was the number of 
 packets on the RX ring as I mentioned.


 Cheers.
						--ro
