Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbSI2V51>; Sun, 29 Sep 2002 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSI2V51>; Sun, 29 Sep 2002 17:57:27 -0400
Received: from bazooka.saturnus.vein.hu ([193.6.40.77]:28800 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S261840AbSI2V50>; Sun, 29 Sep 2002 17:57:26 -0400
Date: Sun, 29 Sep 2002 23:59:56 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.39 problem in slab.c
Message-ID: <20020929215956.GA557@bazooka.saturnus.vein.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Banai Zoltan <bazooka@vekoll.vein.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed a problem with 2.5.39 in slab.c:
I got a bounch of messages:

Sleeping function called from illegal context at slab.c:1374
c1571f20 c0114e74 c03751c0 c037993b 0000055e 000001d0 c012eed0 c037993b
	0000055e e0800000 00000246 00001000 00001000 c012df1d 0000001c 000001d0
	c1570000 00000246 00001000 000001d2 dfc37288 c012e1ce 00001000 00000002
Call Trace:
 [<c0114e74>]__might_sleep+0x54/0x60
 [<c012eed0>]kmalloc+0x4c/0x130
 [<c012df1d>]get_vm_area+0x29/0x104
 [<c012e1ce>]__vmalloc+0x32/0x10c
 [<c012e2bd>]vmalloc+0x15/0x1c
 [<c02accac>]sg_init+0x80/0x100
 [<c0284555>]scsi_register_device+0x71/0x114
 [<c010508b>]init+0x33/0x188
 [<c0105058>]init+0x0/0x188
 [<c01054c9>]kernel_thread_helper+0x5/0xc

The full syslog , lspci, and kernel config can be found in:
http://www.elma.hu/bazooka/

This is an Intel D850MV motherboard.

Regards,
-- 
Banai Zoltan
