Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbSLMDAs>; Thu, 12 Dec 2002 22:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbSLMDAs>; Thu, 12 Dec 2002 22:00:48 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:39124
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267436AbSLMDAq>; Thu, 12 Dec 2002 22:00:46 -0500
Date: Thu, 12 Dec 2002 22:11:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
In-Reply-To: <200212121841.32381.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0212122153310.6931-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0212112105490.14901-100000@montezuma.mastecende.com>
 <200212121809.43698.jamesclv@us.ibm.com> <Pine.LNX.4.50.0212122116260.6931-100000@montezuma.mastecende.com>
 <200212121841.32381.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, James Cleverdon wrote:

> Sure you can physically address them, if you assign IDs using Intel's official
> xAPIC numbering scheme (which must be clustered for more than 7 CPUs).  But,
> you still don't have enough destination address bits to go around.  In flat
> mode, the kernel assumes you have one bit per CPU and phys IDs will be < 0xF.
>
> Bill tells me that you may be doing this for an emulator.  Why not emulate
> clusered APIC mode, like the real hardware uses?
>
> I know the name x86_summit doesn't really fit.  The summit patch should work
> for any xAPIC box that uses the system bus for interrupt delivery and has
> multiple APIC clusters.  Is that what you're working towards?

Hmm although i could then skip the logical destination mode and stick to
physical destination mode. This would greatly simplify my code paths since
i could almost use the same code for both normal SMP and this larger sim.
Debugging would then be somewhat simpler. My target doesn't have multiple
APIC clusters and all are addressable via a 0xff broadcast.

Thanks,
	Zwane
-- 
function.linuxpower.ca
