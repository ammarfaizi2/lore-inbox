Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVAOVkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVAOVkg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVAOVkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:40:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16401 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262325AbVAOVkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:40:01 -0500
Date: Sat, 15 Jan 2005 22:39:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, ak@suse.de,
       discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64 apic.c: make two functions static (fwd)
Message-ID: <20050115213957.GR4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 29 Nov 2004 00:02:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64 apic.c: make two functions static

The patch below makes two needlessly global functions static.


diffstat output:
 arch/i386/kernel/apic.c   |    4 ++--
 arch/x86_64/kernel/apic.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/apic.c.old	2004-11-28 20:59:02.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/apic.c	2004-11-28 20:59:39.000000000 +0100
@@ -926,7 +926,7 @@
 
 #define APIC_DIVISOR 16
 
-void __setup_APIC_LVTT(unsigned int clocks)
+static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
 
@@ -976,7 +976,7 @@
  * APIC irq that way.
  */
 
-int __init calibrate_APIC_clock(void)
+static int __init calibrate_APIC_clock(void)
 {
 	unsigned long long t1 = 0, t2 = 0;
 	long tt1, tt2;
--- linux-2.6.10-rc2-mm3-full/arch/x86_64/kernel/apic.c.old	2004-11-28 20:59:21.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/x86_64/kernel/apic.c	2004-11-28 20:59:44.000000000 +0100
@@ -675,7 +675,7 @@
 
 #define APIC_DIVISOR 16
 
-void __setup_APIC_LVTT(unsigned int clocks)
+static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
 
@@ -748,7 +748,7 @@
 
 #define TICK_COUNT 100000000
 
-int __init calibrate_APIC_clock(void)
+static int __init calibrate_APIC_clock(void)
 {
 	int apic, apic_start, tsc, tsc_start;
 	int result;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

