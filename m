Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTCEWwX>; Wed, 5 Mar 2003 17:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTCEWwX>; Wed, 5 Mar 2003 17:52:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45961 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266716AbTCEWwV>; Wed, 5 Mar 2003 17:52:21 -0500
Date: Wed, 05 Mar 2003 14:53:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bugme-new] [Bug 442] New: compile failure in drivers/cpufreq/userspace.c (fwd)
Message-ID: <657950000.1046904813@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=442

           Summary: compile failure in drivers/cpufreq/userspace.c
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc3
Hardware Environment:  Abit KG7-RAID, AMD Athlon TBird 1.4, 512MB DDR, Geforce 3
Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
Problem Description:

  gcc -Wp,-MD,drivers/cpufreq/.userspace.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=userspace
-DKBUILD_MODNAME=userspace -c -o drivers/cpufreq/.tmp_userspace.o
drivers/cpufreq/userspace.c
drivers/cpufreq/userspace.c: In function `cpufreq_governor_userspace':
drivers/cpufreq/userspace.c:514: structure has no member named `intf'
drivers/cpufreq/userspace.c:523: structure has no member named `intf'
make[2]: *** [drivers/cpufreq/userspace.o] Error 1
make[1]: *** [drivers/cpufreq] Error 2
make: *** [drivers] Error 2


Steps to reproduce:

Power management options (ACPI, APM)  --->
CPU Frequency scaling  --->
<*>   'userspace' governor for userspace frequency scaling

CONFIG_CPU_FREQ_GOV_USERSPACE=y

