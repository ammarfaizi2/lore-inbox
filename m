Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTE0PWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTE0PWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:22:47 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41630 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263872AbTE0PWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:22:45 -0400
Date: Tue, 27 May 2003 08:35:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 747] New: Compile the kernel
Message-ID: <9410000.1054049751@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Compile the kernel
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: andrey@assol.mipt.ru


Distribution: RedHat 7.0
Hardware Environment: Pentium-MMX 200MHz
Software Environment: gcc-2.95.3
Problem Description:

1)
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
  CHK     include/linux/compile.h
  AS      arch/i386/kernel/vsyscall.o
/tmp/ccBLzWOG.s: Assembler messages:
/tmp/ccBLzWOG.s:982: Error: Unknown pseudo-op:  `.incbin'
/tmp/ccBLzWOG.s:987: Error: Unknown pseudo-op:  `.incbin'
make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
make: *** [arch/i386/kernel] Error 2

i may compile next files if i delete this lines 
from 'arch/i386/kernel/vsyscall.S'

2)
  CC      kernel/softirq.o
{standard input}: Assembler messages:
{standard input}:631: Error: no such instruction: `mfence'
make[1]: *** [kernel/softirq.o] Error 1
make: *** [kernel] Error 2

if i choose in config 
CONFIG_M586 or CONFIG_M586TSC or CONFIG_M586MMX 

Steps to reproduce:
Compile the kernel.


