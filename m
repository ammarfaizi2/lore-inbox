Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWKMTDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWKMTDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbWKMTDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:03:53 -0500
Received: from h155.mvista.com ([63.81.120.155]:28433 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1755333AbWKMTDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:03:52 -0500
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: mingo@elte.hu
Subject: [PATCH] 2.6.18-rt7: Calculate cpu_khz for PowerPC
Date: Mon, 13 Nov 2006 22:05:21 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611132205.29049.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually calculate PowerPC cpu_khz value for the latency tracing code.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -736,6 +736,7 @@ void __init time_init(void)
 	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
 	tb_ticks_per_sec = ppc_tb_freq;
 	tb_ticks_per_usec = ppc_tb_freq / 1000000;
+	cpu_khz  = ppc_tb_freq / 1000;
 	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
 	calc_cputime_factors();
 

