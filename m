Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJFWmK>; Sun, 6 Oct 2002 18:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSJFWmK>; Sun, 6 Oct 2002 18:42:10 -0400
Received: from nl-ams-slo-l4-02-pip-7.chellonetwork.com ([213.46.243.26]:2895
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262239AbSJFWmJ>; Sun, 6 Oct 2002 18:42:09 -0400
Subject: sleeping function called from illegal context at mm/slab.c
From: Harm Verhagen <h.verhagen@chello.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-4) 
Date: 07 Oct 2002 00:47:13 +0200
Message-Id: <1033944433.2476.12.camel@pchome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Booting into 2.5.40 (upto changeset 1.754) I found this in my logs:


Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c01149e2>] E __might_sleep_Rd533bec7+0x52/0x2d3ad8
 [<c012ed26>] E kmem_cache_alloc_R75810956+0x26/0x1f0
 [<c025b130>] E blk_cleanup_queue_R636ccdc9+0xc0/0xffffef10
 [<c025b1cc>] E blk_init_queue_Rdd9e8f76+0xc/0xff0
 [<c02707a8>] E save_match_Rc7b80eda+0x88/0xd0
 [<c0276ba0>] E ide_get_queue_R25e55f1a+0x30/0x50
 [<c0270a60>] E init_irq_R37cd73eb+0x270/0x320
 [<c0270de6>] E hwif_init_R8f957a5d+0x106/0x240
 [<c02706cc>] E probe_hwif_init_Rb374e6b6+0x1c/0x70
 [<c0280b59>] E ide_setup_pci_device_R2e268a7e+0x39/0x60
 [<c026f733>] E unregister_netdev_Rff4fb597+0x2ae3/0x3740
 [<c0105098>] E Using_Versions+0xc0105097/0xc011728f
 [<c0105060>] E Using_Versions+0xc010505f/0xc011728f
 [<c01054d9>] E enable_hlt_R9c7077bd+0x1c9/0x16960

I hope this is usefull info...

please CC me if you have questions as I'm not subscribed.

Kind regards,
Harm Verhagen



