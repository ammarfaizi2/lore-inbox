Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318936AbSH1UEj>; Wed, 28 Aug 2002 16:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSH1UEj>; Wed, 28 Aug 2002 16:04:39 -0400
Received: from holomorphy.com ([66.224.33.161]:9088 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318936AbSH1UEi>;
	Wed, 28 Aug 2002 16:04:38 -0400
Date: Wed, 28 Aug 2002 13:08:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
Message-ID: <20020828200857.GB888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D6C53ED.32044CAD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6C53ED.32044CAD@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:39:09PM -0700, Andrew Morton wrote:
> These ratios are scaled so that as the highmem:lowmem ratio goes
> beyond 4:1, the maximum amount of allowed dirty memory ceases to
> increase.  It is clamped at the amount of memory which a 4:1 machine
> is allowed to use.

This is disturbing. I suspect this is only going to raise poor memory
utilization issues on highmem boxen. Of course, "f**k highmem" is such
a common refrain these days so that's probably falling on deaf ears.
AFAICT the OOM issues are largely a by-product of mempool allocations
entering out_of_memory() when they have the perfectly reasonable
alternative strategy of simply waiting for the mempool to refill.


Cheers,
Bill
