Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSGNWKP>; Sun, 14 Jul 2002 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSGNWKO>; Sun, 14 Jul 2002 18:10:14 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:37762 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S317184AbSGNWKN>;
	Sun, 14 Jul 2002 18:10:13 -0400
Date: Mon, 15 Jul 2002 00:13:05 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: apm power_off on smp
Message-ID: <Pine.GSO.4.30.0207150010030.27346-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

APM's poweroff function is explicitly turned off on smp systems by
default. Could someone tell me please what is the reason for that?

In other words: what are the objections against the below patch? :)

diff -Naur a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Mon Feb 25 19:37:53 2002
+++ b/arch/i386/kernel/apm.c	Sun Jul 14 23:05:14 2002
@@ -393,11 +393,7 @@
 #endif
 static int			debug;
 static int			apm_disabled = -1;
-#ifdef CONFIG_SMP
-static int			power_off;
-#else
 static int			power_off = 1;
-#endif
 #ifdef CONFIG_APM_REAL_MODE_POWER_OFF
 static int			realmode_power_off = 1;
 #else

-- 
pozsy

