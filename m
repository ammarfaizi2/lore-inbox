Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTGBMMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTGBMMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:12:40 -0400
Received: from indyio.rz.uni-saarland.de ([134.96.7.3]:2314 "EHLO
	indyio.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S264956AbTGBMMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:12:39 -0400
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
Reply-To: nf@hipac.org
To: Pekka Savola <pekkas@netcore.fi>
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
Date: Wed, 2 Jul 2003 14:26:56 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0307020826530.23232-100000@netcore.fi>
In-Reply-To: <Pine.LNX.4.44.0307020826530.23232-100000@netcore.fi>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307021426.56138.nf@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka

> Thanks for your clarification.  We've also conducted some tests with
> bridging firewall functionality, and we're very pleased with nf-hipac's
> performance!  Results below.

Great, thanks a lot. Your tests are very interesting for us as we haven't done 
any gigabit or SMP tests yet. 

> In the measurements, tests were run through a bridging Linux firewall,
> with a netperf UDP stream of 1450 byte packets (launched from a different
> computer connected with gigabit ethernet), with a varying amount of
> filtering rules checks for each packet.
> I don't have the specs of the Linux PC hardware handy, but I recall
> they're *very* highend dual-P4's, like 2.4Ghz, very fast PCI bus, etc.

Since real world network traffic always consists of a lot of different sized 
packets taking maximum sized packets is very euphemistic. 1450 byte packets 
at 950 Mbit/s correspond to approx. 80,000 packets/sec.
We are really interested in how our algorithm performs at higher packet rates. 
Our performance tests are based on 100 Mbit hardware so we coudn't test with 
more than approx. 80,000 packets/sec even with minimum sized packets. At this 
packet rate we were hardly able to drive the algorithm to its limit, even 
with more than 25000 rules involved (and our test system was 1.3 GHz 
uniprocessor).

We'd appreciate it very much if you could run additional tests with smaller 
packet sizes (including minimum packet size). This way we can get an idea of 
whether our SMP optimizations work and whether our algorithm in general would 
benefit from further fine tuning.


Regards

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+

