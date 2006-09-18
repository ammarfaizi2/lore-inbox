Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWIRUgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWIRUgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWIRUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:36:22 -0400
Received: from smtp1.iitb.ac.in ([202.68.145.249]:37018 "HELO smtp1.iitb.ac.in")
	by vger.kernel.org with SMTP id S964943AbWIRUgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:36:21 -0400
Message-ID: <450F0515.3040002@it.iitb.ac.in>
Date: Tue, 19 Sep 2006 02:14:05 +0530
From: Anuj Tripathi <anujt@it.iitb.ac.in>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems in compiling the module "/net/ieee80211"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am trying to compile the kernel source code of .c files in 
/linux-2.6.17.11/net/ieee80211 in  a standalone manner. My aim is to 
profile these files, especially the security functions, and to find the 
bottlenecks in the implementation and then to fine tune it.

While compiling them as

 gcc -D__KERNEL__ -I ../../kernel2/linux-2.6.17.11/include ieee80211_crypt.c

I initially got error with KBUILD but was able to remove it. Now 
following are the errors I am getting.


In file included from ../../kernel2/linux-2.6.17.11/include/asm/smp.h:18,
                 from ../../kernel2/linux-2.6.17.11/include/linux/smp.h:19,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/sched.h:26,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/module.h:12,
                 from ieee80211_crypt.c:15:
../../kernel2/linux-2.6.17.11/include/asm/mpspec.h:6:25: error: 
mach_mpspec.h: No such file or directory
In file included from ../../kernel2/linux-2.6.17.11/include/asm/smp.h:18,
                 from ../../kernel2/linux-2.6.17.11/include/linux/smp.h:19,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/sched.h:26,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/module.h:12,
                 from ieee80211_crypt.c:15:
../../kernel2/linux-2.6.17.11/include/asm/mpspec.h:8: error: 
'MAX_MP_BUSSES' undeclared here (not in a function)
../../kernel2/linux-2.6.17.11/include/asm/mpspec.h:22: error: 
'MAX_IRQ_SOURCES' undeclared here (not in a function)
In file included from ../../kernel2/linux-2.6.17.11/include/linux/smp.h:19,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/sched.h:26,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/module.h:12,
                 from ieee80211_crypt.c:15:
../../kernel2/linux-2.6.17.11/include/asm/smp.h:77:26: error: 
mach_apicdef.h: No such file or directory
In file included from ../../kernel2/linux-2.6.17.11/include/linux/irq.h:22,
                 from ../../kernel2/linux-2.6.17.11/include/asm/hardirq.h:6,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/hardirq.h:7,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/interrupt.h:11,
                 from 
../../kernel2/linux-2.6.17.11/include/asm/highmem.h:24,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/highmem.h:24,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/skbuff.h:27,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/if_ether.h:111,
                 from 
../../kernel2/linux-2.6.17.11/include/net/ieee80211.h:28,
                 from ieee80211_crypt.c:19:
../../kernel2/linux-2.6.17.11/include/asm/irq.h:16:25: error: 
irq_vectors.h: No such file or directory
In file included from ../../kernel2/linux-2.6.17.11/include/asm/hardirq.h:6,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/hardirq.h:7,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/interrupt.h:11,
                 from 
../../kernel2/linux-2.6.17.11/include/asm/highmem.h:24,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/highmem.h:24,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/skbuff.h:27,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/if_ether.h:111,
                 from 
../../kernel2/linux-2.6.17.11/include/net/ieee80211.h:28,
                 from ieee80211_crypt.c:19:
../../kernel2/linux-2.6.17.11/include/linux/irq.h:85: error: 'NR_IRQS' 
undeclared here (not in a function)
In file included from ../../kernel2/linux-2.6.17.11/include/linux/irq.h:94,
                 from ../../kernel2/linux-2.6.17.11/include/asm/hardirq.h:6,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/hardirq.h:7,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/interrupt.h:11,
                 from 
../../kernel2/linux-2.6.17.11/include/asm/highmem.h:24,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/highmem.h:24,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/skbuff.h:27,
                 from 
../../kernel2/linux-2.6.17.11/include/linux/if_ether.h:111,
                 from 
../../kernel2/linux-2.6.17.11/include/net/ieee80211.h:28,
                 from ieee80211_crypt.c:19:
../../kernel2/linux-2.6.17.11/include/asm/hw_irq.h:30: error: 
'NR_IRQ_VECTORS' undeclared here (not in a function)
In file included from 
../../kernel2/linux-2.6.17.11/include/linux/if_ether.h:111,
                 from 
../../kernel2/linux-2.6.17.11/include/net/ieee80211.h:28,
                 from ieee80211_crypt.c:19:
../../kernel2/linux-2.6.17.11/include/linux/skbuff.h: In function 
'skb_add_data':
../../kernel2/linux-2.6.17.11/include/linux/skbuff.h:1140: warning: 
pointer targets in passing argument 1 of 'csum_and_copy_from_user' 
differ in signedness


can someone tell me how can i get over with these errors ? Moreover is 
there any other way of profiling the specific module (/net/ieee802.11) 
through which i can find out the bottleneck ???

ThanX
-Anuj Tripathi
Mtech 05, IIT Bombay


