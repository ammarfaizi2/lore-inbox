Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbTKMUHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTKMUHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:07:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17061 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264413AbTKMUHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:07:46 -0500
Subject: [PATCH] linux-2.6.0-test9-mm3_verbose-timesource-acpi-pm_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20031112233002.436f5d0c.akpm@osdl.org>
References: <20031112233002.436f5d0c.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068753832.11438.1685.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Nov 2003 12:03:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-12 at 23:30, Andrew Morton wrote:
> +acpi-pm-timer.patch
> +acpi-pm-timer-fixes.patch
> 
>  Yet another timer source for ia32
> 
[snip]
> verbose-timesource.patch
>   be verbose about the time source

Andrew, 
	I forgot that I sent you the verbose-timesource patch. The ACPI PM time
source will need this simple fix to work along side that patch.

thanks
-john

===== arch/i386/kernel/timers/timer_pm.c 1.6 vs edited =====
--- 1.6/arch/i386/kernel/timers/timer_pm.c	Tue Nov  4 11:39:50 2003
+++ edited/arch/i386/kernel/timers/timer_pm.c	Thu Nov 13 11:12:23 2003
@@ -185,6 +185,7 @@
 
 /* acpi timer_opts struct */
 struct timer_opts timer_pmtmr = {
+	.name			= "pmtmr",
 	.init 			= init_pmtmr,
 	.mark_offset		= mark_offset_pmtmr, 
 	.get_offset		= get_offset_pmtmr,



