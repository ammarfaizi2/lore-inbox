Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVAHRSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVAHRSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVAHRSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:18:16 -0500
Received: from holomorphy.com ([207.189.100.168]:47592 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261230AbVAHRRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:17:49 -0500
Date: Sat, 8 Jan 2005 09:17:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andy Isaacson <adi@hexapodia.org>, Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [->used_math to PF_USED_MATH] [6/4]
Message-ID: <20050108171711.GW9636@holomorphy.com>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org> <20041225022721.GR13747@dualathlon.random> <20041225032430.GT13747@dualathlon.random> <20041225145321.GU13747@dualathlon.random> <20041227070309.GA28907@hexapodia.org> <20050102154148.GA5164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102154148.GA5164@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 11:03:09PM -0800, Andy Isaacson wrote:
>> I can't find any authoritative source for that assertion, but google
>> supports it:
>> http://sources.redhat.com/ml/libc-alpha/2002-09/msg00328.html

On Sun, Jan 02, 2005 at 04:41:48PM +0100, Andrea Arcangeli wrote:
> This is a nice reference, thanks for the info (I personally only worked
> with ev6 so I probably never run in the exact features and history of
> the older chips).
> All issues with ev4+smp/preempt and ev5+smp/preempt should be fixed with
> the two incremental patches I posted last week that make PF_MEMDIE a
> TIF_MEMDIE and used_math a PF_USED_MATH and that fixes the PF_MEMDIE
> race that existed on all archs in mainline 2.6 and that AFIK Wli even
> managed to reproduce once.

Reproduced only once ever on x86-64, but reliably reproducible on all
other 64-bit architectures. 32-bit architectures have resource
scalability issues that make the particular exploit I wrote ineffective.


-- wli
