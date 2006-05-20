Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWETXUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWETXUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 19:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWETXUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 19:20:13 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:59017 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S964820AbWETXUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 19:20:11 -0400
Date: Sat, 20 May 2006 19:19:48 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@sg1
To: linux-kernel@vger.kernel.org
Subject: [patch] initialize variables to reduce i386 warnings
Message-ID: <Pine.LNX.4.61.0605201919100.2160@sg1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialized cpu_freq in arch/i386/kernel/cpu/transmeta.c to suppress warning.

diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
index 7214c9b..0737890 100644
--- a/arch/i386/kernel/cpu/transmeta.c
+++ b/arch/i386/kernel/cpu/transmeta.c
@@ -9,7 +9,7 @@ static void __init init_transmeta(struct
  {
  	unsigned int cap_mask, uk, max, dummy;
  	unsigned int cms_rev1, cms_rev2;
-	unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
+	unsigned int cpu_rev, cpu_freq = 0, cpu_flags, new_cpu_rev;
  	char cpu_info[65];

  	get_model_name(c);	/* Same as AMD/Cyrix */



!-------------------------------------------------------------flip-


More variable initializations to get rid of warnings.

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index df0e174..39838a1 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1063,7 +1063,7 @@ #if defined(CONFIG_APM_DISPLAY_BLANK) &&

  static int apm_console_blank(int blank)
  {
-	int error, i;
+	int error = 0, i;
  	u_short state;
  	static const u_short dev[3] = { 0x100, 0x1FF, 0x101 };

diff --git a/arch/i386/kernel/efi.c b/arch/i386/kernel/efi.c
index 9202b67..3a7e485 100644
--- a/arch/i386/kernel/efi.c
+++ b/arch/i386/kernel/efi.c
@@ -270,8 +270,8 @@ void efi_memmap_walk(efi_freemem_callbac
  {
  	int prev_valid = 0;
  	struct range {
-		unsigned long start;
-		unsigned long end;
+		unsigned long start = 0;
+		unsigned long end = 0;
  	} prev, curr;
  	efi_memory_desc_t *md;
  	unsigned long start, end;



!-------------------------------------------------------------flip-


