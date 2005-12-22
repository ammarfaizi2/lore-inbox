Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVLVOxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVLVOxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVLVOxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:53:35 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:24524 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750936AbVLVOxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:53:35 -0500
Date: Thu, 22 Dec 2005 15:53:32 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: conservative governor not working?
Message-ID: <20051222145332.GA12710@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

	I have tried to use the "conservative" cpufreq governor
on my Athlon64 X2 (dual-core), Tyan K8S board. When I set up the
"ondemand" governor, it works as expected - under the load the
CPU frequency is raised to maximum, and when the load stops,
the frequency slowly returns back. When I switch to the
"conservative" governor, it just stays on the same frequency all
the time not depending whether there is a CPU load or not.

	I have 2.6.15-rc6 kernel, Fedora Core 4 (native x86_64),
and I do not touch the default values in /sys/devices/system/cpu/*/cpufreq
except that setting a different governor. When the conservative governor
is on, I have the following settings:

./conservative/freq_step 5
./conservative/ignore_nice 0
./conservative/down_threshold 20
./conservative/up_threshold 80
./conservative/sampling_down_factor 5
./conservative/sampling_rate 124000000
./conservative/sampling_rate_min 62000000
./conservative/sampling_rate_max 1870457856
./scaling_cur_freq 1000000
./cpuinfo_cur_freq 1000000
./scaling_available_frequencies 2200000 2000000 1800000 1000000
./scaling_available_governors conservative ondemand performance
./scaling_driver powernow-k8
./scaling_governor conservative
./affected_cpus 0 1
./scaling_max_freq 2200000
./scaling_min_freq 1000000
./cpuinfo_max_freq 2200000
./cpuinfo_min_freq 1000000

	Does anybody have working conservative governor? And with K8,
or dual-core K8?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
