Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUJIGkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUJIGkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUJIGkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:40:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49835 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266572AbUJIGkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 02:40:49 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
In-Reply-To: <41677E4D.1030403@mvista.com>
References: <41677E4D.1030403@mvista.com>
Content-Type: text/plain
Message-Id: <1097304045.1442.166.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 02:40:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 01:59, Sven-Thorsten Dietrich wrote:
> Announcing the availability of prototype real-time (RT)
> enhancements to the Linux 2.6 kernel.
> 

Does not compile:

  CC      arch/i386/kernel/semaphore.o
  CC      arch/i386/kernel/signal.o
  AS      arch/i386/kernel/entry.o
  CC      arch/i386/kernel/traps.o
  CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c: In function `do_IRQ':
arch/i386/kernel/irq.c:582: error: too many arguments to function `note_interrupt'
arch/i386/kernel/irq.c:667: warning: ISO C90 forbids mixed declarations and code
arch/i386/kernel/irq.c:751: error: initializer element is not constant
arch/i386/kernel/irq.c:751: error: (near initialization for `__ksymtab_request_irq.value')
arch/i386/kernel/irq.c:809: error: initializer element is not constant
arch/i386/kernel/irq.c:809: error: (near initialization for `__ksymtab_free_irq.value')
arch/i386/kernel/irq.c:904: error: initializer element is not constant
arch/i386/kernel/irq.c:904: error: (near initialization for `__ksymtab_probe_irq_on.value')
arch/i386/kernel/irq.c:1004: error: initializer element is not constant
arch/i386/kernel/irq.c:1004: error: (near initialization for `__ksymtab_probe_irq_off.value')
arch/i386/kernel/irq.c:1246: error: initializer element is not constant
arch/i386/kernel/irq.c:1246: error: (near initialization for `__ksymtab_do_softirq.value')
arch/i386/kernel/irq.c:1246: error: parse error at end of input
arch/i386/kernel/irq.c:648: warning: label `out_no_end' defined but not used
arch/i386/kernel/irq.c:79: warning: 'register_irq_proc' declared `static' but never defined
arch/i386/kernel/irq.c:277: warning: 'report_bad_irq' defined but not used
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2

I am using gcc 3.4.  I accepted all the default settings except I
enabled "Run all IRQS in threads".

Lee

