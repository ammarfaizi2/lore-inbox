Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTH3W6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTH3W6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 18:58:37 -0400
Received: from mail2-216.ewetel.de ([212.6.122.116]:25573 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S262226AbTH3W6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 18:58:35 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <qgCn.2y4.11@gated-at.bofh.it>
References: <q2SH.AA.3@gated-at.bofh.it> <qfwI.15D.27@gated-at.bofh.it> <qgCn.2y4.11@gated-at.bofh.it>
Date: Sun, 31 Aug 2003 00:58:33 +0200
Message-Id: <E19tEfx-0002vL-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003 18:20:11 +0200, you wrote in linux.kernel:

> In order to control incoming traffic, it is easiest to look at tcp.
> udp can work similarly, but it doesn't have to.  To throttle the
> stream of tcp packets, you could simply throw away the acks and the
> sending side will reduce it's speed.  So you have to measure one
> stream and control a related but different one.  Maybe this is
> possible, not sure.

All you have to do is drop the incoming packets if they exceed
a certain bandwidth. That will stop the corresponding ack automatically
since your TCP stack won't even see the packet.

I'm doing this on my ISDN line to limit the rest of the house to one
third of the bandwidth even if they're all busy downloading tons of
warez. I'm paying, I want the bandwidth when I need it. They can get
it all when there's no traffic for my machine.

No problem with the HTB queueing discipline.

[...]
> Third, there is the problem transition from continuous streams to
> discrete packets, when bandwidth is low.  It doesn't take a huge
> amount of large packets to create enough latency for your sad VOIP.

Yes, latency is a problem if you want to saturate your bandwidth. It is
easy to guarantee some bandwith for latency critical stuff - just
don't give out that piece of bandwith to something else. Of course,
then most of the time that piece is wasted... and it doesn't help with
problems somewhere along the net.

> And fourth, the possibility of resonance frequency.  If measurement
> and/or shaping intervals are too long and match nicely to the travel
> time to one of your peers, you are back at point three.

Dunno about that one.

-- 
Ciao,
Pascal
