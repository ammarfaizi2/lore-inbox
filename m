Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCHRbP>; Thu, 8 Mar 2001 12:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRCHRbF>; Thu, 8 Mar 2001 12:31:05 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:33544 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129283AbRCHRay>;
	Thu, 8 Mar 2001 12:30:54 -0500
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: "Mark Hemment" <markhe@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <Pine.LNX.4.21.0103011800460.11260-100000@alloc> <3A9EA940.CB82665C@colorfullife.com> <d3lmqhny9w.fsf@lxplus015.cern.ch> <003601c0a746$57ab5750$5517fea9@local>
From: Jes Sorensen <jes@linuxcare.com>
Date: 08 Mar 2001 18:30:12 +0100
In-Reply-To: "Manfred Spraul"'s message of "Wed, 7 Mar 2001 21:32:45 +0100"
Message-ID: <d3snkoyxqz.fsf@lxplus012.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Manfred" == Manfred Spraul <manfred@colorfullife.com> writes:

Manfred> First of all HW_CACHEALIGN aligns to the L1 cache, not
Manfred> SMP_CACHE_BYTES.  Additionally you sometimes need a
Manfred> guaranteed alignment for other problems, afaik ARM needs 1024
Manfred> bytes for some structures due to cpu restrictions, and
Manfred> several usb controllers need 16 byte alignment.

My question is whats the point in asking for L1_CACHE_BYTES alignment
for hardware reasons when you can't see it beyond the cache controller
anyway? Sure it makes sense for data structures only used by the CPU,
but for structures that are shared between CPUs or goes to DMA
controllers it seems to make little sense.

Jes
