Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTLLKIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 05:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTLLKIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 05:08:51 -0500
Received: from mail05.inetu.net ([209.235.192.122]:25865 "EHLO
	mail05.inetu.net") by vger.kernel.org with ESMTP id S264524AbTLLKIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 05:08:50 -0500
Message-ID: <1f2001c3c099$675440d0$00f7fea9@unisoft.net>
From: "san" <sanjeev@unisoftindia.net>
To: <linux-kernel@vger.kernel.org>
Subject: ARM Proc, Linux Kernel 2.4.19 Vs. Linux Kernel 2.6.0. test10
Date: Fri, 12 Dec 2003 15:49:10 +0530
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Can anyone there help me

I am able to compile and download the kernel (2.4.19) on to my Assabet board
, same thing when i am trying to compile 2.6 test10 with .rmk10 patch i am
not able to make it up at the same board.

What are the differences made in 2.6 when compared to 2.4

I tried modifying the foll. values in different files based on my
requirement.

1. include/asm-arm/arch-sa1100/memory.h

TEXT_SIZE 0xC8000000UL
PHYS_OFFSET 0xC8000000UL
PAGE_OFFSET 0xC8000000UL

2. arch/arm/Makefile

 ifeq((CONFIG_ARCH_CPU32),y)
  MACHINE = sa1100
 endif
The above value is available in 2.4.19, but in 2.6 i am not able identify
it.

In arch/arm/mach-sa1100/arch.c
 a) In fixup_assabet
i  Changed
  i)t->u.mem.start = 0xC8000000 from 0xC0000000
  ii)t->u.mem.size = 16*1024*1024 from 32*1024*1024
  iii)t->u.initrd.start = 0xC8300000 from 0xC0800000


