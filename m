Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWDHXfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWDHXfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 19:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWDHXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 19:35:25 -0400
Received: from xenotime.net ([66.160.160.81]:52961 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751441AbWDHXfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 19:35:24 -0400
Date: Sat, 8 Apr 2006 16:37:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "George P Nychis" <gnychis@cmu.edu>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.4.32: unresolved symbol unregister_qdisc
Message-Id: <20060408163743.c59d6e59.rdunlap@xenotime.net>
In-Reply-To: <33083.128.2.140.234.1144538327.squirrel@128.2.140.234>
References: <32947.128.2.140.234.1144536454.squirrel@128.2.140.234>
	<20060408.155430.111013393.davem@davemloft.net>
	<33083.128.2.140.234.1144538327.squirrel@128.2.140.234>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Apr 2006 19:18:47 -0400 (EDT) George P Nychis wrote:

> Yeah, this module is unfortunately not under the GPL, it was made for research and i am not the author, I was only given the code for my own research.
> 
> I enabled that support in the kernel, and then tried to recompile and get tons of errors/warnings... so maybe I am missing something else to be enabled in the kernel... here are a few examples of errors:
> /usr/include/linux/skbuff.h:30:26: net/checksum.h: No such file or directory
> /usr/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory
> /usr/include/linux/irq.h:72: error: `NR_IRQS' undeclared here (not in a function)
> /usr/include/asm/hw_irq.h:28: error: `NR_IRQ_VECTORS' undeclared here (not in a function)
> 
> I think those are the top most errors, so if i can fix those hopefully the rest shall vanish!

Looks like a Makefile problem then.  Can you post the Makefile?
Hopefully it is using a Makefile and not just an elaborate gcc command line.

[and please don't top-post]

> - George
> 
> 
> > From: "George P Nychis" <gnychis@cmu.edu> Date: Sat, 8 Apr 2006 18:47:34
> > -0400 (EDT)
> > 
> >> Hey,
> >> 
> >> I have a kernel module that uses unregister_qdisc and register_qdisc,
> >> whenever i try to insert the module I get: 
> >> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o:
> >> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol
> >> unregister_qdisc /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o:
> >> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol
> >> register_qdisc
> >> 
> >> Am i missing some sort of support in the kernel?
> > 
> > Make sure CONFIG_NET_SCHED is enabled and that you compiled your module
> > against that kernel.
> > 
> > Where does this sch_xcp come from?  It's not in the vanilla sources.
> > 
> > Also, please direct networking questions to the netdev@vger.kernel.org 
> > mailing list which I have added to the CC:.

---
~Randy
