Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTEHQFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTEHQFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:05:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:43411 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261562AbTEHQFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:05:02 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16058.33567.241210.235419@gargle.gargle.HOWL>
Date: Thu, 8 May 2003 18:17:35 +0200
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr progress on x86_64 / Opteron
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a status update...

The perfctr x86 performance monitoring counters driver now
runs on an actual AMD Opteron CPU in 64-bit mode. The kernel
is Rawhide's 2.4.20-9.2 in SMP mode.

The driver appears to be fully functional. Test cases
where processes set up their own perfctrs, including
interrupt-on-overflow-turned-into-signal counters, work
as expected. (examples/self/ and examples/signal/.)

The perfex user-space program doesn't work yet. It uses file
descriptor passing in a control message over a unix datagram
socket, but I get unexpected 'Bad file descriptor' errors
from sendmsg(). I'm currently investigating this problem.

/Mikael

PERFCTR INIT: vendor 2, family 15, model 5, stepping 0, clock 1381091 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 80 cycles
PERFCTR INIT: rdtsc cost is 6.1 cycles (474 total)
PERFCTR INIT: rdpmc cost is 14.1 cycles (983 total)
PERFCTR INIT: rdmsr (counter) cost is 50.9 cycles (3343 total)
PERFCTR INIT: rdmsr (evntsel) cost is 57.6 cycles (3769 total)
PERFCTR INIT: wrmsr (counter) cost is 68.9 cycles (4495 total)
PERFCTR INIT: wrmsr (evntsel) cost is 320.6 cycles (20602 total)
PERFCTR INIT: read cr4 cost is 6.9 cycles (526 total)
PERFCTR INIT: write cr4 cost is 66.0 cycles (4307 total)
perfctr: disabled lapic_nmi_watchdog
perfctr: driver 2.5.2 DEBUG, cpu type AMD K8 at 1381091 kHz
