Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUEUXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUEUXCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUEUWls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:41:48 -0400
Received: from zero.aec.at ([193.170.194.10]:5 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265198AbUEUWdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:03 -0400
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
References: <1Yaiz-33L-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 21 May 2004 12:29:05 +0200
In-Reply-To: <1Yaiz-33L-1@gated-at.bofh.it> (Zwane Mwaikambo's message of
 "Fri, 21 May 2004 07:00:07 +0200")
Message-ID: <m3vfiq3wge.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> This patch silences the default i386 boot by putting a lot of development
> related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
> to be turned on by using the 'debug' kernel parameter. I have avoided
> changing files which have external development repositories, like cpufreq and ACPI.

How about this much simpler patch? 

-Andi

diff -u linux/kernel/printk.c-o linux/kernel/printk.c
--- linux/kernel/printk.c-o	2004-05-18 10:55:53.000000000 +0200
+++ linux/kernel/printk.c	2004-05-21 12:28:05.000000000 +0200
@@ -37,7 +37,7 @@
 #define __LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 
 /* printk's without a loglevel use this.. */
-#define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
+#define DEFAULT_MESSAGE_LOGLEVEL 6 /* KERN_INFO */
 
 /* We show everything that is MORE important than this.. */
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */

