Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWHNLie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWHNLie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbWHNLie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:38:34 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:59015 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752006AbWHNLid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:38:33 -0400
Date: Mon, 14 Aug 2006 13:38:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HT not active
Message-ID: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,



I cannot get HT to be used on some machine:

w04a# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 0
model name      : Intel(R) Pentium(R) 4 CPU 1700MHz
stepping        : 10
cpu MHz         : 1694.890
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
bogomips        : 3393.46

'ht' indicates:
#define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */                 

so I installed an SMP kernel, which has
CONFIG_SMP=y
CONFIG_SUSPEND_SMP=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_SCHED_SMT=y
CONFIG_X86_HT=y

yet it shows the 'up' flag in cpuinfo
#define X86_FEATURE_UP          (3*32+ 9) /* smp kernel running on up */

What could be missing? Some BIOS option perhaps?
Thanks for any hints.


Jan Engelhardt
-- 
