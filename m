Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTBXQLA>; Mon, 24 Feb 2003 11:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBXQLA>; Mon, 24 Feb 2003 11:11:00 -0500
Received: from mail.permas.de ([195.143.204.226]:2721 "EHLO netserv.local")
	by vger.kernel.org with ESMTP id <S267268AbTBXQK6>;
	Mon, 24 Feb 2003 11:10:58 -0500
From: Hartmut Manz <manz@intes.de>
Organization: INTES GmbH
To: linux-kernel@vger.kernel.org
Subject: INTEL SCSI-Controler (gdth) does not compile on LINUX 2.5.62
Date: Mon, 24 Feb 2003 17:21:10 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302241721.10321.manz@intes.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to run linux.2.5.62 on one of my machines.

The machine is a Dual-Xeon System with a 4-way striped filesystem on an INTEL SCSI-controler.
So I need the following option in .config
CONFIG_SCSI_GDTH=y

With Linux 2.4.20 all is ok, but while compile linux-2.5.62 I got the following messages.

gcc -Wp,-MD,drivers/scsi/.gdth.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=gdth -DKBUILD_MODNAME=gdth -c -o drivers/scsi/.tmp_gdth.o drivers/scsi/gdth.c
In file included from drivers/scsi/gdth.c:719:
drivers/scsi/gdth_proc.c: In function `gdth_do_cmd':
drivers/scsi/gdth_proc.c:1269: request for member `rq_status' in something not a structure or union
drivers/scsi/gdth_proc.c:1271: request for member `waiting' in something not a structure or union
drivers/scsi/gdth_proc.c:1272: warning: implicit declaration of function `scsi_do_cmd'
drivers/scsi/gdth_proc.c: In function `gdth_scsi_done':
drivers/scsi/gdth_proc.c:1291: request for member `rq_status' in something not a structure or union
drivers/scsi/gdth_proc.c:1294: request for member `waiting' in something not a structure or union
drivers/scsi/gdth_proc.c:1295: request for member `waiting' in something not a structure or union
In file included from drivers/scsi/gdth.c:719:
drivers/scsi/gdth_proc.c:1393:38: macro "GDTH_LOCK_SCSI_DONE" requires 2 arguments, but only 1 given
In file included from drivers/scsi/gdth.c:719:
drivers/scsi/gdth_proc.c: In function `gdth_wait_completion':
drivers/scsi/gdth_proc.c:1393: `GDTH_LOCK_SCSI_DONE' undeclared (first use in this function)
drivers/scsi/gdth_proc.c:1393: (Each undeclared identifier is reported only once
drivers/scsi/gdth_proc.c:1393: for each function it appears in.)
drivers/scsi/gdth_proc.c:1395: `dev' undeclared (first use in this function)
drivers/scsi/gdth.c: In function `gdth_copy_internal_data':
drivers/scsi/gdth.c:2664: structure has no member named `address'
drivers/scsi/gdth.c:2664: structure has no member named `address'
drivers/scsi/gdth.c: In function `gdth_fill_cache_cmd':
drivers/scsi/gdth.c:2839: structure has no member named `address'
drivers/scsi/gdth.c: In function `gdth_fill_raw_cmd':
drivers/scsi/gdth.c:2956: structure has no member named `address'
drivers/scsi/gdth.c:3377:46: macro "GDTH_UNLOCK_SCSI_DONE" passed 2 arguments, but takes just 1
drivers/scsi/gdth.c: In function `gdth_interrupt':
drivers/scsi/gdth.c:3377: `GDTH_UNLOCK_SCSI_DONE' undeclared (first use in this function)
drivers/scsi/gdth.c: At top level:
drivers/scsi/gdth.c:4762: warning: initialization from incompatible pointer type
drivers/scsi/gdth.c:4762: warning: initialization from incompatible pointer type
drivers/scsi/gdth.c:823: warning: `gdthtable' defined but not used
make[2]: *** [drivers/scsi/gdth.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


What can I do?

Thanks for any help

Hartmut Manz

-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
   Ein Mensch sieht, was vor Augen ist; der Herr aber sieht das Herz an.
------------------------------------------------------- 1. Samuel 16, 7 -----

