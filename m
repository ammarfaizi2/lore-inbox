Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272650AbTHKOV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272628AbTHKNmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:04 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:39819 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272622AbTHKNlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:05 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, john@movementarian.org
Subject: [PATCH] Remove duplicate ; at end of macro definitions
Message-Id: <E19mCuO-0003dO-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/oprofile/op_model_p4.c linux-2.5/arch/i386/oprofile/op_model_p4.c
--- bk-linus/arch/i386/oprofile/op_model_p4.c	2003-07-10 23:54:43.000000000 +0100
+++ linux-2.5/arch/i386/oprofile/op_model_p4.c	2003-07-11 14:08:02.000000000 +0100
@@ -355,8 +355,8 @@ static struct p4_event_binding p4_events
 #define ESCR_SET_OS_1(escr, os) ((escr) |= (((os) & 1) << 1))
 #define ESCR_SET_EVENT_SELECT(escr, sel) ((escr) |= (((sel) & 0x3f) << 25))
 #define ESCR_SET_EVENT_MASK(escr, mask) ((escr) |= (((mask) & 0xffff) << 9))
-#define ESCR_READ(escr,high,ev,i) do {rdmsr(ev->bindings[(i)].escr_address, (escr), (high));} while (0);
-#define ESCR_WRITE(escr,high,ev,i) do {wrmsr(ev->bindings[(i)].escr_address, (escr), (high));} while (0);
+#define ESCR_READ(escr,high,ev,i) do {rdmsr(ev->bindings[(i)].escr_address, (escr), (high));} while (0)
+#define ESCR_WRITE(escr,high,ev,i) do {wrmsr(ev->bindings[(i)].escr_address, (escr), (high));} while (0)
 
 #define CCCR_RESERVED_BITS 0x38030FFF
 #define CCCR_CLEAR(cccr) ((cccr) &= CCCR_RESERVED_BITS)
@@ -366,13 +366,13 @@ static struct p4_event_binding p4_events
 #define CCCR_SET_PMI_OVF_1(cccr) ((cccr) |= (1<<27))
 #define CCCR_SET_ENABLE(cccr) ((cccr) |= (1<<12))
 #define CCCR_SET_DISABLE(cccr) ((cccr) &= ~(1<<12))
-#define CCCR_READ(low, high, i) do {rdmsr (p4_counters[(i)].cccr_address, (low), (high));} while (0);
-#define CCCR_WRITE(low, high, i) do {wrmsr (p4_counters[(i)].cccr_address, (low), (high));} while (0);
+#define CCCR_READ(low, high, i) do {rdmsr (p4_counters[(i)].cccr_address, (low), (high));} while (0)
+#define CCCR_WRITE(low, high, i) do {wrmsr (p4_counters[(i)].cccr_address, (low), (high));} while (0)
 #define CCCR_OVF_P(cccr) ((cccr) & (1U<<31))
 #define CCCR_CLEAR_OVF(cccr) ((cccr) &= (~(1U<<31)))
 
-#define CTR_READ(l,h,i) do {rdmsr(p4_counters[(i)].counter_address, (l), (h));} while (0);
-#define CTR_WRITE(l,i) do {wrmsr(p4_counters[(i)].counter_address, -(u32)(l), -1);} while (0);
+#define CTR_READ(l,h,i) do {rdmsr(p4_counters[(i)].counter_address, (l), (h));} while (0)
+#define CTR_WRITE(l,i) do {wrmsr(p4_counters[(i)].counter_address, -(u32)(l), -1);} while (0)
 #define CTR_OVERFLOW_P(ctr) (!((ctr) & 0x80000000))
 
 
