Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTLAOPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTLAOPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:15:45 -0500
Received: from k1.dinoex.de ([80.237.200.138]:53484 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S263537AbTLAOPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:15:39 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6] Missing L2-cache after warm boot
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Mon, 01 Dec 2003 15:04:22 +0100
Message-ID: <87ptf8bpnd.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.6.0-test11 on an older Thinkpad 390E,
When booting into 2.6.0-test11 after running Windows2000 I get:

Dec  1 14:51:56 gswi1164 kernel: Initializing CPU#0
Dec  1 14:51:56 gswi1164 kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Dec  1 14:51:56 gswi1164 kernel: Detected 298.602 MHz processor.
Dec  1 14:51:56 gswi1164 kernel: Console: colour dummy device 80x25
Dec  1 14:51:56 gswi1164 kernel: Memory: 190848k/196544k available (2008k kernel code, 5060k reserved, 762k data, 148k init, 0k
highmem)
Dec  1 14:51:56 gswi1164 kernel: Calibrating delay loop... 587.77 BogoMIPS
Dec  1 14:51:56 gswi1164 kernel: Security Scaffold v1.0.0 initialized
Dec  1 14:51:56 gswi1164 kernel: Capability LSM initialized
Dec  1 14:51:56 gswi1164 kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec  1 14:51:56 gswi1164 kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Dec  1 14:51:56 gswi1164 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Dec  1 14:51:56 gswi1164 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec  1 14:51:56 gswi1164 kernel: Intel machine check architecture supported.
Dec  1 14:51:56 gswi1164 kernel: Intel machine check reporting enabled on CPU#0.
Dec  1 14:51:56 gswi1164 kernel: CPU: Intel Mobile Pentium II stepping 0a
Dec  1 14:51:56 gswi1164 kernel: Enabling fast FPU save and restore... done.
Dec  1 14:51:56 gswi1164 kernel: Checking 'hlt' instruction... OK.

When booting cold the boot messages are:

Dec  1 14:54:57 gswi1164 kernel: Initializing CPU#0
Dec  1 14:54:57 gswi1164 kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Dec  1 14:54:57 gswi1164 kernel: Detected 298.598 MHz processor.
Dec  1 14:54:57 gswi1164 kernel: Console: colour dummy device 80x25
Dec  1 14:54:57 gswi1164 kernel: Memory: 190848k/196544k available (2008k kernel code, 5060k reserved, 762k data, 148k init, 0k
highmem)
Dec  1 14:54:57 gswi1164 kernel: Calibrating delay loop... 587.77 BogoMIPS
Dec  1 14:54:57 gswi1164 kernel: Security Scaffold v1.0.0 initialized
Dec  1 14:54:57 gswi1164 kernel: Capability LSM initialized
Dec  1 14:54:57 gswi1164 kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec  1 14:54:57 gswi1164 kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Dec  1 14:54:57 gswi1164 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Dec  1 14:54:57 gswi1164 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec  1 14:54:57 gswi1164 kernel: CPU: L2 cache: 256K
Dec  1 14:54:57 gswi1164 kernel: Intel machine check architecture supported.
Dec  1 14:54:57 gswi1164 kernel: Intel machine check reporting enabled on CPU#0.
Dec  1 14:54:57 gswi1164 kernel: CPU: Intel Mobile Pentium II stepping 0a
Dec  1 14:54:57 gswi1164 kernel: Enabling fast FPU save and restore... done.
Dec  1 14:54:57 gswi1164 kernel: Checking 'hlt' instruction... OK.

/proc/cpuinfo contains (after warm boot):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Mobile Pentium II
stepping        : 10
cpu MHz         : 298.598
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 587.77

Is there any way to find out, why the second level cache isn't
detected after a warm boot?

Jochen

-- 
#include <~/.signature>: permission denied
