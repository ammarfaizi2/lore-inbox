Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTEEQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTEEQ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:26:49 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37826 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263654AbTEEQZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:25:09 -0400
Date: Mon, 05 May 2003 09:37:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 663] New: "make modules" causes an error in mwavedd.h.
Message-ID: <10610000.1052152626@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=663

           Summary: "make modules" causes an error in mwavedd.h.
    Kernel Version: 2.5.69
            Status: NEW
          Severity: blocking
             Owner: jgarzik@pobox.com
         Submitter: mdfairch@sfu.ca


Distribution:  Redhat 9
Hardware Environment:
Athlon 800 on a Gigabyte 7ZX
384 megs PC100 RAM
Ensoniq 1371 sound card
NV25 video card

Software Environment:
GCC gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Using Kernel 2.4.20-9
Problem Description:

Steps to reproduce:
1) Setup kernel 2.4.20-9 build environment.
2) execute "make oldconfig", using default options throughout.
3) execute "make bzImage"
4) execute "make modules"

Make produces the following error message:
  gcc -Wp,-MD,drivers/char/mwave/.smapi.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
include -DMODULE -DMW_TRACE  -DKBUILD_BASENAME=smapi -DKBUILD_MODNAME=mwave
-c -o
drivers/char/mwave/.tmp_smapi.o drivers/char/mwave/smapi.c
In file included from drivers/char/mwave/smapi.c:53:
drivers/char/mwave/mwavedd.h:129: parse error before "wait_queue_head_t"
drivers/char/mwave/mwavedd.h:129: warning: no semicolon at end of struct or
union drivers/char/mwave/mwavedd.h:130: warning: type defaults to `int' in
declaration of `MWAVE_IPC'
drivers/char/mwave/mwavedd.h:130: warning: data definition has no type or
storage class
drivers/char/mwave/mwavedd.h:140: parse error before "MWAVE_IPC"
drivers/char/mwave/mwavedd.h:140: warning: no semicolon at end of struct or
union drivers/char/mwave/mwavedd.h:146: parse error before '}' token
drivers/char/mwave/mwavedd.h:146: warning: type defaults to `int' in
declaration of `MWAVE_DEVICE_DATA'
drivers/char/mwave/mwavedd.h:146: warning: type defaults to `int' in
declaration of `pMWAVE_DEVICE_DATA'
drivers/char/mwave/mwavedd.h:146: warning: data definition has no type or
storage class
make[3]: *** [drivers/char/mwave/smapi.o] Error 1

Incidentally, this is my first ever bug report regarding the Kernel -- I
have never built the kernel from a non-distribution supplied source.
Hopefully I haven't just bothered everyone!


