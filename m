Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290081AbSAQRli>; Thu, 17 Jan 2002 12:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290082AbSAQRl1>; Thu, 17 Jan 2002 12:41:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60172 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290081AbSAQRlU>; Thu, 17 Jan 2002 12:41:20 -0500
Date: Thu, 17 Jan 2002 12:40:33 -0500
Message-Id: <200201171740.MAA02308@gatekeeper.tmr.com>
To: J.A.K.Mouw@its.tudelft.nl
Subject: Re: Rik spreading bullshit about VM
In-Reply-To: <20020117011520.GM10175@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020116200459.E835@athlon.random> <20020117000758.GL10175@arthur.ubicom.tudelft.nl> <3C461A09.8060900@lexus.com>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020117011520.GM10175@arthur.ubicom.tudelft.nl> you write:

| It's not that I think Andrea's VM is bad, it's just that a VM should be
| tuned for the common cases, not for the power users that want to
| squeeze every last drop out of it. It's fine with me if somebody wants
| to design a VM for the niche XYZ, but do that as a separate patch and
| don't clutter up the mainline kernel with it.

  I have a few points of disagreement with that. I have no idea what
prices are doing elsewhere, but in the USA memory prices are around
$250-400/GB for memory (from crap to decent ECC) and there are a lot
more machines which live in the "power user" range then there used to
be. And when memory was really cheap, ~$150/GB, many people built big
Athlon systems for small $$. I totally agree that Linux should run in
4MB, but that's not typical anymore.

  My real disagreement is that we should be doing worst case analysis on
the VM and scheduler rather than trying to go for best at one thing,
calling that typical, and then letting all other loads take the
leavings. I like to be able to tune, the the kernel should do a decent
job with systems having any reasonable mix of large and small, i/o and
CPU bound jobs. I don't like even the implication that it's okay for
performance to suck, or for new kernels to be worse than 2.4.14 or so.
Alan Cox had some somments on this, and has started the -ac series again
because of it.

  So far I find 18pre2aa2 with some setting for bdflush to work
acceptably on several largish machines and one small system with many
processes and working set 3-4x physical memory. More later.

  Let's aim for "doesn't suck" instead of "perfect for XXX" and more
people will be satisfied if not delighted.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
