Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265127AbSJaC6t>; Wed, 30 Oct 2002 21:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265128AbSJaC6s>; Wed, 30 Oct 2002 21:58:48 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:37136 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265127AbSJaC6s>; Wed, 30 Oct 2002 21:58:48 -0500
Date: Thu, 31 Oct 2002 03:05:03 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix timer_pit.c warning
Message-ID: <20021031030500.GA3642@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *1875dr-000Jmk-00*Muyyca3JeZI* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make x86_do_profile available when UP=y,LOCAL_APIC=n

please apply

thanks
john


diff -Naur -X dontdiff linux-linus/arch/i386/kernel/timers/timer_pit.c linux/arch/i386/kernel/timers/timer_pit.c
--- linux-linus/arch/i386/kernel/timers/timer_pit.c	Sat Oct 12 16:54:44 2002
+++ linux/arch/i386/kernel/timers/timer_pit.c	Thu Oct 31 02:30:45 2002
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/irq.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
 #include <asm/io.h>
