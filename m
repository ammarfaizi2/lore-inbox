Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276642AbRKAA1E>; Wed, 31 Oct 2001 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbRKAA0y>; Wed, 31 Oct 2001 19:26:54 -0500
Received: from [65.205.244.67] ([65.205.244.67]:21661 "EHLO myrina")
	by vger.kernel.org with ESMTP id <S276642AbRKAA0p>;
	Wed, 31 Oct 2001 19:26:45 -0500
Message-ID: <3BE09769.2060703@earthling.net>
Date: Wed, 31 Oct 2001 16:29:29 -0800
From: Adam Williams <broadcast@earthling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.13 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: crash in smp_core99_kick_cpu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a dual CPU G4.  Startup freezes after

smp_core99_kick_cpu done

is displayed.  Commenting out the

KL_GPIO_OUT(reset_io, KEYLARGO_GPIO_OUTPUT_ENABLE);

line in feature_core99_kick_cpu allows the boot process to
continue but with only CPU #0 and a "Processor 1 is stuck"
message.

MacOS 9.2 booted fine and detected both CPUs.

Compiler gcc 2.96
Kernel 2.4.13

Kernels compiled with gcc 3.0.2 just crash and go into
open firmware.

cat /proc/cpuinfo displays




processor       : 0
cpu             : 7450, altivec supported
temperature     : 1-76 C (uncalibrated)
clock           : 799MHz
revision        : 2.1 (pvr 8000 0201)
bogomips        : 797.90
total bogomips  : 797.90
zero pages      : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine         : PowerMac3,5
motherboard     : PowerMac3,5 MacRISC2 MacRISC Power Macintosh
L2 cache        : 256K unified
memory          : 256MB
pmac-generation : NewWorld





