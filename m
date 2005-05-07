Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVEGIYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVEGIYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVEGIPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:15:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44196 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262789AbVEGIMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:41 -0400
Date: Sat, 07 May 2005 17:11:00 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 11/17] ARMNOMMU - platform patch for s3c24a0
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GS51H1NY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3E2RVt+T7PQVRJSW+I806LZuwA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [11/17]
 
- platform patch for s3c24a0
 
 arch/arm/mach-s3c24a0/Kconfig                  |   13
 arch/arm/mach-s3c24a0/Makefile                 |   30
 arch/arm/mach-s3c24a0/Makefile.boot            |    3
 arch/arm/mach-s3c24a0/clocks.c                 |  118 ++
 arch/arm/mach-s3c24a0/generic.c                |   42
 arch/arm/mach-s3c24a0/generic.h                |   14
 arch/arm/mach-s3c24a0/head.S                   |  173 ++
 arch/arm/mach-s3c24a0/irq.c                    |  314 +++++
 arch/arm/mach-s3c24a0/leds-smdk.c              |  122 ++
 arch/arm/mach-s3c24a0/leds.c                   |   30
 arch/arm/mach-s3c24a0/leds.h                   |    7
 arch/arm/mach-s3c24a0/registers.c              |  262 ++++
 arch/arm/mach-s3c24a0/smdk.c                   |  215 +++
 arch/arm/mach-s3c24a0/time.c                   |  249 ++++
 include/asm-arm/arch-s3c24a0/S3C24A0.h         | 1462
+++++++++++++++++++++++++
 include/asm-arm/arch-s3c24a0/bitfield.h        |  116 +
 include/asm-arm/arch-s3c24a0/clocks.h          |   38
 include/asm-arm/arch-s3c24a0/debug-macro.S     |   40
 include/asm-arm/arch-s3c24a0/dma.h             |   55
 include/asm-arm/arch-s3c24a0/entry-macro.S     |   32
 include/asm-arm/arch-s3c24a0/hardware.h        |  145 ++
 include/asm-arm/arch-s3c24a0/ide.h             |  148 ++
 include/asm-arm/arch-s3c24a0/io.h              |   45
 include/asm-arm/arch-s3c24a0/irq.h             |   16
 include/asm-arm/arch-s3c24a0/irqs.h            |  144 ++
 include/asm-arm/arch-s3c24a0/keyboard.h        |  134 ++
 include/asm-arm/arch-s3c24a0/memory.h          |   44
 include/asm-arm/arch-s3c24a0/param.h           |   11
 include/asm-arm/arch-s3c24a0/s3c24a0-common.h  |   35
 include/asm-arm/arch-s3c24a0/s3c24a0-ioctl.h   |  156 ++
 include/asm-arm/arch-s3c24a0/s3c24a0-key.h     |  116 +
 include/asm-arm/arch-s3c24a0/s3c24a0-machine.h |  223 +++
 include/asm-arm/arch-s3c24a0/s3c24a0_nand.h    |  485 ++++++++
 include/asm-arm/arch-s3c24a0/smdk.h            |  144 ++
 include/asm-arm/arch-s3c24a0/system.h          |   32
 include/asm-arm/arch-s3c24a0/time.h            |   16
 include/asm-arm/arch-s3c24a0/timex.h           |   27
 include/asm-arm/arch-s3c24a0/uncompress-jtag.h |   58
 include/asm-arm/arch-s3c24a0/uncompress.h      |   60 +
 include/asm-arm/arch-s3c24a0/vmalloc.h         |   24
 40 files changed, 5398 insertions(+)
 
Signed-off-by: HeeChul Yun <heechul.yun@samsung.com>
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-s3c24a0.pa
tch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

