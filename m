Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbTIKErs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbTIKErs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:47:48 -0400
Received: from ns1.open.org ([199.2.104.1]:5778 "EHLO open.org")
	by vger.kernel.org with ESMTP id S266063AbTIKErp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:47:45 -0400
Message-ID: <3F5A00F8.9090406@open.org>
Date: Sat, 06 Sep 2003 08:44:56 -0700
From: Hal <pshbro@open.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3) Gecko/20030723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG resend: missing config options in 2.6.0-test5-bk1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry i sent the other bug report under this title last time.

[1] Missing config macros for PPC architecture.

[2]

CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE and 
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE are not being defined in
include/linux/autoconfig.h which causes CPUFREQ_DEFAULT_GOVERNOR not to 
be defined which will cause a compiler
syntax error in arch/ppc/platforms/pmac_cpufreq.h.

[3] arch/ppc/platforms/pmac_cpufreq.c CPUFREQ_DEFAULT_GOVERNOR 
include/linux/autoconfig.h
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE 
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE

[4] 2.6.0-test5-bk1

[5]

  CC      arch/ppc/platforms/pmac_cpufreq.o
  arch/ppc/platforms/pmac_cpufreq.c: In function `pmac_cpufreq_cpu_init':
  arch/ppc/platforms/pmac_cpufreq.c:260: `CPUFREQ_DEFAULT_GOVERNOR' 
undeclared (first use in this function)
  arch/ppc/platforms/pmac_cpufreq.c:260: (Each undeclared identifier is 
reported only once
  arch/ppc/platforms/pmac_cpufreq.c:260: for each function it appears in.)
  make[1]: *** [arch/ppc/platforms/pmac_cpufreq.o] Error 1
  make: *** [arch/ppc/platforms] Error 2

[6]

[7] Gentoo Linux

[7.1]

Linux darkstar.example.net 2.4.20-ben10 #11 Fri Sep 5 09:24:51 PDT 2003 
ppc  750FX GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.25
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         ipt_LOG ipt_state ipt_ttl iptable_filter 
iptable_nat ip_conntrack ip_tables

[7.2]

cpu             : 750FX
temperature     : 12 C (uncalibrated)
clock           : 700MHz
revision        : 1.18 (pvr 7000 0112)
bogomips        : 1389.36
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld


