Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbTDRRkH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDRRkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:40:07 -0400
Received: from holomorphy.com ([66.224.33.161]:40074 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263177AbTDRRkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:40:06 -0400
Date: Fri, 18 Apr 2003 10:51:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [cpumask_t 1/3] core changes for 2.5.67-bk6
Message-ID: <20030418175138.GA12469@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030415225036.GE12487@holomorphy.com> <20030418102015.2527ff40.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418102015.2527ff40.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 15:50:36 -0700 William Lee Irwin III wrote:
> | Core changes for extended cpu masks. Basically use a machine word
> | #if NR_CPUS < BITS_PER_LONG, otherwise, use a structure with an array
> | of unsigned longs for it. Sprinkle it around the scheduler and a few
> | other odd places that play with the cpu bitmasks. Back-ended by a
> | bitmap ADT capable of dealing with arbitrary-width bitmaps, with the
> | obvious micro-optimizations for NR_CPUS < BITS_PER_LONG and UP.
> | NR_CPUS % BITS_PER_LONG != 0 is invalid while NR_CPUS > BITS_PER_LONG.

On Fri, Apr 18, 2003 at 10:20:15AM -0700, Randy.Dunlap wrote:
> Where/why this restriction (above)?
> I don't see the need for it or implementation of it.
> I'm only looking at the core patch.

I leave bits dangling otherwise.


On Tue, 15 Apr 2003 15:50:36 -0700 William Lee Irwin III wrote:
> | +static inline void bitmap_shift_left(volatile unsigned long *,volatile unsigned long *,int,int);

On Fri, Apr 18, 2003 at 10:20:15AM -0700, Randy.Dunlap wrote:
> Do you need this prototype?  I don't see why.
> Rest of core looks good to me.

Probably not. I'll nuke it.


-- wli
