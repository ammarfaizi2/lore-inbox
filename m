Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268036AbTAIXDl>; Thu, 9 Jan 2003 18:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTAIXDl>; Thu, 9 Jan 2003 18:03:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:17061 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268036AbTAIXDh>; Thu, 9 Jan 2003 18:03:37 -0500
Date: Thu, 9 Jan 2003 18:11:22 -0500 (EST)
From: Richard A Nelson <cowboy@debian.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre3-ac1/2 and CONFIG_CPU_FREQ failure
Message-ID: <Pine.LNX.4.51.0301091807300.24500@nqynaqf.yrkvatgba.voz.pbz>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_CPU_FREQ is set, and CONFIG_SMP isn't,
./arch/i386/kernel/time.c will fail to compile at line 946:

#if defined(CONFIG_CPU_FREQ) && !defined(CONFIG_SMP)
    cpufreq_register_notifier(&time_cpufreq_notifier_block,
CPUFREQ_TRANSITION_NOTIFIER);
#endif

There is no definition of time_cpufreq_notifier_block

-- 
Rick Nelson
The nice thing about Windows is - It does not just crash, it displays a
dialog box and lets you press 'OK' first.
(Arno Schaefer's .sig)
