Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276301AbRJCOHn>; Wed, 3 Oct 2001 10:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276302AbRJCOHd>; Wed, 3 Oct 2001 10:07:33 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:62933 "EHLO pltn13.pbi.net")
	by vger.kernel.org with ESMTP id <S276301AbRJCOHM>;
	Wed, 3 Oct 2001 10:07:12 -0400
Date: Wed, 03 Oct 2001 07:06:26 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: mingo@elte.hu
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <0e9201c14c14$97fa3a60$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0110031115110.2796-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB 2.0 host controllers (EHCI) support a kind of hardware
level interrupt mitigation, whereby a register controls interrupt
latency.  The controller can delay interrupts from 1-64 microframes, 
where microframe = 125usec, and the current driver defaults that
latency to 1 microframe (best overall performance) but sets that
from a module parameter.

I've only read the discussion via archive, so I might have missed
something, but I didn't see what I had hoped to see:  a feedback
mechanism so drivers (PCI in the case of EHCI) can learn that
decreasing the IRQ rate would be good, or later that it's OK to
increase it again.  (Seems like Alan Cox suggested as much too ...)

I saw several suggestions specific to the networking layer,
but I'd sure hope to see mechanisms in place that work for
non-network drivers.  Someday; right now highspeed USB
devices (480 MBit/sec) aren't common yet, mostly disks, and
motherboard chipsets don't yet support it.

- Dave



