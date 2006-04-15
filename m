Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWDOWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWDOWBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWDOWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:01:04 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:19 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965161AbWDOWBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:01:03 -0400
Date: Sun, 16 Apr 2006 00:00:55 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup default value of SCHED_SMT
Message-ID: <20060415220055.GA47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch removes wrong default for SCHED_SMT.

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/arch/i386/Kconfig
===================================================================
--- linux-2.6.17-rc1/arch/i386/Kconfig.old      2006-04-15 22:13:19.000000000 +0200
+++ linux-2.6.17-rc1/arch/i386/Kconfig  2006-04-15 22:14:14.000000000 +0200
@@ -224,7 +224,6 @@
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP
-	default off
 	help
 	  SMT scheduler support improves the CPU scheduler's decision making
 	  when dealing with Intel Pentium 4 chips with HyperThreading at a
Index: linux-2.6.17-rc1/arch/ia64/Kconfig
===================================================================
--- linux-2.6.17-rc1/arch/ia64/Kconfig.old      2006-04-15 22:12:11.000000000 +0200
+++ linux-2.6.17-rc1/arch/ia64/Kconfig  2006-04-15 22:13:05.000000000 +0200
@@ -282,7 +282,6 @@
 config SCHED_SMT
 	bool "SMT scheduler support"
 	depends on SMP
-	default off
 	help
 	  Improves the CPU scheduler's decision making when dealing with
 	  Intel IA64 chips with MultiThreading at a cost of slightly increased
Index: linux-2.6.17-rc1/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.17-rc1/arch/powerpc/Kconfig.old   2006-04-15 22:10:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/powerpc/Kconfig       2006-04-15 22:12:00.000000000 +0200
@@ -688,7 +688,6 @@
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on PPC64 && SMP
-	default off
 	help
 	  SMT scheduler support improves the CPU scheduler's decision making
 	  when dealing with POWER5 cpus at a cost of slightly increased


