Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265511AbSJSEnf>; Sat, 19 Oct 2002 00:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265512AbSJSEnf>; Sat, 19 Oct 2002 00:43:35 -0400
Received: from adsl-66-125-254-44.dsl.sntc01.pacbell.net ([66.125.254.44]:3485
	"EHLO fiorano.interclypse.net") by vger.kernel.org with ESMTP
	id <S265511AbSJSEne>; Sat, 19 Oct 2002 00:43:34 -0400
Subject: 3COM 3C990 NIC
From: Christopher Keller <cnkeller@interclypse.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 21:49:36 -0700
Message-Id: <1035002976.3086.4.camel@maranello.interclypse.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone maintaining the 3C990 driver? I'm using the code from 3COM and
it doesn't look like it's been kept up to date with the various kernel
changes. I'm also using the latest Red Hat kernel in case it matters. 

When compiling with SMP support, I'm getting the following errors during
a depmod -ae

depmod: *** Unresolved symbols in
/lib/modules/2.4.18-17.8.0smp/kernel/drivers/net/3c990.o
depmod:         pci_write_config_byte
depmod:         eth_type_trans
depmod:         __wake_up
depmod:         __kfree_skb
depmod:         alloc_skb
depmod:         init_etherdev
depmod:         kmalloc
depmod:         pci_free_consistent
depmod:         pci_find_class
depmod:         pci_read_config_byte
depmod:         cpu_raise_softirq
depmod:         free_irq
depmod:         unregister_netdev
depmod:         __out_of_line_bug
depmod:         iounmap
depmod:         pci_alloc_consistent
depmod:         interruptible_sleep_on_timeout
depmod:         __ioremap
depmod:         pci_read_config_word
depmod:         kfree
depmod:         request_irq
depmod:         netif_rx
depmod:         skb_over_panic
depmod:         jiffies
depmod:         softnet_data
depmod:         printk
depmod:         __const_udelay

I get no problems in the single processor compile & depmod. Can these be
safely ignored? The SMP #define simply includes the spinlock stuff.

#ifdef SMP
#include <linux/spinlock.h>
#endif
-- 
Homepage: http://interclypse.net
Registered Linux user #215241 (http://counter.li.org/)

