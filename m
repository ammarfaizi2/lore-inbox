Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269223AbUHZQxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269223AbUHZQxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUHZQpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:45:53 -0400
Received: from fmr05.intel.com ([134.134.136.6]:29401 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269201AbUHZQlp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:41:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 PATCH] Missing default governors choices
Date: Thu, 26 Aug 2004 09:40:08 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6002B5F40B@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 PATCH] Missing default governors choices
Thread-Index: AcSLO3IjwkpaYDi9Qe2+RJITpShlxQATxqfQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Michal Rokos" <michal@rokos.info>, <cpufreq@www.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Aug 2004 16:40:09.0076 (UTC) FILETIME=[5974D340:01C48B8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ondemand govrenor not being one of the default governors is intentional.

Ondemand governor is in-kernel cpu frequency governor, that will 
Be beneficial for CPUs that supports frequency change with low 
transition_latency. If transition_latency is high, the ondemand governor

initialization will fail (User level governor is suggested in this
case).
Hence it cannot be used as a default governor. 

Thanks,
Venki 

>-----Original Message-----
>From: cpufreq-bounces@www.linux.org.uk 
>[mailto:cpufreq-bounces@www.linux.org.uk] On Behalf Of Michal Rokos
>Sent: Thursday, August 26, 2004 12:07 AM
>To: cpufreq@www.linux.org.uk
>Cc: linux-kernel@vger.kernel.org
>Subject: [2.6 PATCH] Missing default governors choices
>
>Hello,
>
>aren't these 2 missing in "Default CPUFreq governor" menu?
>
>Thank you.
>
> Michal
>
>PS: CC to me (I'm off the lists)
>
># This is a BitKeeper generated diff -Nru style patch.
>#
># ChangeSet
>#   2004/08/26 08:57:24+02:00 michal@rokos.info 
>#   Add missing governors to "Default CPUFreq governor" menu.
># 
># drivers/cpufreq/Kconfig
>#   2004/08/26 08:57:13+02:00 michal@rokos.info +16 -0
>#   Add missing governors to "Default CPUFreq governor" menu.
># 
>diff -Nru a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>--- a/drivers/cpufreq/Kconfig 2004-08-26 09:00:15 +02:00
>+++ b/drivers/cpufreq/Kconfig 2004-08-26 09:00:15 +02:00
>@@ -27,6 +27,14 @@
>    the frequency statically to the highest frequency supported by
>    the CPU.
> 
>+config CPU_FREQ_DEFAULT_GOV_POWERSAVE
>+ bool "powersave"
>+ select CPU_FREQ_GOV_POWERSAVE
>+ help
>+   Use the CPUFreq governor 'powersave' as default. This sets
>+   the frequency statically to the lowest frequency supported by
>+   the CPU.
>+
> config CPU_FREQ_DEFAULT_GOV_USERSPACE
>  bool "userspace"
>  select CPU_FREQ_GOV_USERSPACE
>@@ -35,6 +43,14 @@
>    you to set the CPU frequency manually or when an userspace 
>    programm shall be able to set the CPU dynamically without having
>    to enable the userspace governor manually.
>+
>+config CPU_FREQ_DEFAULT_GOV_ONDEMAND
>+ bool "ondemand"
>+ select CPU_FREQ_GOV_ONDEMAND
>+ help
>+   Use the CPUFreq governor 'ondemand' as default. This does
>+   a periodic polling and changes frequency based on the CPU
>+   utilization.
> 
> endchoice
> 
> 
>
>_______________________________________________
>Cpufreq mailing list
>Cpufreq@www.linux.org.uk
>http://www.linux.org.uk/mailman/listinfo/cpufreq
>
