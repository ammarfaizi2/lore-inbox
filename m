Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVABPp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVABPp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVABPnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:43:19 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:7639 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261262AbVABPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:42:32 -0500
Date: Sun, 2 Jan 2005 16:41:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [->used_math to PF_USED_MATH] [6/4]
Message-ID: <20050102154148.GA5164@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org> <20041225022721.GR13747@dualathlon.random> <20041225032430.GT13747@dualathlon.random> <20041225145321.GU13747@dualathlon.random> <20041227070309.GA28907@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227070309.GA28907@hexapodia.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 11:03:09PM -0800, Andy Isaacson wrote:
> I can't find any authoritative source for that assertion, but google
> supports it:
> http://sources.redhat.com/ml/libc-alpha/2002-09/msg00328.html

This is a nice reference, thanks for the info (I personally only worked
with ev6 so I probably never run in the exact features and history of
the older chips).

All issues with ev4+smp/preempt and ev5+smp/preempt should be fixed with
the two incremental patches I posted last week that make PF_MEMDIE a
TIF_MEMDIE and used_math a PF_USED_MATH and that fixes the PF_MEMDIE
race that existed on all archs in mainline 2.6 and that AFIK Wli even
managed to reproduce once.
