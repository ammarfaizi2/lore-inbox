Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271283AbTGWUG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271282AbTGWUG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:06:26 -0400
Received: from 66.83.182.2.nw.nuvox.net ([66.83.182.2]:28641 "EHLO
	secure.intgrp.com") by vger.kernel.org with ESMTP id S271284AbTGWUFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:05:38 -0400
Message-ID: <077a01c35157$d898c100$9100000a@intgrp.com>
From: "Eric Wood" <eric@interplas.com>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: RH 9 kernel compile error
Date: Wed, 23 Jul 2003 16:20:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the newbie question.
I'm trying some new megaraid drivers so I have to recompile.  For RH9, in
the /usr/src/linux-2.4/ directory, I used:

# cp configs/kernel-2.4.20-i686.config .config
# make rpm

During the recompile I get an error:
I have 2.4.20-18.9 and 2.4.20-6 installed and get the error for both
versions. Any ideas?
-eric wood



gcc -D_KERNEL_ -I/usr/src/redhat/BUILD/kernel-2.4.2018.9custom/include -Wall
 -
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomi
t-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -
iwithpre
fix include -DKBUILD_BASENAME=oprofile_stats  -c -o
../../../drivers/oprofile/oprofile_stats.o
../../../drivers/oprofile/oprofile_stats.c
../../../drivers/oprofile/oprofile_stats.c: In function
`oprofile_reset_stats':
../../../drivers/oprofile/oprofile_stats.c:25: warning: implicit declaration
of function `cpu_possible'
rm -f oprofile.o
ld -m elf_i386  -r -o oprofile.o init.o timer_int.o
../../../drivers/oprofile/oprof.o ../../../drivers/oprofile/cpu_buffer.o
../../../drivers/oprofile/buffer_sync.o
../../../drivers/oprofile/event_buffer.o
../../../drivers/oprofile/oprofile_files.o
../../../drivers/oprofile/oprofilefs.o
../../../drivers/oprofile/oprofile_stats.o
../../../drivers/oprofile/event_buffer.o(.text+0x0): In function
`dcookie_register':
> multiple definition of `dcookie_register'
../../../drivers/oprofile/buffer_sync.o(.text+0x0): first defined here
../../../drivers/oprofile/event_buffer.o(.text+0x10): In function
`dcookie_unregister':
> multiple definition of `dcookie_unregister'
../../../drivers/oprofile/buffer_sync.o(.text+0x10): first defined here
make[3]: *** [oprofile.o] Error 1

