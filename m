Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSFWR3G>; Sun, 23 Jun 2002 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSFWR3F>; Sun, 23 Jun 2002 13:29:05 -0400
Received: from unthought.net ([212.97.129.24]:46212 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S317068AbSFWR3E>;
	Sun, 23 Jun 2002 13:29:04 -0400
Date: Sun, 23 Jun 2002 19:29:05 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Sandy Harris <pashley@storm.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Message-ID: <20020623172905.GA26885@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Sandy Harris <pashley@storm.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E17LUyA-0001wU-00@starship> <200206220107.g5M17AXp028825@sleipnir.valparaiso.cl> <20020621182337.T23670@work.bitmover.com> <3D15E629.1706DE98@storm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D15E629.1706DE98@storm.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 11:15:53AM -0400, Sandy Harris wrote:
> Larry McVoy wrote:
> 
...
> Also, it isn't as clear that clustering experience applies. Are clusters
> that size built hierachically? Is a 1024-CPU Beowulf practical, and if so
> do you build it as a Beowulf of 32 32-CPU Beowulfs? Is something analogous
> required in the OSlet approach? would it work?

Well yes and no.  Often the hierarchy is really shallow. A typical
(larger) Beowulf (if such a thing exists) could be ~50 nodes per 100Mbit
switch, heaps of those switches go into (interconnected) gigabit
switches, and that's it.  There are *many* 'wulfs out there with just
one or a few switches - but they are not 1024 CPUs either.

Much more specialized interconnects are often used. The SP/2 (IBM) used
something resembling "one big switch", which was in reality a number of
cleverly connected smaller switches (sorry, forgot the topology) - so no
real hierarchy, similar bandwidth and latency between any two nodes an a
several-hundred node cluster.

The "Earth Simulator" (the #1 on www.top500.org) is using a one-stage
crossbar for it's 5000+ nodes.

My personal pet theory is, in short, that the hardware stays fairly flat
- not because it is beneficial to (on the contrary!), but because
software assumes that it is flat.  The software paradigms in practical
use today have not changed since the early '80s and as long as the
hardware manages to stay "almost flat" that's not going to change.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
