Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTBJU3l>; Mon, 10 Feb 2003 15:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTBJU3l>; Mon, 10 Feb 2003 15:29:41 -0500
Received: from mail.buerotec.de ([217.89.50.162]:49412 "EHLO mail.buerotec.de")
	by vger.kernel.org with ESMTP id <S261527AbTBJU3l>;
	Mon, 10 Feb 2003 15:29:41 -0500
Date: Mon, 10 Feb 2003 21:37:02 +0100
From: Kay Sievers <lkml@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.60 defconfig+CONFIG_MODVERSIONS=y -> syntax error
Message-ID: <20030210203702.GA16226@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the compilation of a fresh 2.5.60-kernel failed with:

  gcc -Wp,-MD,arch/i386/kernel/.time.o.d -D__KERNEL__ -Iinclude -Wall
  -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
  -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4
  -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
  -DKBUILD_BASENAME=time -DKBUILD_MODNAME=time -c -o
  arch/i386/kernel/.tmp_time.o arch/i386/kernel/time.c
  ld:arch/i386/kernel/.tmp_time.ver:1: syntax error
  make[1]: *** [arch/i386/kernel/time.o] Error 1
  make: *** [arch/i386/kernel] Error 2

It's the "make defconfig .config" with CONFIG_MODVERSIONS switched on.

Kay
