Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAWVJy>; Tue, 23 Jan 2001 16:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAWVJp>; Tue, 23 Jan 2001 16:09:45 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:15610 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129669AbRAWVJf>;
	Tue, 23 Jan 2001 16:09:35 -0500
Date: Tue, 23 Jan 2001 22:09:32 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101232109.WAA14386@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [Announce] Version 1.8 of x86 performance counters driver
Cc: ptools-perfapi@nacse.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 1.8 of my x86 performance-monitoring counters driver is
now available at http://www.csd.uu.se/~mikpe/linux/perfctr/.

Summary:
Version 1.8, 2001-01-23
- Added preliminary interrupt-mode support to virtual perfctrs.
  Currently for P6 only, and the local APIC must have been enabled.
  Tested on 2.4.0-ac10 with CONFIG_X86_UP_APIC=y.
  When an i-mode vperfctr interrupts on overflow, the counters are
  suspended and a user-specified signal is sent to the process. The
  user's signal handler can read the trap pc from the mmap:ed vperfctr,
  and should then issue an IRESUME ioctl to restart the counters.
  The next version will support buffering and automatic restart.


/ Mikael Pettersson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
