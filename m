Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVB1MHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVB1MHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 07:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVB1MHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 07:07:24 -0500
Received: from pop.gmx.net ([213.165.64.20]:57258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261311AbVB1MHM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 07:07:12 -0500
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swapper: page allocation failure. order:1, mode:0x20
Date: Mon, 28 Feb 2005 13:07:13 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502281307.13629.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh no, not this page allocation problems again. In summer I already posted 
problems with page allocation errors with 2.6.7, but to me it seemed that 
nobody cared. That time we got those problems every morning during the cron 
jobs and our main file server always completely crashed.
This time its our cluster master system and first happend after an uptime 
of 89 days, kernel is 2.6.9. Besides of those messages, the system still 
seems to run stable

I really beg for help here, so please please please help me solving this 
probem. What can I do to solve it?

First a (dumb) question, what does 'page allocation failure' really mean? 
Is it some out of memory case?


Thanks a lot in advance for any help,
 Bernd





Feb 28 10:04:45 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
Feb 28 10:04:45 hitchcock kernel:
Feb 28 10:04:45 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff803d064a>{ip_frag_create+26}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff8016061e>{cache_grow+190} <ffffffff80160e80>{cache_alloc_refill+560}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff801617e3>{__kmalloc+195} <ffffffff803b5680>{alloc_skb+64}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff8031727e>{tg3_alloc_rx_skb+222} <ffffffff80317553>{tg3_rx+371}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff80317977>{tg3_poll+183} <ffffffff803bc306>{net_rx_action+134}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff8013d0ab>{__do_softirq+123} <ffffffff8013d162>{do_softirq+50}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff801140ab>{do_IRQ+347} <ffffffff801114eb>{ret_from_intr+0}
Feb 28 10:04:45 hitchcock kernel:         <EOI> <ffffffff8010f070>{default_idle+0} <ffffffff8010f094>{default_idle+36}
Feb 28 10:04:45 hitchcock kernel:        <ffffffff8010f147>{cpu_idle+39}
Feb 28 10:05:41 hitchcock rpc.mountd: authenticated unmount request from beo-04:666 for /lib64 (/lib64)
Feb 28 10:04:45 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
Feb 28 10:07:36 hitchcock kernel:
Feb 28 10:07:36 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff8016061e>{cache_grow+190}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff80160e80>{cache_alloc_refill+560} <ffffffff801617e3>{__kmalloc+195}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff803b5680>{alloc_skb+64} <ffffffff8031727e>{tg3_alloc_rx_skb+222}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff80317553>{tg3_rx+371} <ffffffff80317977>{tg3_poll+183}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff803bc306>{net_rx_action+134} <ffffffff8013d0ab>{__do_softirq+123}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff8013d162>{do_softirq+50} <ffffffff801140ab>{do_IRQ+347}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff801114eb>{ret_from_intr+0}  <EOI> <ffffffff8010f070>{default_idle+0}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff8010f094>{default_idle+36} <ffffffff8010f147>{cpu_idle+39}
Feb 28 10:07:36 hitchcock kernel:
Feb 28 10:07:36 hitchcock kernel: swapper: page allocation failure. order:1, mode:0x20
Feb 28 10:07:36 hitchcock kernel:
Feb 28 10:07:36 hitchcock kernel: Call Trace:<IRQ> <ffffffff8015b0de>{__alloc_pages+878} <ffffffff8015b10e>{__get_free_pages+14}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff8015edc6>{kmem_getpages+38} <ffffffff8016061e>{cache_grow+190}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff80160e80>{cache_alloc_refill+560} <ffffffff801617e3>{__kmalloc+195}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff803b5680>{alloc_skb+64} <ffffffff8031727e>{tg3_alloc_rx_skb+222}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff80317553>{tg3_rx+371} <ffffffff80317977>{tg3_poll+183}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff803bc306>{net_rx_action+134} <ffffffff8013d0ab>{__do_softirq+123}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff8013d162>{do_softirq+50} <ffffffff801140ab>{do_IRQ+347}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff801114eb>{ret_from_intr+0}  <EOI> <ffffffff8010f070>{default_idle+0}
Feb 28 10:07:36 hitchcock kernel:        <ffffffff8010f094>{default_idle+36} <ffffffff8010f147>{cpu_idle+39}


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
