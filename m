Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272147AbTG2Wvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTG2Wvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:51:31 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:21900 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S272315AbTG2WvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:51:09 -0400
Date: Tue, 29 Jul 2003 15:51:04 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
In-Reply-To: <20030728035920.GA1660@win.tue.nl>
Message-ID: <Pine.LNX.4.53.0307291521520.24801@twinlark.arctic.org>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
 <20030728035920.GA1660@win.tue.nl>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Andries Brouwer wrote:

> On Sun, Jul 27, 2003 at 07:13:26PM -0700, dean gaudet wrote:
>
> > i've got a box on which 2.4.x works fine, but 2.6.0-test2 gets into a snit
> > when it's trying to initialize the i8042.  i can get 2.6.0-test2 to boot
> > if i add "i8042_nomux".
>
> What hardware do you have? And what is the conversation?

this system has an ali1563 (it's a development board for a new processor).

hope this helps -- i enabled DEBUG in i8042.c:

Loading test..........................
BIOS data check successful
Linux version 2.6.0-test2 (root@zim) (gcc version 3.2.3 (Debian)) #2 Tue Jul 29 12:51:24 PDT 2003
[...snip...]
mice: PS/2 mouse device common for all mice
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [30]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [30]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [61]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [61]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [61]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [107]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [107]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [107]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [154]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [154]
drivers/input/serio/i8042.c: ee <- i8042 (return) [154]
i8042.c: Detected active multiplexing controller, rev 1.1.
drivers/input/serio/i8042.c: 60 -> i8042 (command) [217]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [217]
drivers/input/serio/i8042.c: 90 -> i8042 (command) [248]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [264]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [279]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [295]
drivers/input/serio/i8042.c: 92 -> i8042 (command) [311]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [326]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [342]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [357]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [373]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [373]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [404]
drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [404]
drivers/input/serio/i8042.c: 90 -> i8042 (command) [436]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [436]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, timeout) [480]
drivers/input/serio/i8042.c: 90 -> i8042 (command) [501]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [501]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, timeout) [544]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [565]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [565]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [597]
drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [597]
drivers/input/serio/i8042.c: 90 -> i8042 (command) [629]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [629]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, timeout) [673]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [693]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [693]
serio: i8042 AUX0 port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [737]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [737]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [768]
drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [768]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [800]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [800]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux1, 12, timeout) [844]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [865]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [865]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux1, 12, timeout) [910]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [931]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [931]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [962]
drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [962]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [994]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [994]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux1, 12, timeout) [1038]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1059]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [1059]
serio: i8042 AUX1 port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1103]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [1103]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [1135]
drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [1135]
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1168]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [1168]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 12, bad parity) [1206]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1237]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1237]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1269]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1299]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1299]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1332]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1362]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1362]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1394]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1425]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1425]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1457]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1488]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1488]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1520]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1550]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1550]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1582]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1613]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1613]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1645]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1675]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1675]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1708]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1738]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1738]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1770]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1801]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1801]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1833]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1863]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1863]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1895]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1926]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1926]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [1958]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [1989]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [1989]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2021]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2051]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2051]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2083]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2114]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2114]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2146]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2176]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2176]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2208]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2239]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2239]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2271]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2302]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2302]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2334]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2364]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2364]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2396]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2427]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2427]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2459]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2489]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2489]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2521]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2552]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2552]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2584]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2614]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2614]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2647]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2678]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2678]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2710]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2741]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2741]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2773]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2803]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2803]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2835]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2866]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2866]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2898]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2929]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2929]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [2961]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [2992]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [2992]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [3024]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [3054]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [3054]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [3086]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [3117]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [3117]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [3149]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [3179]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [3179]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [3211]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [3242]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [3242]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [3274]
atkbd.c: frame/parity error: 02
drivers/input/serio/i8042.c: 92 -> i8042 (command) [3305]
drivers/input/serio/i8042.c: fe -> i8042 (parameter) [3305]
drivers/inp<1>Unable to handle kernel NULL pointer dereference at virtual address 0000001d
 printing eip:
c0118b0a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0118b0a>]    Not tainted
EFLAGS: 00010007
EIP is at scheduler_tick+0x6a/0x340
eax: 00000000   ebx: 00000001   ecx: 00000001   edx: 00000000
esi: 00000001   edi: 00000000   ebp: dbe9002c   esp: dbe90014
ds: 007b   es: 007b   ss: 0068
Process À Ñ3ÀØ>À (pid: -606380032, threadinfo=dbe8e000 task=dbe91240)
Stack: 00000007 00000000 00000000 00000000 00000001 00000000 dbe9004c c0124466
       00000000 00000001 00000001 00000000 dbe90000 dbe900c4 dbe9005c c0124695
       00000000 dbe90000 dbe90074 c010fa92 dbe900c4 c033bd84 20000001 00000000
Call Trace:
 [<c0124466>] update_process_times+0x46/0x50
 [<c0124695>] do_timer+0x35/0xf0
 [<c010fa92>] timer_interrupt+0x52/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010baac>] do_IRQ+0x9c/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01148e2>] delay_tsc+0x12/0x20
 [<c021a544>] __delay+0x14/0x20
 [<c023b192>] serial8250_console_write+0xb2/0x280
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011ce00>] call_console_drivers+0x80/0x120
 [<c011d14f>] release_console_sem+0x5f/0xe0
 [<c011d028>] printk+0x118/0x180
 [<c0283a48>] i8042_interrupt+0x198/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010bb27>] do_IRQ+0x117/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c028351b>] i8042_command+0x6b/0x180
 [<c0283702>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c011d028>] printk+0x118/0x180
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c0283a79>] i8042_interrupt+0x1c9/0x3b0
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
