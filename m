Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWGDSZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWGDSZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWGDSZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:25:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6029 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932224AbWGDSZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:25:44 -0400
Message-Id: <200607041825.k64IPfq3011686@laptop11.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.17 on SPARC64 compile failure
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 04 Jul 2006 14:25:41 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 04 Jul 2006 14:25:42 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It fails since around June 19 with:

  CC      arch/sparc64/kernel/devices.o
In file included from include/linux/dma-mapping.h:27,
                 from include/asm/sbus.h:10,
                 from include/asm/dma.h:14,
                 from include/linux/bootmem.h:8,
                 from arch/sparc64/kernel/devices.c:14:
include/asm/dma-mapping.h: In function `dma_sync_single_range_for_cpu':
include/asm/dma-mapping.h:186: warning: implicit declaration of function `dma_sync_single_for_cpu'
include/asm/dma-mapping.h: In function `dma_sync_single_range_for_device':
include/asm/dma-mapping.h:195: warning: implicit declaration of function `dma_sync_single_for_device'
make[1]: *** [arch/sparc64/kernel/devices.o] Error 1
make: *** [arch/sparc64/kernel] Error 2

Looking in the offending file, the functions mentioned seem to be PCI-only,
and this SparcStation Ultra 1 has /no/ PCI at all (and thus, this is
configured out).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

