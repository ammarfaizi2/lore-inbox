Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUHZHHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUHZHHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHZHHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:07:32 -0400
Received: from lhr002a.dhl.com ([198.141.197.2]:18137 "EHLO gateway3a.dhl.com")
	by vger.kernel.org with ESMTP id S267683AbUHZHHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:07:21 -0400
From: Michal Rokos <michal@rokos.info>
To: cpufreq@www.linux.org.uk
Subject: [2.6 PATCH] Missing default governors choices
Date: Thu, 26 Aug 2004 09:07:17 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408260907.17503.michal@rokos.info>
X-OriginalArrivalTime: 26 Aug 2004 07:07:30.0243 (UTC) FILETIME=[59FEF930:01C48B3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

aren't these 2 missing in "Default CPUFreq governor" menu?

Thank you.

 Michal

PS: CC to me (I'm off the lists)

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/26 08:57:24+02:00 michal@rokos.info 
#   Add missing governors to "Default CPUFreq governor" menu.
# 
# drivers/cpufreq/Kconfig
#   2004/08/26 08:57:13+02:00 michal@rokos.info +16 -0
#   Add missing governors to "Default CPUFreq governor" menu.
# 
diff -Nru a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
--- a/drivers/cpufreq/Kconfig 2004-08-26 09:00:15 +02:00
+++ b/drivers/cpufreq/Kconfig 2004-08-26 09:00:15 +02:00
@@ -27,6 +27,14 @@
    the frequency statically to the highest frequency supported by
    the CPU.
 
+config CPU_FREQ_DEFAULT_GOV_POWERSAVE
+ bool "powersave"
+ select CPU_FREQ_GOV_POWERSAVE
+ help
+   Use the CPUFreq governor 'powersave' as default. This sets
+   the frequency statically to the lowest frequency supported by
+   the CPU.
+
 config CPU_FREQ_DEFAULT_GOV_USERSPACE
  bool "userspace"
  select CPU_FREQ_GOV_USERSPACE
@@ -35,6 +43,14 @@
    you to set the CPU frequency manually or when an userspace 
    programm shall be able to set the CPU dynamically without having
    to enable the userspace governor manually.
+
+config CPU_FREQ_DEFAULT_GOV_ONDEMAND
+ bool "ondemand"
+ select CPU_FREQ_GOV_ONDEMAND
+ help
+   Use the CPUFreq governor 'ondemand' as default. This does
+   a periodic polling and changes frequency based on the CPU
+   utilization.
 
 endchoice
 
 
