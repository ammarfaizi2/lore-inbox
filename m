Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSKEJvu>; Tue, 5 Nov 2002 04:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbSKEJvu>; Tue, 5 Nov 2002 04:51:50 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:35746 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S264739AbSKEJvt>;
	Tue, 5 Nov 2002 04:51:49 -0500
Date: Tue, 5 Nov 2002 10:57:46 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [miniPATCH] 2.5.46: fix do_timer.h
Message-ID: <20021105095746.GA22948@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

attached patch fix this compiler warning:

In file included from arch/i386/kernel/timers/timer_pit.c:16:
arch/i386/mach-generic/do_timer.h: In function `do_timer_interrupt_hook':
arch/i386/mach-generic/do_timer.h:26: warning: implicit declaration of
function `smp_local_timer_interrupt'

This problem was in 2.5.4[4-6] kernels...

Please apply...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="do_timer.patch"

diff -urN linux-2.5.44/arch/i386/mach-generic/do_timer.h linux-2.5.44-new/arch/i386/mach-generic/do_timer.h
--- linux-2.5.44/arch/i386/mach-generic/do_timer.h	2002-10-19 06:02:30.000000000 +0200
+++ linux-2.5.44-new/arch/i386/mach-generic/do_timer.h	2002-10-24 20:09:31.000000000 +0200
@@ -1,5 +1,7 @@
 /* defines for inline arch setup functions */
 
+#include <asm/apic.h>
+
 /**
  * do_timer_interrupt_hook - hook into timer tick
  * @regs:	standard registers from interrupt

--Q68bSM7Ycu6FN28Q--
