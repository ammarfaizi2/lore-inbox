Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSAUKm0>; Mon, 21 Jan 2002 05:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbSAUKmR>; Mon, 21 Jan 2002 05:42:17 -0500
Received: from adsl-63-197-0-76.dsl.snfc21.pacbell.net ([63.197.0.76]:4879
	"HELO www.pmonta.com") by vger.kernel.org with SMTP
	id <S282511AbSAUKmF>; Mon, 21 Jan 2002 05:42:05 -0500
From: Peter Monta <pmonta@pmonta.com>
To: linux-kernel@vger.kernel.org
Subject: APIC errors, Asus A7M266-D (760MPX chipset)
Message-Id: <20020121104204.971231C5@www.pmonta.com>
Date: Mon, 21 Jan 2002 02:42:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a storm of APIC errors with an Asus A7M266-D motherboard
at the beginning of boot (and no further boot progress is made).
The console message is "APIC error on CPU0: 04(04)".  A single
Athlon MP 1200 is installed; the kernel is compiled with SMP=n
but both "local APIC" and "use IO-APIC" are enabled.  I'm using
2.5.2pre10.

Oddly, booting this same kernel with the "noapic" option results in
the same problem, but recompiling with all APIC options disabled
gives a successful boot.

While running in this legacy interrupt mode there seem to be a lot
of ERR: interrupts in /proc/interrupts, in fact about five times as
many as "real" ones listed above.  Does this affect performance?  How
much is interrupt latency increased when the APIC bus must reissue
commands like this (if I understand the documentation correctly)?

Cheers,
Peter Monta
