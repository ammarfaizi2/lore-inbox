Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTCEK7t>; Wed, 5 Mar 2003 05:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTCEK7t>; Wed, 5 Mar 2003 05:59:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2058 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265361AbTCEK7s>; Wed, 5 Mar 2003 05:59:48 -0500
Date: Wed, 5 Mar 2003 11:10:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Those ruddy punctuation fixes
Message-ID: <20030305111015.B8883@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could we stop fix^wbreaking this stuff please.  GCC 3.2.2:

  arm-linux-gcc -Wp,-MD,arch/arm/kernel/.asm-offsets.s.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mapcs-32 -D__LINUX_ARM_ARCH__=4
-march=armv4 -mtune=strongarm110 -mshort-load-bytes -msoft-float -Wa,-mno-fpu -Uarm -nostdinc -iwithprefix include    -DKBUILD_BASENAME=asm_offsets -DKBUILD_MODNAME=asm_offsets -S -o arch/arm/kernel/asm-offsets.s arch/arm/kernel/asm-offsets.c
In file included from include/asm/system.h:28,
                 from include/asm/bitops.h:22,
                 from include/linux/bitops.h:3,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:7,
                 from arch/arm/kernel/asm-offsets.c:15:
include/asm/proc-fns.h:128:39: missing terminating ' character

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

