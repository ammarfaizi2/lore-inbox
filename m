Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSJAV14>; Tue, 1 Oct 2002 17:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbSJAV14>; Tue, 1 Oct 2002 17:27:56 -0400
Received: from members.cotse.com ([216.112.42.58]:63690 "EHLO cotse.com")
	by vger.kernel.org with ESMTP id <S262876AbSJAV1y>;
	Tue, 1 Oct 2002 17:27:54 -0400
Message-ID: <YWxhbg==.fd03f4146997486bd21c6f82fe8313f0@1033508031.cotse.net>
Date: Tue, 1 Oct 2002 17:33:51 -0400 (EDT)
X-Abuse-To: abuse@cotse.com
X-AntiForge: http://packetderm.cotse.com/antiforge.php
Subject: possible bug report
From: "Alan Willis" <alan@cotse.net>
To: <linux-kernel@vger.kernel.org>
Reply-To: alan@cotse.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I still get this error with 2.5.40. This is with the workqueue patch
applied, however, I get it even with a vanilla 2.5.40.  It should be noted
that since kernel.org has been down, I used a patch, instead of the full
kernel source, so perhaps something is wrong with the patch instead.

-alan at cotse


alan@aries:~$ uname -a
Linux aries 2.5.40 #4 Tue Oct 1 05:32:10 PDT 2002 i686 GenuineIntel


Debug: sleeping function called from illegal context at slab.c:1374
c12bdea4 c01125c4 c0279ac0 c027ddb0 0000055e 00000000 c012c023 c027ddb0
       0000055e c038cecc c038ce94 cfd45380 00000000 c01fde40 cfe72ec0
       000001d0       c038ce94 c038ce84 cfd45380 00000000 00000000 c01fded1 c038ce94
       c038ce94Call Trace:
 [<c01125c4>]__might_sleep+0x54/0x60
 [<c012c023>]kmem_cache_alloc+0x23/0xf4
 [<c01fde40>]blk_init_free_list+0x4c/0xd0
 [<c01fded1>]blk_init_queue+0xd/0xe8
 [<c020b430>]ide_init_queue+0x28/0x68
 [<c0211834>]do_ide_request+0x0/0x18
 [<c020b708>]init_irq+0x298/0x354
 [<c020ba86>]hwif_init+0x112/0x258
 [<c020b35c>]probe_hwif_init+0x1c/0x6c
 [<c021b4b1>]ide_setup_pci_device+0x61/0x68
 [<c0105086>]init+0x2e/0x188
 [<c0105058>]init+0x0/0x188
 [<c01054c9>]kernel_thread_helper+0x5/0xc




