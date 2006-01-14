Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945984AbWANCfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945984AbWANCfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbWANCfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:35:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945984AbWANCfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:35:15 -0500
Date: Sat, 14 Jan 2006 03:35:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] SOFTWARE_SUSPEND: fix a typo in the dependencies
Message-ID: <20060114023515.GJ29663@stusta.de>
References: <20060110043627.GD3911@stusta.de> <20060106202948.GB2736@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106202948.GB2736@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in the dependencies of SOFTWARE_SUSPEND.

This patch is based on a report by
Jean-Luc Leger <reiga@dspnet.fr.eu.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm3-full/kernel/power/Kconfig.old	2006-01-14 03:25:54.000000000 +0100
+++ linux-2.6.15-mm3-full/kernel/power/Kconfig	2006-01-14 03:26:03.000000000 +0100
@@ -38,7 +38,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
+	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

