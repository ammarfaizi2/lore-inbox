Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSIJQwI>; Tue, 10 Sep 2002 12:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSIJQwI>; Tue, 10 Sep 2002 12:52:08 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:14767 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S315439AbSIJQwH>;
	Tue, 10 Sep 2002 12:52:07 -0400
Message-ID: <3D7E2407.6060209@colorfullife.com>
Date: Tue, 10 Sep 2002 18:55:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Robert Olsson <Robert.Olsson@data.slu.se>
CC: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com, hadi@cyberus.ca,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D78F55C.4020207@colorfullife.com>	<20020906.113829.65591342.davem@redhat.com>	<3D790499.8020501@colorfullife.com>	<20020906.123428.28085660.davem@redhat.com> <15741.57164.402952.136812@robur.slu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Olsson wrote:
 >
 > Anyway. A tulip NAPI variant added mitigation when we reached "some
 > load" to  avoid the static interrupt delay. (Still keeping things
 > pretty simple):
 >
 > Load   "Mode"
 > -------------------
 > Lo  1) RxIntDelay=0
 > Mid 2) RxIntDelay=fix (When we had X pkts on the RX ring)
 > Hi  3) Consecutive polling. No RX interrupts.
 >
Sounds good.

The difficult part is when to go from Lo to Mid. Unfortunately my tulip 
card is braindead (LC82C168), but I'll try to find something usable for 
benchmarking

In my tests with the winbond card, I've switched at a fixed packet rate:

< 2000 packets/sec: no delay
 > 2000 packets/sec: poll rx at 0.5 ms



--
	Manfred

