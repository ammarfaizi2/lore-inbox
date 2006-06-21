Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWFUST4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWFUST4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFUST4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:19:56 -0400
Received: from dvhart.com ([64.146.134.43]:27041 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751158AbWFUST4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:19:56 -0400
Message-ID: <44998DCB.1030703@mbligh.org>
Date: Wed, 21 Jun 2006 11:19:55 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hpa@zytor.com
Subject: Re: 2.6.17-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to dive into an endless loop in compile.

http://test.kernel.org/abat/37068/debug/test.log.0

   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   CC      init/initramfs.o
   CC      init/calibrate.o
   LD      init/built-in.o
   HOSTCC  usr/gen_init_cpio
   SYMLINK usr/include/asm -> include/asm-x86_64
   GEN     usr/klibc/syscalls/SYSCALLS.i
   GEN     usr/klibc/syscalls/syscalls.nrs
   GEN     usr/klibc/syscalls/typesize.c
   KLIBCCC usr/klibc/syscalls/typesize.o
   OBJCOPY usr/klibc/syscalls/typesize.bin
   GEN     usr/klibc/syscalls/syscalls.mk
   GEN     usr/klibc/syscalls/typesize.c
   KLIBCCC usr/klibc/syscalls/typesize.o
   OBJCOPY usr/klibc/syscalls/typesize.bin
   GEN     usr/klibc/syscalls/syscalls.mk
   GEN     usr/klibc/syscalls/typesize.c
   KLIBCCC usr/klibc/syscalls/typesize.o
   OBJCOPY usr/klibc/syscalls/typesize.bin
   GEN     usr/klibc/syscalls/syscalls.mk
   GEN     usr/klibc/syscalls/typesize.c
   KLIBCCC usr/klibc/syscalls/typesize.o
   OBJCOPY usr/klibc/syscalls/typesize.bin
   GEN     usr/klibc/syscalls/syscalls.mk
   GEN     usr/klibc/syscalls/typesize.c
   KLIBCCC usr/klibc/syscalls/typesize.o
   OBJCOPY usr/klibc/syscalls/typesize.bin
   GEN     usr/klibc/syscalls/syscalls.mk

etc etc. for ever.

On both x86_64 and ppc64.

M.


