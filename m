Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbTFZDLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 23:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTFZDLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 23:11:08 -0400
Received: from [66.212.224.118] ([66.212.224.118]:48657 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265366AbTFZDK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 23:10:57 -0400
Date: Wed, 25 Jun 2003 23:13:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: [PATCH][2.5] Remove debug debris from nmi_timer_int
Message-ID: <Pine.LNX.4.53.0306252309320.31258@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This little (from yours truly - sorry) bit snuck in during the 
oprofile nmi_timer_int submission, it was only being used for debug 
purposes.

Index: linux-2.5/arch/i386/kernel/nmi.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/nmi.c,v
retrieving revision 1.20
diff -u -p -B -r1.20 nmi.c
--- linux-2.5/arch/i386/kernel/nmi.c	21 Jun 2003 16:19:10 -0000	1.20
+++ linux-2.5/arch/i386/kernel/nmi.c	26 Jun 2003 02:06:17 -0000
@@ -189,7 +189,6 @@ void disable_timer_nmi_watchdog(void)
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
 		return;
 
-	disable_irq(0);
 	unset_nmi_callback();
 	nmi_active = -1;
 	nmi_watchdog = NMI_NONE;
@@ -201,7 +200,6 @@ void enable_timer_nmi_watchdog(void)
 		nmi_watchdog = NMI_IO_APIC;
 		touch_nmi_watchdog();
 		nmi_active = 1;
-		enable_irq(0);
 	}
 }
 
