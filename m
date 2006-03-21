Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWCUNSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWCUNSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWCUNSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:18:37 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:46486 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751671AbWCUNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:18:36 -0500
Message-ID: <441FFB28.5050609@t-online.de>
Date: Tue, 21 Mar 2006 14:10:00 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [BUG] wrong bogomips  values with kernel 2.6.16
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EG+EF6ZaYeetyU4ObEEq6BKumvr2q9jSUE401MXs4CR9lFSpoRTlYz@t-dialin.net
X-TOI-MSGID: 191b9653-5350-4bac-b9fb-9bc17a7b397c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

System: AOpen i915GMm-HFS motherboard, kernel 2.6.16
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08

During startup a BogoMips value  of 3730.21 is calculated. That
should be the correct value for the cpu running at full speed. But:

"cat /proc/cpuinfo" on the idle system displays the correct cpu speed, but
a wrong bogomips value:

    cpu MHz         : 800.000
    bogomips        : 3730.21

"cat /proc/cpuinfo" on the busy system displays the correct cpu speed 
too, but
again a wrong bogomips value:

    cpu MHz         : 1867.000
    bogomips        : 8705.38

The relevant snippets from .config:

CONFIG_X86_PC=y
CONFIG_MPENTIUMM=y

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_DEBUG=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y

cu,
 knut

