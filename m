Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSJFRJY>; Sun, 6 Oct 2002 13:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261870AbSJFRJY>; Sun, 6 Oct 2002 13:09:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261807AbSJFRJX>; Sun, 6 Oct 2002 13:09:23 -0400
Subject: PATCH: 2.5.40 fix warning in longhaul.c
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:06:21 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yErF-0001rN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/arch/i386/kernel/cpu/cpufreq/longhaul.c linux.2.5.40-ac5/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux.2.5.40/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-10-02 21:34:05.000000000 +0100
+++ linux.2.5.40-ac5/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-10-03 14:47:45.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include <asm/msr.h>
 #include <asm/timex.h>
