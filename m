Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbRF2BS5>; Thu, 28 Jun 2001 21:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbRF2BSr>; Thu, 28 Jun 2001 21:18:47 -0400
Received: from king.mcs.drexel.edu ([129.25.6.170]:3223 "EHLO
	king.mcs.drexel.edu") by vger.kernel.org with ESMTP
	id <S264673AbRF2BSh>; Thu, 28 Jun 2001 21:18:37 -0400
From: David McWherter <udmcwher@mcs.drexel.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.55148.88937.894314@tangent.mcs.drexel.edu>
Date: Thu, 28 Jun 2001 21:18:36 -0400
To: Andreas Schuldei <andreas@schuldei.org>
Cc: linux-kernel@vger.kernel.org
Subject: artificial latency for a network interface
In-Reply-To: <20010629003900.A6065@sigrid.schuldei.com>
In-Reply-To: <20010629003900.A6065@sigrid.schuldei.com>
X-Mailer: VM 6.93 under Emacs 20.7.1
Reply-To: udmcwher@mcs.drexel.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I once solved this problem using the QoS qdisc facilites:

 http://edge.mcs.drexel.edu/GICL/people/udmcwher/dnt/DNT.html

It works on 2.2 kernels as well.

-david

Andreas Schuldei writes:
 > to simulate a sattelite link, I need to add a latency to a
 > network connection. 
 > 
 > What is the easiest and best way to do that?
 > 
 > I wanted to do that using two tun devices. 
 > I had hoped to have a routing like this:
 > 
 >  <-> eth0 <-> tun0 <-> userspace, waiting queue <-> tun1 <-> eth1
 > 
 > I need to do it this way and not with iptables help, because it
 > needs to work also on 2.2.x kernels.
 > 
 > Now I started experimenting with the tun0 interfaces and got
 > problems: till now I have not succeeded to get a tun0 interface
 > up. the example code (br_select.c) in the package (as found for
 > example on sourceforge) looks fishy and does not work too well. 
 > is it correct that only one /dev/tun file is necessary, but
 > /dev/tun0 and tun1 are opend for reading and writing?

----------------------[=========]------------------------
David T. McWherter                udmcwher@mcs.drexel.edu

My religion consists of a humble admiration of the illimitable superior
spirit who reveals himself in the slight details we are able to perceive
with our frail and feeble mind.
		-- Albert Einstein
