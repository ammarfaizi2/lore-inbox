Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268029AbTAIWoE>; Thu, 9 Jan 2003 17:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268043AbTAIWoE>; Thu, 9 Jan 2003 17:44:04 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35849 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268029AbTAIWoD>; Thu, 9 Jan 2003 17:44:03 -0500
Date: Thu, 9 Jan 2003 17:50:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew McGregor <andrew@indranet.co.nz>
cc: Fabio Massimo Di Nitto <fabbione@fabbione.net>,
       Wichert Akkerman <wichert@wiggy.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <78180000.1042055993@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1030109174736.30393A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Andrew McGregor wrote:

> Probably on the server's side it got an ICMP Host Unreachable or two as 
> some router updated its tables, and decided to close the connection.  The 
> FIN jumped the queue in one/several of the routers in the path, so it got 
> reordered relative to the data.  This would imply that the router in 
> question had its route to you back by the time the FIN got there.
> 
> Wierd, but far from impossible.

Nothing is impossible with routers, including sending ICMP packets using
different routing than TCP (and doing odd things with UDP as well).
Sometimes ICMP will be sent over a low bandwidth link with hopefully less
latency. The phrase "the less traveled way" comes to mind.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

