Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbTFATPB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTFATPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:15:01 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:37796 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264706AbTFATPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:15:00 -0400
Date: Sun, 1 Jun 2003 21:28:05 +0200 (MEST)
Message-Id: <200306011928.h51JS5k2026999@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.4 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.4 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.5.4, 2003-06-01
- Corrected the driver's handling of OVF_PMI+FORCE_OVF counters
  on Pentium 4. This configuration didn't work at all, and
  lead to various BUG messages from the driver.
  These restrictions apply to OVF_PMI+FORCE_OVF counters:
  * The ireset value must be -1.
  * Once the counter has interrupted once, it will continue
    to interrupt when the faulting instruction is restarted,
    causing it to never complete. This problem also occurs
    for non-FORCE_OVF interrupt-mode counters if the ireset
    value is of too small magnitude, like -1.
    This appears to be a P4 hardware quirk. Don't restart
    FORCE_OVF interrupt-mode counters, and don't use ireset
    values too small to allow instructions to complete.
- Updated library's K8 event descriptions to match current
  documentation. Corrected several omissions and errors.
- Patch kit updated for kernels 2.5.70 and 2.4.21-rc6.

/ Mikael Pettersson
