Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTJUCF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTJUCF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:05:28 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:55494 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262683AbTJUCFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:05:18 -0400
Message-ID: <20031021020513.90943.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "David Liontooth" <liontooth@post.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 20 Oct 2003 21:05:13 -0500
Subject: Re: [2.6.0-test-7] natsemi oops
X-Originating-Ip: 128.97.184.97
X-Originating-Server: ws1-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correction: I get the oops also when natsemi is compiled as a module. 
It is triggered not when the module is loaded, but when it is used 
the first time. Oops (some fragments below) followed by a total freeze;
nothing gets logged.

Is this a known problem? 

Is there a workaround?

Cheers,
David


----- Original Message -----
From: David Liontooth
Date: Mon, 20 Oct 2003 05:24:52 -0500
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test-7] natsemi oops

> 
> The 2.6.0-test-7 boots fine and works great -- until I plug
> in the ethernet cable. Within a second I get an oops and
> everything freezes. Booting with "acpi=off" makes no difference.
> If I boot with the ethernet cable plugged in, I get to the 
> login prompt, and it oopses within a second. If I time it right,
> I can log into the machine remotely for one second before it 
> oopses (so the natsemi driver is working). Very reproducible! 
> /proc/kmsg is empty. 
> 
> If I compile natsemi as a module, I don't get the oops. 
> However, now the driver is not working -- I can't ping out.
> Everything works fine in 2.5.69, which I've been running
> since early July.
> 
> Here's some of the oops, taken by hand:
> 
> Process swapper (pid: 0, threadinfo=c042a000 task c03a47a0)
> 
> Stack
> 
> Call trace:
> 
> ipxitf_auto_create
> ipx_rcv
> netif_receive_skb
> process_backlog
> net_rx_action
> do_softirq
> do_IRQ
> _stext
> common_interrupt
> acpi_processor_idle
> cpu_idle
> start_kernel
> unknown_bootoption
> 
> Kernel panic: Fatal exception in interrupt
> In interrupt handler -- not syncing
> 
> Configuration, lspci, and dmesg attached.
> 
> Cheers,
> David
> 
> 
> 
<< config-2.6.0-test7-3 >>
<< dmesg-2.6.0-test7-7 >>
<< lspci-2.6.0-test7 >>

-- 
__________________________________________________________
Sign-up for your own personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

