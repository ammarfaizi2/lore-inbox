Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUAPTbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbUAPTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:31:36 -0500
Received: from mail4.edisontel.com ([62.94.0.37]:20113 "EHLO
	mail4.edisontel.com") by vger.kernel.org with ESMTP id S265507AbUAPTbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:31:34 -0500
From: Eduard Roccatello <lilo.please.no.spam@roccatello.it>
Organization: SPINE
To: linux-kernel@vger.kernel.org
Subject: p4-clockmod does not compile under 2.6.1-mm3
Date: Fri, 16 Jan 2004 20:14:24 +0100
User-Agent: KMail/1.5.4
X-IRC: #hardware@azzurra.org #rolug@freenode
X-Jabber: eduardroccatello@jabber.linux.it
X-GPG-Keyserver: keyserver.linux.it
X-GPG-FingerPrint: F7B3 3844 038C D582 2C04 4488 8D46 368B 474D 6DB0
X-GPG-KeyID: 474D6DB0
X-Website: http://www.pcimprover.it
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401162014.24567.lilo.please.no.spam@roccatello.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello :-)

bash-2.05b# gcc --version
gcc (GCC) 3.2.3

bash-2.05b# make
  SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: `cpu_sibling_map' undeclared 
(first use in this function)
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: (Each undeclared identifier 
is reported only once
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: for each function it appears 
in.)
make[3]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Error 1
make[2]: *** [arch/i386/kernel/cpu/cpufreq] Error 2
make[1]: *** [arch/i386/kernel/cpu] Error 2
make: *** [arch/i386/kernel] Error 2

adding a cpumask_t cpu_sibling_map[NR_CPUS] to the function make it compile 
but i think this is a very bad solution (sorry I'm not a kernel hacker :-)


Thanks,
Eduard

