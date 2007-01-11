Return-Path: <linux-kernel-owner+w=401wt.eu-S1030444AbXAKNsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbXAKNsp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbXAKNsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:48:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4591 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030444AbXAKNso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:48:44 -0500
Date: Thu, 11 Jan 2007 14:48:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] CPU_FREQ_TABLE shouldn't be a def_tristate
Message-ID: <20070111134848.GB20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_FREQ_TABLE enables helper code and gets select'ed when it's 
required.

Building it as a module when it's not required doesn't seem to make much 
sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc3-mm1/drivers/cpufreq/Kconfig.old	2007-01-11 07:56:13.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/cpufreq/Kconfig	2007-01-11 07:56:25.000000000 +0100
@@ -16,7 +16,7 @@
 if CPU_FREQ
 
 config CPU_FREQ_TABLE
-       def_tristate m
+       tristate
 
 config CPU_FREQ_DEBUG
 	bool "Enable CPUfreq debugging"

