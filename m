Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279852AbRJ3EZU>; Mon, 29 Oct 2001 23:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279856AbRJ3EZH>; Mon, 29 Oct 2001 23:25:07 -0500
Received: from c255489-c.belvil1.il.home.com ([24.22.144.146]:55449 "EHLO
	dink.joshisanerd.com") by vger.kernel.org with ESMTP
	id <S279852AbRJ3EYi>; Mon, 29 Oct 2001 23:24:38 -0500
Date: Mon, 29 Oct 2001 23:25:10 -0500 (EST)
From: Josh Myer <jbm@joshisanerd.com>
To: linux-kernel@vger.kernel.org
Subject: Asymmetrically bonding PPP and ethernet?
Message-ID: <Pine.LNX.4.21.0110292315410.894-100000@dignity.joshisanerd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Has anyone managed to bond a PPP connection as an upstream with an
Ethernet connection as a downstream? My ISP requires this (one-way cable),
and i haven't found anything about it, anywhere. Googling for lots of
different possible keywords turns up nothing of pertinence.

I tried iptables, and then tweaking bonding.c, but it's not working very
well. I think it could be made to work, but i'm running into nuances
between ppp and eth at the kernel level.

The problem is thus: A machine connected to a local network via eth0, and
to the cable modem via eth1, and to a ppp provider on ppp0. ppp0 is the
upstream address at 24.216.n.n/32; eth1 is the downstream at
10.0.0.1/24. eth0 is 10.1.0.20/16. If i connect the ppp up and run
ethereal/tcpdump on eth1, then ping a host, i can see the ICMP replies on
eth1. 

I'm currently using 2.4.4, but i don't think anything related to this has
changed much since then.

Thanks in advance for any advice,
--
/jbm, but you can call me Josh. Really, you can.
 "Design may be clever in spurts,
  but evolution never sleeps"
  -- Rob Landley

