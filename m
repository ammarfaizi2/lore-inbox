Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSHNOnu>; Wed, 14 Aug 2002 10:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHNOnu>; Wed, 14 Aug 2002 10:43:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312590AbSHNOnt>; Wed, 14 Aug 2002 10:43:49 -0400
Date: Wed, 14 Aug 2002 07:49:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <Pine.LNX.4.44L.0208131913400.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208140746070.1809-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Rik van Riel wrote:
> 
> As a clarification to this, I'm not suggesting that interactive
> performance doesn't exist, I'm suggesting that we should measure
> it.

I think the only way to measure it is with a latency measurement thing - 
like the one used for some of the RT tuning.

However, the latency measurement should not care too much about individual
millisecond latencies, but only holler when it finds _combined_ bad
latencies in the 1/10+ second range (which is human-perceptible).

One problem is trying to find a good load for the tester program itself
(it should not just sit in a tight loop, it should have a memory footprint
and some delays of its own).

		Linus

