Return-Path: <linux-kernel-owner+w=401wt.eu-S932720AbWLSJZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWLSJZm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWLSJZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:25:42 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:59645 "EHLO
	liaag2ag.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932713AbWLSJZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:25:41 -0500
Date: Tue, 19 Dec 2006 04:18:13 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG linux-2.6-20-rc1: kernel BUG at
  drivers/cpufreq/cpufreq_userspace.c
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Message-ID: <200612190421_MC3-1-D58E-782E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <45859609.8050502@rrz.uni-koeln.de>

On Sun, 17 Dec 2006 20:10:01 +0100, Berthold Cogel wrote:

> I've found a kernel bug in linux-2.6-20-rc1 from kernel.org:
> 
> Dec 17 19:12:56 localhost kernel: kernel BUG at drivers/cpufreq/cpufreq_userspace.c:140!

Does this fix it?

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.20-rc1-32smp.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ 2.6.20-rc1-32smp/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -706,7 +706,7 @@ static int acpi_cpufreq_cpu_init(struct 
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
-		get_cur_freq_on_cpu(cpu);
+		policy->cur = get_cur_freq_on_cpu(cpu);
 		break;
 	default:
 		break;
-- 
MBTI: IXTP
