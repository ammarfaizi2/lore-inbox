Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129946AbRBUEUP>; Tue, 20 Feb 2001 23:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130923AbRBUEUF>; Tue, 20 Feb 2001 23:20:05 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:64518 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129946AbRBUETu>; Tue, 20 Feb 2001 23:19:50 -0500
Date: Tue, 20 Feb 2001 22:19:43 -0600
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
Message-ID: <20010220221943.A28652@cadcamlab.org>
In-Reply-To: <E14VDD2-0006ha-00@the-village.bc.nu> <Pine.A41.4.31.0102201759300.50000-100000@pandora.inf.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.A41.4.31.0102201759300.50000-100000@pandora.inf.elte.hu>; from szabi@inf.elte.hu on Tue, Feb 20, 2001 at 06:04:09PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[BERECZ Szabolcs]
> The conclusion: it's cannot be implemented without slowdown.

Or: it cannot be implemented 100% safely and correctly without slowdown.

If you know the use you wish to put this to, and are willing to risk a
permission check somewhere being confused momentarily by a non-atomic
update of a 32-bit number (or the non-atomic update between several
32-bit numbers, which I think is less serious because then you are not
granting more than the union of the two UIDs) go ahead and patch your
kernel.

> So ignore my patch.

For official kernels, I agree.  They need to be as safe and
deterministic as possible, especially security-wise, and a semaphore on
every permission check would be ridiculous.

Peter
