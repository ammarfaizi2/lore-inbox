Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272340AbTHEBsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272341AbTHEBsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:48:19 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:57028 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S272340AbTHEBsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:48:17 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Werner Almesberger <werner@almesberger.net>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 4 Aug 2003 18:46:36 -0700 (PDT)
Subject: Re: TOE brain dump
In-Reply-To: <20030804223800.P5798@almesberger.net>
Message-ID: <Pine.LNX.4.44.0308041841190.7534-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Werner Almesberger wrote:

> David Lang wrote:
> > you missed Alan's point, he was saying you don't do TOE on the NIC,
>
> Only as far as "traditional TOE" is concerned. My idea is
> precisely to avoid treating TOE as a special case.
>
> > just add another CPU to your main system and use non-TOE NIC's the way you
> > do today.
>
> For a start, that may be good enough, even though you miss
> a lot of nice hardware optimizations.

exactly, Alan is saying that the hardware optimizations aren't nessasary.
putting an Opteron on a NIC card just to match the other processors in
your system seems like a huge amount of overkill. you aren't going to have
nearly the same access to memory so that processor will be crippled, but
stil cost full price (and then some, remember you have to supply the thing
with power and cool it)

> > Any time you create a cluster of machines you want to create som nice
> > administrative interfaces for them to maintain your own sanity
>
> You've got a point there. The question is whether these
> interface really cover everything we need, and - more
> importantly - whether they still have the same semantics.

as long as tools are written that have the same command line semantics the
rest of the complexity can be hidden. and even this isn't strictly
nessasary, these are special purpose cards and a special procedure for
configuring them isn't unreasonable.

> > Larry McVoy has the right general idea when he says buy another box to do
> > the job, he is just missing the idea that there are some advantages of
> > coupling the cluster more tightly then you can do with a seperate box.
>
> Clusters are nice, but they don't help if your bottleneck
> is per-packet processing overhead with a single NIC, or if
> you can't properly distribute the applications.
>
> I'm not saying that TOE, even if done in a maintainable way,
> is always the right approach. E.g. if all you need is a fast
> path to main memory, Dave's flow cache would be a much
> cheaper solution. If you can distribute the workload, and
> the extra hardware doesn't bother you, your clusters become
> attractive.

I'm saying treat the one machine with 10 of these specialty NIC's in it as
a 11 machine cluster, one machne running your server software and 10
others running your networking.

David Lang
