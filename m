Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWAPEna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWAPEna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 23:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWAPEna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 23:43:30 -0500
Received: from S01060080c85517f6.wp.shawcable.net ([24.79.196.167]:6325 "EHLO
	ubb.ca") by vger.kernel.org with ESMTP id S1751013AbWAPEna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 23:43:30 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Tony Mantler <nicoya@ubb.ca>
Subject: CONFIG_MK6 = lsof hangs unkillable
Date: Sun, 15 Jan 2006 22:43:25 -0600
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble running lsof on 2.6.15.1 when the kernel is  
compiled with CONFIG_MK6. When run as root, lsof will segfault, and  
when run as a user lsof will hang unkillable.

The same kernel, same machine, but compiled with CONFIG_MK7 runs just  
lsof just fine.

some versions:
gcc version 4.0.3 20060104 (prerelease) (Debian 4.0.2-6)
lsof                       4.76.dfsg.1-1              List open files.

diff between broken and working (I can send a full .config if needed):
--- config-lsof-broken 2006-01-15 22:02:48.450750000 -0600
+++ config-lsof-working 2006-01-15 22:04:10.003846750 -0600
@@ -1,7 +1,7 @@
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15.1
-# Sun Jan 15 21:31:32 2006
+# Sun Jan 15 22:04:10 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
@@ -106,8 +106,8 @@
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
-CONFIG_MK6=y
-# CONFIG_MK7 is not set
+# CONFIG_MK6 is not set
+CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
@@ -120,7 +120,7 @@
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
-CONFIG_X86_L1_CACHE_SHIFT=5
+CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
@@ -128,8 +128,10 @@
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
-CONFIG_X86_ALIGNMENT_16=y
+CONFIG_X86_GOOD_APIC=y
+CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set

--
Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
--  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --

