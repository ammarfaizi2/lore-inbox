Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbTDKH1K (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTDKH1J (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:27:09 -0400
Received: from web20106.mail.yahoo.com ([216.136.226.43]:4494 "HELO
	web20106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264306AbTDKH1F (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 03:27:05 -0400
Message-ID: <20030411073848.33517.qmail@web20106.mail.yahoo.com>
Date: Fri, 11 Apr 2003 00:38:48 -0700 (PDT)
From: Alisha Nigam <mail_to_alisha@yahoo.com>
Subject: TCP/IP stack related prob.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
  i was trying to write a module for printing 
the destination header of packets comming to my
machine.

#include<linux/module.h>
#include<linux/skbuff.h>
#define MODULE
#define __KERNEL__
int init_module(struct sk_buff *skb)
 {printk("Destination Addr:%s.\n",skb->nh.iph->daddr);
         kfree_skb(skb);
            return 0;
}

void cleanup_module(void)
   { printk(" Module is removed succesfully\n");
   }
 then compile it 
  gcc -c -O -W -Wall -Wstrict-prototypes
-Wmissing-prototypes -DMODULE -D__KERNEL__ -mymodule.o
mymodule.c 


   i am getting a bundle of errors ...... 


In file included from /usr/include/linux/fs.h:23,
                 from
/usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from /usr/include/linux/skbuff.h:19,
                 from p10.c:2:
/usr/include/linux/string.h:8:2: warning: #warning
Using kernel header in userland!
In file included from /usr/include/linux/sched.h:14,
                 from /usr/include/linux/skbuff.h:19,
                 from p10.c:2:
/usr/include/linux/timex.h:173: field `time' has
incomplete type
In file included from /usr/include/linux/bitops.h:69,
                 from /usr/include/asm/system.h:7,
                 from /usr/include/linux/sched.h:16,
                 from /usr/include/linux/skbuff.h:19,
                 from p10.c:2:
/usr/include/asm/bitops.h:333:2: warning: #warning
This includefile is not available on all
architectures.
/usr/include/asm/bitops.h:334:2: warning: #warning
Using kernel headers in userspace. 
In file included from /usr/include/linux/signal.h:4,
                 from /usr/include/linux/sched.h:25,
                 from /usr/include/linux/skbuff.h:19,
                 from p10.c:2:
/usr/include/asm/signal.h:107: parse error before
"sigset_t"
/usr/include/asm/signal.h:110: parse error before '}'
token
In file included from /usr/include/linux/sched.h:81,
                 from /usr/include/linux/skbuff.h:19,
                 from p10.c:2:
/usr/include/linux/timer.h:45: parse error before
"spinlock_t"
/usr/include/linux/timer.h:53: parse error before '}'
token
/usr/include/linux/timer.h:67: parse error before
"tvec_base_t"
/usr/include/linux/timer.h:101: parse error before
"tvec_bases"
/usr/include/linux/timer.h: In function `init_timer':
/usr/include/linux/timer.h:105: dereferencing pointer
to incomplete type
/usr/include/linux/timer.h:105: dereferencing pointer
to incomplete type
/usr/include/linux/timer.h:106: dereferencing pointer
to incomplete type
/usr/include/linux/timer.h: In function
`timer_pending':
/usr/include/linux/timer.h:121: dereferencing pointer
to incomplete type
In file included from /usr/include/linux/highmem.h:5,
                 from /usr/include/linux/skbuff.h:26,
                 from p10.c:2:
/usr/include/asm/pgalloc.h:6:24: asm/fixmap.h: No such
file or directory
In file included from /usr/include/linux/highmem.h:5,
                 from /usr/include/linux/skbuff.h:26,
                 from p10.c:2:
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:57: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`get_pgd_slow':
/usr/include/asm/pgalloc.h:59: `pgd_t' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h:59: (Each undeclared
identifier is reported only once
/usr/include/asm/pgalloc.h:59: for each function it
appears in.)
/usr/include/asm/pgalloc.h:59: `pgd' undeclared (first
use in this function)
/usr/include/asm/pgalloc.h:59: parse error before ')'
token
/usr/include/asm/pgalloc.h:62: `USER_PTRS_PER_PGD'
undeclared (first use in this function)
/usr/include/asm/pgalloc.h:63: `swapper_pg_dir'
undeclared (first use in this function)
/usr/include/asm/pgalloc.h:63: `PTRS_PER_PGD'
undeclared (first use in this function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:70: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`get_pgd_fast':
/usr/include/asm/pgalloc.h:80: `pgd_t' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h:80: parse error before ')'
token
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:83: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`free_pgd_fast':
/usr/include/asm/pgalloc.h:85: `pgd' undeclared (first
use in this function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:90: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`free_pgd_slow':
/usr/include/asm/pgalloc.h:99: `pgd' undeclared (first
use in this function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:103: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`pte_alloc_one':
/usr/include/asm/pgalloc.h:105: `pte_t' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h:105: `pte' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h:109: parse error before ')'
token
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:118: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`pte_alloc_one_fast':
/usr/include/asm/pgalloc.h:127: `pte_t' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h:127: parse error before ')'
token
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:130: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`pte_free_fast':
/usr/include/asm/pgalloc.h:132: `pte' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:137: parse error before '*'
token
/usr/include/asm/pgalloc.h: In function
`pte_free_slow':
/usr/include/asm/pgalloc.h:139: `pte' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h: In function
`flush_tlb_mm':
/usr/include/asm/pgalloc.h:183: `current' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h: In function
`flush_tlb_page':
/usr/include/asm/pgalloc.h:190: dereferencing pointer
to incomplete type
/usr/include/asm/pgalloc.h:190: `current' undeclared
(first use in this function)
/usr/include/asm/pgalloc.h: In function
`flush_tlb_range':
/usr/include/asm/pgalloc.h:197: `current' undeclared
(first use in this function)
In file included from p10.c:2:
/usr/include/linux/skbuff.h: At top level:
/usr/include/linux/skbuff.h:100: parse error before
"spinlock_t"
/usr/include/linux/skbuff.h:120: parse error before
"atomic_t"
/usr/include/linux/skbuff.h:124: parse error before
'}' token
/usr/include/linux/skbuff.h:183: parse error before
"atomic_t"
/usr/include/linux/skbuff.h:215: parse error before
'}' token
p10.c:3:1: warning: "MODULE" redefined
p10.c:1:1: warning: this is the location of the
previous definition
p10.c:4:1: warning: "__KERNEL__" redefined
p10.c:1:1: warning: this is the location of the
previous definition
p10.c:7: warning: no previous prototype for
`init_module'
p10.c: In function `init_module':
p10.c:7: warning: implicit declaration of function
`printk'
p10.c:7: dereferencing pointer to incomplete type
p10.c:8: warning: implicit declaration of function
`kfree_skb'
p10.c: At top level:
p10.c:12: warning: no previous prototype for
`cleanup_module'
/usr/include/linux/prefetch.h: In function `prefetch':
/usr/include/linux/prefetch.h:43: warning: unused
parameter `x'
/usr/include/linux/prefetch.h: In function
`prefetchw':
/usr/include/linux/prefetch.h:48: warning: unused
parameter `x'
/usr/include/asm/pgalloc.h: In function
`flush_tlb_range':
/usr/include/asm/pgalloc.h:195: warning: unused
parameter `start'
/usr/include/asm/pgalloc.h:195: warning: unused
parameter `end'
/usr/include/asm/pgalloc.h: In function
`flush_tlb_pgtables':
/usr/include/asm/pgalloc.h:233: warning: unused
parameter `mm'
/usr/include/asm/pgalloc.h:234: warning: unused
parameter `start'
/usr/include/asm/pgalloc.h:234: warning: unused
parameter `end'



  CAN ANY ONE HELP ME ???????????

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
