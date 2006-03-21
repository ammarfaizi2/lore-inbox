Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWCUPpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWCUPpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWCUPpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:45:43 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:38309 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751795AbWCUPpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:45:42 -0500
Date: Tue, 21 Mar 2006 15:51:34 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: dipankar@in.ibm.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       jens.laas@data.slu.se, hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <20060321.023705.26111240.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
 <20060320220956.GA24792@in.ibm.com> <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
 <20060321.023705.26111240.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2006, David S. Miller wrote:

> From: Jesper Dangaard Brouer <hawk@diku.dk>
> Date: Tue, 21 Mar 2006 11:29:16 +0100 (CET)
>
>> Do you have an explaination of the syslog listing, showing yet another
>> code path sleeping/failing??.  In the fib_trie code. (I have recorded 12
>> of these).
>
> If you happen to have the IP_ROUTE_MULTIPATH_CACHED config option
> enabled in your kernels, please turn it off and retest.

You guessed right... I did enable IP_ROUTE_MULTIPATH_CACHED, I have now 
disabled it and equal multi path routing in general (CONFIG_IP_ROUTE_MULTIPATH).

As it is a production server, I'll need to schedule a reboot. The server 
has now been running a 2.4.26 kernel for 16 hours without any kernel 
panics.  And the ip_dst_cache can grow and shink.

cat /proc/slabinfo | grep ip_dst_cache
ip_dst_cache       15300  56145    256 1022 3743    1

Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------
