Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272330AbTHEBiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272332AbTHEBiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:38:14 -0400
Received: from almesberger.net ([63.105.73.239]:33798 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272330AbTHEBiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:38:12 -0400
Date: Mon, 4 Aug 2003 22:38:01 -0300
From: Werner Almesberger <werner@almesberger.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030804223800.P5798@almesberger.net>
References: <20030804170921.O5798@almesberger.net> <Pine.LNX.4.44.0308041316170.7534-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041316170.7534-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Mon, Aug 04, 2003 at 01:24:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> you missed Alan's point, he was saying you don't do TOE on the NIC,

Only as far as "traditional TOE" is concerned. My idea is
precisely to avoid treating TOE as a special case.

> just add another CPU to your main system and use non-TOE NIC's the way you
> do today.

For a start, that may be good enough, even though you miss
a lot of nice hardware optimizations.

> Any time you create a cluster of machines you want to create som nice
> administrative interfaces for them to maintain your own sanity

You've got a point there. The question is whether these
interface really cover everything we need, and - more
importantly - whether they still have the same semantics.

> Larry McVoy has the right general idea when he says buy another box to do
> the job, he is just missing the idea that there are some advantages of
> coupling the cluster more tightly then you can do with a seperate box.

Clusters are nice, but they don't help if your bottleneck
is per-packet processing overhead with a single NIC, or if
you can't properly distribute the applications.

I'm not saying that TOE, even if done in a maintainable way,
is always the right approach. E.g. if all you need is a fast
path to main memory, Dave's flow cache would be a much
cheaper solution. If you can distribute the workload, and
the extra hardware doesn't bother you, your clusters become
attractive.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
