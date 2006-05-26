Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWEZO5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEZO5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWEZO5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:57:39 -0400
Received: from bay103-f2.bay103.hotmail.com ([65.54.174.12]:2773 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750855AbWEZO5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:57:39 -0400
Message-ID: <BAY103-F252A8BF91ABBFB34A8CE9B29E0@phx.gbl>
X-Originating-IP: [85.36.106.198]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Section mismatch: reference to .init.text: from .smp_locks after ''
Date: Fri, 26 May 2006 16:57:38 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 26 May 2006 14:57:39.0065 (UTC) FILETIME=[BB501E90:01C680D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyboby.
I have compiled 2.6.17-rc5 on an smp system and I get this
warning message during compilation (2.6.16.18 is fine):

[...]
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  HOSTCC  arch/i386/boot/tools/build
  BUILD   arch/i386/boot/bzImage
Root device is (8, 1)
Boot sector 512 bytes.
Setup is 4602 bytes.
System is 1337 kB
Kernel: arch/i386/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: 
from .smp_locks after '' (at offset 0x60)
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: 
from .smp_locks after '' (at offset 0x64)
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: 
from .smp_locks after '' (at offset 0x68)
  CC      crypto/blowfish.mod.o
  LD [M]  crypto/blowfish.ko
  CC      crypto/crc32c.mod.o
  LD [M]  crypto/crc32c.ko
  CC      crypto/serpent.mod.o
  LD [M]  crypto/serpent.ko
[...]


