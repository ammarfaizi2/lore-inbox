Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755350AbWKMVDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbWKMVDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbWKMVDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:03:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32265 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755348AbWKMVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:03:44 -0500
Date: Mon, 13 Nov 2006 22:03:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [-mm patch] make arch/i386/kernel/io_apic.c:timer_irq_works() static again
Message-ID: <20061113210349.GF22565@stusta.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timer_irq_works() needlessly became global.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm1/arch/i386/kernel/io_apic.c.old	2006-11-13 18:18:37.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/io_apic.c	2006-11-13 18:18:54.000000000 +0100
@@ -1948,7 +1948,7 @@
  *	- if this function detects that timer IRQs are defunct, then we fall
  *	  back to ISA timer IRQs
  */
-int __init timer_irq_works(void)
+static int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
 

