Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264204AbUD0RDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbUD0RDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbUD0RDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:03:14 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:62445 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S264198AbUD0RDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:03:08 -0400
Date: Tue, 27 Apr 2004 19:02:46 +0200 (METDST)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: Ross Dickson <ross@datscreative.com.au>
cc: Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, <christian.kroener@tu-harburg.de>,
       <linux-kernel@vger.kernel.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <200404262141.24616.ross@datscreative.com.au>
Message-ID: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm sorry for the small interlude in this thread, but I just want to get
something clear.

Basically we have a problem that is all around, except for (some) Shuttle
boards. Noone really knows what's going on, or at least if they know they
are not vocal about it.

In comes Ross Dickson. He starts poking at the problem until he comes up
with two patches. Near the end of 2003, an NVIDIA engineer (Allen Martin)
states that he (or maybe NVIDIA as a whole?) has been unable to reproduce
this weird problem with hard locks, seemingly related to APIC and IO.

He can tell us there was a bug in a reference BIOS that NVIDIA sent out
into the world, but that it has been fixed in a follow-up. Somewhere at
the start of December, Shuttle updates its BIOS for the AN35. Jesse Allen
flashes the new BIOS into his board and for reasons unknown his hard lock
problem has vanished. The importance of the update of NVIDIA's reference
BIOS in relation to the Shuttle update of the BIOS for their product(s) is
unknown as well.

Meanwhile, Ross Dickson drops requests for support tickets at AMD and
NVIDIA. Until this day, no reply yet. Unaffected by the deafening silence
he keeps improving his patches which seem to work(tm).

Without Ross' hard labor one can avoid the hard locks by banning APIC
support from the kernel, or turn off the C1 disconnect feature in the
BIOS, which is misinterpreted by one ACPI developer as running the CPU
"out of spec."

Recently Len Brown, the ACPI Linux kernel maintainer and Intel employee -
can you spot the irony? - agrees to attempt to reproduce the problem.
After having his box run with cat /dev/hda > /dev/null for a night
straight no lockup has occured. The brand of his motherboard is Shuttle.
Did I mention irony...?

Although this topic is primarily about nforce2 chipsets, similar problems
have been reported with SiS chipsets for AMD cpus. Other chipsets capable
of having the CPU disconnect include VIA KT266(A), KT333 and KT400. For
linux a tool like athcool can set the bits for the disconnect and the HLT
instruction. It is unconfirmed that these chipsets suffer from the same
symptoms as nforce2 chipsets.

Does anyone have some input on how to tackle this problem? The only things
I can come up with is mailing all the motherboard manufacturers I can
think of, harass NVIDIA and/or AMD some more through proper channels (i.e.
file a "bug report", but I don't expect much from this, sorry Allen) or
buy Len the cheapest broken nforce2 board I can find at pricewatch.com and
have it shipped to his house :)

Best regards,

Arjen

