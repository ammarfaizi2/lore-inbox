Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWEAUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWEAUqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWEAUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:46:14 -0400
Received: from mail.fuug.fi ([83.145.198.117]:65488 "EHLO mail.fuug.fi")
	by vger.kernel.org with ESMTP id S932249AbWEAUqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:46:12 -0400
Date: Mon, 1 May 2006 23:46:05 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: Andrew Morton <akpm@osdl.org>
cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/kernel/cpu/transmeta.c: initialize variable
Message-ID: <Pine.LNX.4.64.0605012344330.3790@joo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petri T. Koistinen <petri.koistinen@iki.fi>

Remove warnings by initializing uninitialized variables.

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
---
 arch/i386/kernel/cpu/transmeta.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)
---
diff --git a/arch/i386/kernel/cpu/transmeta.c b/arch/i386/kernel/cpu/transmeta.c
index 7214c9b..cfc4783 100644
--- a/arch/i386/kernel/cpu/transmeta.c
+++ b/arch/i386/kernel/cpu/transmeta.c
@@ -9,7 +9,7 @@ static void __init init_transmeta(struct
 {
 	unsigned int cap_mask, uk, max, dummy;
 	unsigned int cms_rev1, cms_rev2;
-	unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
+	unsigned int cpu_rev = 0, cpu_freq = 0, cpu_flags, new_cpu_rev;
 	char cpu_info[65];

 	get_model_name(c);	/* Same as AMD/Cyrix */
@@ -17,7 +17,6 @@ static void __init init_transmeta(struct

 	/* Print CMS and CPU revision */
 	max = cpuid_eax(0x80860000);
-	cpu_rev = 0;
 	if ( max >= 0x80860001 ) {
 		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags);
 		if (cpu_rev != 0x02000000) {


