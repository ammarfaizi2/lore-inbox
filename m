Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293123AbSBWJlK>; Sat, 23 Feb 2002 04:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293116AbSBWJlA>; Sat, 23 Feb 2002 04:41:00 -0500
Received: from jalon.able.es ([212.97.163.2]:1719 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293117AbSBWJkp>;
	Sat, 23 Feb 2002 04:40:45 -0500
Date: Sat, 23 Feb 2002 10:40:37 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, "Barry K. Nathan" <barryn@pobox.com>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        rwhron@earthlink.net
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
Message-ID: <20020223104037.A5624@werewolf.able.es>
In-Reply-To: <20020223023332.A1689@werewolf.able.es> <20020223082301.34EDF89C87@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20020223082301=2E34EDF89?=
	=?iso-8859-1?Q?C87=40cx518206-b=2Eirvn1=2Eocca=2Ehome=2Ecom=3E=3B_from_ba?=
	=?iso-8859-1?Q?rryn=40pobox=2Ecom_on_s=E1b?=
	=?iso-8859-1?Q?=2C?= feb 23, 2002 at 09:23:01 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020223 Barry K. Nathan wrote:
>J.A. Magallon wrote:
>> My box also hangs acessing the floppy. Strange thing is that it also
>> hangs without irqrate-A1. Will send an oops.
>
>It could be one of the patches that comes before irqrate-A1 in the 00-90
>numbering sequence that your patches use; I've definitely reproduced this
>without any of the patches numbered higher than the irqrate-A1 patch.(In
>my case, if I applied all of those patches except the irqrate one, I
>didn't get the freeze. If I applied all the patches up to the irqrate one
>after, then I got the freeze.)
>

Looking at the out of sysrq-p:

Pid: 0, comm:              swapper
EIP: 0010:[schedule+129/928] CPU: 0 EFLAGS: 00000286    Tainted: P 
EIP: 0010:[<c0117651>] CPU: 0 EFLAGS: 00000286    Tainted: P 
lf32-i386 -a i386
EAX: 000000ff EBX: c02bac80 ECX: 00000000 EDX: c027c000
ESI: 00000000 EDI: c027c000 EBP: c027dfc0 DS: 0018 ES: 0018
CR0: 8005003b CR2: 4004f6b0 CR3: 1d9fc000 CR4: 000002d0
Call Trace: [rest_init+0/64] [default_idle+0/64] [default_idle+0/64] [rest_init+0/64] [cpu_idle+41/48] 
Call Trace: [<c0105000>] [<c0105200>] [<c0105200>] [<c0105000>] [<c0105289>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0117650 <schedule+80/3a0>   <=====
Trace; c0105000 <_stext+0/0>
Trace; c0105200 <default_idle+0/40>
Trace; c0105200 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105288 <cpu_idle+28/30>

I vote for the sched-O1. The mount never gets rescheduled ????

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc4-jam1 #1 SMP Sat Feb 23 01:39:06 CET 2002 i686
