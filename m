Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWGIRxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWGIRxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWGIRxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:53:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18191 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030245AbWGIRxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:53:10 -0400
Date: Sun, 9 Jul 2006 19:53:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, rafalbilski@interia.pl,
       Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: [-mm patch] make arch/i386/kernel/cpu/cpufreq/longhaul.c:longhaul_walk_callback() static
Message-ID: <20060709175308.GJ13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:11:06AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm6:
>...
>  git-cpufreq.patch
>...
>  git trees
>...

This patch makes the needlessly global longhaul_walk_callback() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/arch/i386/kernel/cpu/cpufreq/longhaul.c.old	2006-07-09 16:29:54.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/arch/i386/kernel/cpu/cpufreq/longhaul.c	2006-07-09 16:30:11.000000000 +0200
@@ -524,9 +524,9 @@
 	return calc_speed(longhaul_get_cpu_mult());
 }
 
-acpi_status longhaul_walk_callback(acpi_handle obj_handle,
-				  u32 nesting_level,
-				  void *context, void **return_value)
+static acpi_status longhaul_walk_callback(acpi_handle obj_handle,
+					  u32 nesting_level,
+					  void *context, void **return_value)
 {
 	struct acpi_device *d;
 

