Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUDFR51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUDFR51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:57:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11147
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263932AbUDFR5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:57:24 -0400
Date: Tue, 6 Apr 2004 19:57:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406175722.GE2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406172431.GA9185@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406172431.GA9185@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 07:24:31PM +0200, Ingo Molnar wrote:
> (anyway, feel free to reproduce and post contrary results here. The onus

I will run benchmarks as soon as I'm back from vacations. You didn't
post the modified benchmarks to produce any realistic load.

I will use the HINT to measure the slowdown on HZ=1000. It's an optimal
benchmark simulating userspace load at various cache sizes and it's
somewhat realistic.

Note also that the slowdown I expect wasn't of the order 10%, obviously,
I was expecting something between 1 and 2% which would be an *huge*
slowdown for any cpu bound app just for the timer irq, and I will try to
reproduce it on my 4-way xeon.

Regardless, even if HZ=1000 would run 1% faster (not 0.02% slower as you
measured) that changes nothing in terms of the 4:4 badness, the real
badness is for apps doing more than userspace pure calculations.

> is on you. And if you think i'm upset about your approach to this whole
> issue then you are damn right.)

the one upset should be the users running 30% slower with stuff like
mysql just because they own a 4/8G box. There's little interest from my
part to spend time on 4:4 stuff when things are so obvious (I want
however to try to benchmark the HZ=1000 with the hint).
