Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbTCLKco>; Wed, 12 Mar 2003 05:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263140AbTCLKco>; Wed, 12 Mar 2003 05:32:44 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:26090 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S263139AbTCLKcn>;
	Wed, 12 Mar 2003 05:32:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15983.3857.705211.851663@gargle.gargle.HOWL>
Date: Wed, 12 Mar 2003 11:42:25 +0100
From: mikpe@csd.uu.se
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: mikpe@csd.uu.se, Andrew Fleming <afleming@motorola.com>,
       Segher Boessenkool <segher@koffie.nl>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] oprofile for ppc
In-Reply-To: <1047427855.5973.80.camel@cube>
References: <3E6D469C.8060209@koffie.nl>
	<FEB94991-540B-11D7-BAD1-000393C30512@motorola.com>
	<15982.29106.674299.704117@gargle.gargle.HOWL>
	<1047427855.5973.80.camel@cube>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan writes:
 > > Is this bug restricted to 7400/7410 only, or does it
 > > affect the 750 (and relatives) and 604/604e too?
 > >
 > > I'm thinking about ppc support for my perfctr driver,
 > > and whether overflow interrupts are worth supporting
 > > or not given the errata.
 > 
 > 604/604e doesn't even have performance monitoring AFAIK.

Yes they do. 604 has two counters, 604e has four.

 > I've heard nothing to suggest that the 750 is affected.

I seem to recall hearing something about some temperature
monitoring interrupt interacting badly with the performance
monitor interupt due to an errata, but that may not have been
the 750.

 > I'll give you a hand; point me to the latest perfctr code
 > and explain how it is supposed to interact with oprofile.

They're not supposed to interact, but there is currently no
mechanism in place for preventing both from being activated
at the same time. What's needed is some form of kernel API
for reserving and releasing the performance counter hardware,
and updating oprofile to use that API.
