Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbSI3R0k>; Mon, 30 Sep 2002 13:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSI3R0k>; Mon, 30 Sep 2002 13:26:40 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:2988 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S262345AbSI3R0k>; Mon, 30 Sep 2002 13:26:40 -0400
Subject: 2.5.37-bk2 maybe new traceback for $BLAH at slab.c:1374
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Sep 2002 11:27:52 -0600
Message-Id: <1033406872.32409.82.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the other init_irq() stuff just like many other people, but here's
one which I haven't seen reported yet.  Kernel is 2.5.39bk2.  I just got
this once on boot up.  This system is UP, IDE.

Debug: sleeping function called from illegal context at slab.c:1374
cc57bf74 cc57bf94 c013204b c02a89e1 0000055e cc57a000 cd0103e0 00000000
       cc57bfbc c010bb13 c12832e8 000001d0 c012b317 bffffb88 00000000 cc57a000
       00000000 00000004 bffffb28 c010781b 00000000 00000400 00000001 00000000
Call Trace:
 [<c013204b>]__kmem_cache_alloc+0x10b/0x110
 [<c010bb13>]sys_ioperm+0x83/0x150
 [<c012b317>]sys_munmap+0x57/0x80
 [<c010781b>]syscall_call+0x7/0xb


Steven



