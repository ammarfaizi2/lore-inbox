Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278376AbRJSMb4>; Fri, 19 Oct 2001 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278377AbRJSMbr>; Fri, 19 Oct 2001 08:31:47 -0400
Received: from redbull.speedroad.net ([195.139.232.25]:6921 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S278376AbRJSMba>; Fri, 19 Oct 2001 08:31:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnvid Karstad <arnvid@karstad.org>
Reply-To: arnvid@karstad.org
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.4.10 and tokenring
Date: Fri, 19 Oct 2001 14:31:10 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011019123139Z278376-17409+1743@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After appx 1.5 week uptime one of my Linux machines at work crashed horribly 
while doing an scp from my laptop to back up it. The linux machine is an IBM 
300GL pc with Celeron CPU and intel 810 chipset. The pc is also equip'ed with
an Madge Smart 16/4 PCI Ringenode mk2. 

The Tokenring card were configured with the kernel's driver.

The messsages log seems also to be filled with 
tr0: (DA=24DCED10 not recognized) <6>

This error message als lacks the "newline" that i would guess it should have 
had... hence making them all be a long line.

The kernel crash message were as following

pde = 00000000
Oops = 0002
CPU: 0
EIP: 0010:[<c01f2250>] found 01f220c = netif_rx
EFLAGS: 00010046
eax: 00000000 ebx: c1b87680 ecx: 00000246 edx: c02d06e0
esi: 00000286 edi: 00000000 ebp: c030b618 esp: c0293efc
ds: 0018  es: 0018 ss: 0018
Process  swapper (pid: 0, stackpage=c0293000)
Stack: XXXXXXX

Call Trace:
[<c01bf7fb>] found c01bf640 = tsm380tr_rcv_stats_irq
[<c01be08e>] found c01be03c = tsm380tr_interupt
[<c0107d5d>] found c0107e2c = handle_IRQ_event
[<c0107ebe>] found c0107e50 = do_IRQ
[<c0105150>] exact match = default_idle
[<c0105150>] exact match = default_idle
[<c0109c98>] found c0109c93 = call_do_IRQ
[<c0105150>] exact match = default_idle
[<c0105150>] exact match = default_idle
[<c0105173>] found c0105150  = default_idle
[<c01051d9>] found c0105198 = cpu_idle
[<c0105000>] 3 exact matches = _stext, stext & rest_init
[<c0105027>] foud c0105000 = rest_init

Code: ff 80 d8 00 00 00 8d 42 0c 89 43 08 8b 50 04 ff 40 08 89 03
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Seems to be a issue with the kernel driver for the madge card? would this 
issue be solved by upgrading to 2.4.12 ? or downgrading to 2.2.19+madge's own 
driver?

Regards,

Arnvid Karstad
