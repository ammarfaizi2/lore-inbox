Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSLUEgG>; Fri, 20 Dec 2002 23:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLUEgG>; Fri, 20 Dec 2002 23:36:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38286 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261418AbSLUEgF>; Fri, 20 Dec 2002 23:36:05 -0500
Date: Fri, 20 Dec 2002 20:43:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with
 more than 8 CPUs
Message-ID: <323450000.1040445820@titus>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB564419EF9@fmsmsx407.fm.intel.com>
References: <3014AAAC8E0930438FD38EBF6DCEB564419EF9@fmsmsx407.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I share the same concerns and comments with Martin.
>
> As far as xAPIC mode is concerned, the changes for ES7000 in SuSe/United
> Linux are simply activating physical mode. And we are confident the patch
> we provided should work for the machine as well. Looks like ES7000
> requires changes in other areas as well, though.
>
> Since Martin already has code in place in 2.5, we should reuse his code
> as much as possible. And our current plan is:

I should point out that James wrote most of the Summit code, not me (I did
the original NUMA-Q code) - I'm splitting it out into manageable chunks
and debugging it (it breaks NUMA-Q at the moment, but I think that's fixed
now it's in nice bite-sized pieces).

> For 2.5:
>
> - Martin posts a new patch (that moves IBM-specifc stuff to subarch, for
> example) next week. - Venkatesh merges the generic cluster APIC support
> for systems (with more than 8 CPUs) to it, testing it on some OEM
> machines (I cannot tell which)

Excellent - thankyou for this. When it's abstracted out (as the patches
I'll send out as soon as I've got them tested do), it should be much
easier to merge things together.

> For 2.4:
> - Venkatesh will post a confined patch to support APIC physical mode.

That should be what the current 2.4 summit code uses ... oddly it's
physical in 2.4, and logical in 2.5 ... don't ask why ;-) If you meant
logical, that sounds like a good plan.

M.
