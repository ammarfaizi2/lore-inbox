Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269728AbRHDAhA>; Fri, 3 Aug 2001 20:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269729AbRHDAgu>; Fri, 3 Aug 2001 20:36:50 -0400
Received: from jalon.able.es ([212.97.163.2]:50916 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S269728AbRHDAgp>;
	Fri, 3 Aug 2001 20:36:45 -0400
Date: Sat, 4 Aug 2001 02:42:44 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <laughing@shared-source.org>
Subject: tiny patch collection
Message-ID: <20010804024244.G21339@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I am always redoing the same work of updating patch offsets for new ac kernels, so
let them be public... Some are collected since time ago, if someone knows a better
version, please tell me. Sorry for not giving credits to authors, did not remember
to get them when collecting.

Look at:

http://phoebe.cps.unizar.es/~magallon/linux/2.4.7-ac5/

for following patches (order can be important for clean patching):

00-aic620-247ac
	AIC7xxx driver version 6.2.0 final
01-scsi-cleanup
	Dead scsi code removal.
10-use-once
	Use-once patch for ac (yet in Linus pre series but not in Alan's)
20-gcc3-1
	Make gcc3 happy (arch independent part). 'stolen' from Andrea with
	some additions
21-gcc3-2-x86
	Make gcc3 happy, asm-i386 part. I suppose other archs need similar patch.
22-gcc3-aic
	Make gcc3 happy about aic driver. Separate because I think maintainer
	will not like it.
23-gcc3-raid
	Make gcc3 happy about md_k.h. Same.
30-i2c
	I2C update from cvs code (ie, 2.6.0+) with changes to fit current kernel
	standards (ie, malloc.h <-> slab.h, #endif's and so on).
31-sensors
	LM-Sensors, same as above
80-pgtable-fast
	Why be slow by default (it is still useful, or can I drop it ??)
81-sc-pipe
	Single copy pipes (anybody remembered this??)
90-make
	Tiny changes to main Makefile to make install in /boot, do vga=6,
	and re-evaluate CC:=$(CC) for slow boxes.

There is also a 82-cpu-stat, but still does not patch cleanly on ac5. Anybody has
it ??

Well, if someone finds this usefull...

BTW, runnin ac4 built with gcc-3.0.1 without problems, and going to reboot with ac5.

By!!

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7-ac3 #1 SMP Mon Jul 30 16:39:36 CEST 2001 i686
