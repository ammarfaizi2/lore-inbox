Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbTBKRqx>; Tue, 11 Feb 2003 12:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267910AbTBKRqx>; Tue, 11 Feb 2003 12:46:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267911AbTBKRqv>;
	Tue, 11 Feb 2003 12:46:51 -0500
Date: Tue, 11 Feb 2003 09:54:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiler Error : 2.5.60
Message-Id: <20030211095401.6d3f0dd1.rddunlap@osdl.org>
In-Reply-To: <3E4936CD.208@cox.net>
References: <3E4936CD.208@cox.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 11:45:49 -0600
David van Hoose <davidvh@cox.net> wrote:

| Attached is stripped config. (I remembered this time)
| Below is the error.
| 
| make -f scripts/Makefile.build obj=drivers/scsi
|    gcc -Wp,-MD,drivers/scsi/.ppa.o.d -D__KERNEL__ -Iinclude -Wall 
| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
| -pipe -mpreferred-stack-boundary=2 -march=pentium4 
| -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include 
| -DKBUILD_BASENAME=ppa -DKBUILD_MODNAME=ppa -c -o drivers/scsi/ppa.o 
| drivers/scsi/ppa.c
| drivers/scsi/ppa.c: In function `ppa_detect':
| drivers/scsi/ppa.c:151: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_send_command':
| drivers/scsi/ppa.c:638: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_completion':
| drivers/scsi/ppa.c:664: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_command':
| drivers/scsi/ppa.c:755: structure has no member named `host'
| drivers/scsi/ppa.c:777: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_interrupt':
| drivers/scsi/ppa.c:839: structure has no member named `host'
| drivers/scsi/ppa.c:841: structure has no member named `host'
| drivers/scsi/ppa.c:845: structure has no member named `host'
| drivers/scsi/ppa.c:847: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_engine':
| drivers/scsi/ppa.c:853: structure has no member named `host'
| drivers/scsi/ppa.c:903: structure has no member named `target'
| drivers/scsi/ppa.c: In function `ppa_queuecommand':
| drivers/scsi/ppa.c:969: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_abort':
| drivers/scsi/ppa.c:1014: structure has no member named `host'
| drivers/scsi/ppa.c: In function `ppa_reset':
| drivers/scsi/ppa.c:1042: structure has no member named `host'
| make[2]: *** [drivers/scsi/ppa.o] Error 1
| make[1]: *** [drivers/scsi] Error 2
| make: *** [drivers] Error 2

Yes, Mike Anderson posted a patch for this earlier today.
See the "scsi/imm.c compile errors" thread for it.

--
~Randy
