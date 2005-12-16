Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVLPWAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVLPWAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVLPWAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:00:08 -0500
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:12585 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932523AbVLPWAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:00:07 -0500
Subject: cpufreq broken in 2.6.15-rc5
From: Mark Rosenstand <mark@borkware.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 23:00:05 +0100
Message-Id: <1134770405.1111.10.camel@mjollnir>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the ondemand governor with powernow-k8 on an Athlon 64 3200+
desktop. However, it's acting a bit strange:

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
2000000
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
2000000

This results in the processor always running at 100%.

The relevant part from dmesg:

powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
cpu_init done, current fid 0xc, vid 0x2

My .config:

	CONFIG_CPU_FREQ=y
	CONFIG_CPU_FREQ_TABLE=y
	# CONFIG_CPU_FREQ_DEBUG is not set
	CONFIG_CPU_FREQ_STAT=y
	CONFIG_CPU_FREQ_STAT_DETAILS=y
	# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
	CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
	# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
	# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
	CONFIG_CPU_FREQ_GOV_USERSPACE=y
	CONFIG_CPU_FREQ_GOV_ONDEMAND=y
	# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

I haven't tried any earlier rc's, but it works with 2.6.14. I'd be happy
to answer any questions.

Thanks,
Mark

