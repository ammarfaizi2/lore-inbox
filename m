Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTIBCtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTIBCtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:49:05 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:42905 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S263435AbTIBCtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:49:00 -0400
Organization: 
Date: Tue, 2 Sep 2003 05:45:52 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
In-Reply-To: <3F532C67.6070904@sbcglobal.net>
Message-ID: <Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
 <3F515301.4040305@sbcglobal.net> <3F532C67.6070904@sbcglobal.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tried to see if the problem had to do anything with acpi or Preemptible
kernel. So I disabled both of them but the problem still exists. At least
I got a better Oops, which I had to write down on paper. So it probably
has many errors. Here it is if it helps anyone...

Regards
	Panagiotis Papadakos


kernel BUG at include/linux/list.h 149!
invalid operand:0000 [#1]
CPU:    0
EIP:    0060:[<c013cb60>]       Not tainted VLI
EFLAGS: 00010003
EIP is at free_block+0xe0/0x100
eax: dabf9080  ebx: daa1aac0  ecx: daa1a000  edx: dff54814
esi: dff54800  edi: 00000000  ebp: dff5480c  esp: c03a3edc
df: 007b  es: 007b  ss: 0068
Process swapper (pid: 0, threadinfo=c03a2000 task=c034c9c0)
Stack: c0416740 dfdaeda0 c023ee69 dff5481c dff5d9c0 00000004 dff5d9d0
dff54238
       c013d099 dff54800 dff5d9d0 00000004 dff54800 00000001 dff5486c
c013d1d3
       dff54800 dff5d9c0 00000000 00000000 00000000 c013d170 c03a3f3c
c03a3f4c
Call Trace:
[<c023ee69>] atapi_output_bytes+0x39/0x80
[<c013d099>] drain_array+0x69/0x90
[<c013d1d3>] reap_timer_fnc+0x63/0x1c0
[<c013d170>] reap_timer_fnc+0xb9/0x190
[<c0125aa9>] run_timer_softirq+0x90/0xa0
[<c0121c10>] do_softirq+0x90/0xa0
[<c010c805>] do_IRQ+0xc5/0xe0
[<c0107000>] _stext+0x0/0x30
[<c02f6b34>] common_interrupt+0x18/0x20
[<c0107000>] _stext+0x0/0x30
[<c0108e93>] default_idle+0x23/0x30
[<c01083fc>] cpu_idle+0x2c/0x40
[<c03a4704>] start_kernel+0x144/0x150
[<c03a448?>] unknown_bootoption+0x0/0x100
Code: 5e 5f 5d c3 8d b4 26 00 00 00 00 2b 46 3c 89 46 24 89 34 24 89 4c 24
04 e8 1e f2 ff ff eb d2 8b 45 04 89 29 89 4d 04 89 08
      eb c3 <0f> 0b 95 00 32 1a 30 c0 e9 6c ff ff ff 0f 0b 94 00 32 1a 30
c0
<0> Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
