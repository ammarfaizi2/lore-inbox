Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291082AbSBYQBB>; Mon, 25 Feb 2002 11:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291148AbSBYQAn>; Mon, 25 Feb 2002 11:00:43 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:9130 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S291082AbSBYQAe>;
	Mon, 25 Feb 2002 11:00:34 -0500
Date: Mon, 25 Feb 2002 07:32:05 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, fernando@quatro.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <140880104.1014622324@[10.10.2.3]>
In-Reply-To: <20020225131923.GY13774@os.inf.tu-dresden.de>
In-Reply-To: <20020225131923.GY13774@os.inf.tu-dresden.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Furthermore it also doesn't work with a UP kernel with Local IO APIC
> support (CONFIG_X86_UP_IOAPIC). Without it does work. It reliably hangs in
> arch/i386/kernel/io_apic.c:check_timer (in 2.4.18-pre8-K3 about line 1510)
>
>         printk(KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n",
> vector, pin1, pin2);
>
>         if (pin1 != -1) {
>                 /*
>                  * Ok, does IRQ0 through the IOAPIC work?
>                  */
>           printk(KERN_ERR "1\n");
>                 unmask_IO_APIC_irq(0);
>           printk(KERN_ERR "2\n");
>                 if (timer_irq_works()) {
>
> The "1" still occurs, then it hangs...

So if you comment out the unmask and the whole if clause
below it, does your system then boot, or do you just crash
and burn a few lines later?

M.

