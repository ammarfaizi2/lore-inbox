Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWAJNCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWAJNCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWAJNCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:02:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17427 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750936AbWAJNCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:02:24 -0500
Date: Tue, 10 Jan 2006 14:02:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/powerpc/Kconfig: fix GENERIC_TBSYNC dependencies
Message-ID: <20060110130222.GI3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the dependencies of GENERIC_TBSYNC (this bug was found 
by Jean-Luc Leger <reiga@dspnet.fr.eu.org>).

Additionally, it removes the superfluous "default n".


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/arch/powerpc/Kconfig.old	2006-01-10 13:59:33.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/powerpc/Kconfig	2006-01-10 13:59:57.000000000 +0100
@@ -406,8 +406,7 @@
 
 config GENERIC_TBSYNC
 	bool
-	default y if CONFIG_PPC32 && CONFIG_SMP
-	default n
+	default y if PPC32 && SMP
 
 source "drivers/cpufreq/Kconfig"
 

