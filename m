Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318813AbSHNPQX>; Wed, 14 Aug 2002 11:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSHNPQX>; Wed, 14 Aug 2002 11:16:23 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:36365 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318813AbSHNPQW>; Wed, 14 Aug 2002 11:16:22 -0400
Date: Wed, 14 Aug 2002 12:19:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <Pine.LNX.4.44.0208140746070.1809-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208141208560.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Linus Torvalds wrote:
> On Tue, 13 Aug 2002, Rik van Riel wrote:
> >
> > As a clarification to this, I'm not suggesting that interactive
> > performance doesn't exist, I'm suggesting that we should measure
> > it.
>
> I think the only way to measure it is with a latency measurement thing -
> like the one used for some of the RT tuning.
>
> However, the latency measurement should not care too much about individual
> millisecond latencies, but only holler when it finds _combined_ bad
> latencies in the 1/10+ second range (which is human-perceptible).
>
> One problem is trying to find a good load for the tester program itself
> (it should not just sit in a tight loop, it should have a memory footprint
> and some delays of its own).

A start would be Bob Matthews's IRMAN program:

	http://people.redhat.com/bmatthews/irman/


I've also been talking with Randy Hwron(sp?) about doing
latency tests with all his benchmarks.

If I wasn't so distracted by various other TODO items I'd
already have a dbench with latency histograms in it ;)

(yes, I know dbench is a bad benchmark, but it also seems
to be the most abused one.  Making the thing show exactly
how much unfairness and bad latency there is will probably
make some people look at dbench results with very different
eyes)

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

