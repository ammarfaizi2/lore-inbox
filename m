Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262018AbSIYQM2>; Wed, 25 Sep 2002 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbSIYQM2>; Wed, 25 Sep 2002 12:12:28 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:25997 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id <S262018AbSIYQM1>; Wed, 25 Sep 2002 12:12:27 -0400
Date: Wed, 25 Sep 2002 11:17:42 -0500
From: Andrew Ryan <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: Network related oops
Message-ID: <20020925161742.GA9101@thumper2.emsphone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this has been fixed in pre6/7, but here is a dump of a recent crash I
had on one of our systems.  There were NO modules loaded.

ksymoops 2.4.0 on i686 2.4.20-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5/ (default)
     -m /boot/System.map-2.4.20-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Sep 25 08:12:13 jci1 kernel: wait_on_irq, CPU 2:
Sep 25 08:12:13 jci1 kernel: irq:  1 [ 0 0 0 1 ]
Sep 25 08:12:13 jci1 kernel: bh:   1 [ 1 1 0 1 ]
Sep 25 08:12:13 jci1 kernel: Stack dumps:
Sep 25 08:12:13 jci1 kernel: CPU 0: <unknown> 
Sep 25 08:12:13 jci1 kernel: CPU 1:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Sep 25 08:12:13 jci1 kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Sep 25 08:12:13 jci1 kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Sep 25 08:12:13 jci1 kernel: Call Trace:    [<c022664d>] [<c0245397>] [<c022664d>] [<c022673d>] [<c0247aa8>]
Sep 25 08:12:13 jci1 kernel:   [<c0227644>] [<c024f89b>] [<c024f7cf>] [<c024fd8d>] [<c0237860>] [<c0237be4>]
Sep 25 08:12:13 jci1 kernel:   [<c0131563>] [<c022a3e9>] [<c022641f>] [<c01c8a3f>] [<c01c6a07>] [<c0116383>]
Sep 25 08:12:13 jci1 kernel:   [<c011de1b>] [<c011e39f>] [<c0107166>] [<c011e2e0>]
Sep 25 08:12:13 jci1 kernel: CPU 3:00000016 05802a10 e0244fd2 61010000 00000b6c 0002d4d9 6afb0000 00000014 
Sep 25 08:12:13 jci1 kernel:        0502d917 e0244fd2 65010000 00000b6c 0002d448 64fe0000 0000000a 0280456c 
Sep 25 08:12:13 jci1 kernel:        e0244fd2 6a020000 00000b6c 0002d4e8 63fd0000 00000011 04410456 e0244fd2 
Sep 25 08:12:13 jci1 kernel: Call Trace:   
Sep 25 08:12:13 jci1 kernel: CPU 2:f7bfff28 c02781dd 00000002 00000001 ffffffff 00000002 c010a2b2 c02781f2 
Sep 25 08:12:13 jci1 kernel:        00000000 f7502000 00000001 c01a42b8 f7502168 c02d9b84 f7bfff74 f7bfe664 
Sep 25 08:12:13 jci1 kernel:        f7bfe000 c011e2cd f7502000 f7502130 c02d9b84 00010000 f7bfe674 c0126e05 
Sep 25 08:12:13 jci1 kernel: Call Trace:    [<c010a2b2>] [<c01a42b8>] [<c011e2cd>] [<c0126e05>] [<c0126cc0>]
Sep 25 08:12:13 jci1 kernel:   [<c0105000>] [<c0107166>] [<c0126cc0>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c022664d <kfree_skbmem+5d/70>
Trace; c0245397 <tcp_clean_rtx_queue+207/2f0>
Trace; c022664d <kfree_skbmem+5d/70>
Trace; c022673d <__kfree_skb+dd/e0>
Trace; c0247aa8 <tcp_rcv_established+c8/7c0>
Trace; c0227644 <skb_checksum+54/2f0>
Trace; c024f89b <tcp_v4_do_rcv+3b/130>
Trace; c024f7cf <tcp_v4_checksum_init+7f/110>
Trace; c024fd8d <tcp_v4_rcv+3fd/670>
Trace; c0237860 <ip_local_deliver+c0/140>
Trace; c0237be4 <ip_rcv+304/37b>
Trace; c0131563 <kmalloc+a3/160>
Trace; c022a3e9 <netif_receive_skb+119/150>
Trace; c022641f <alloc_skb+ef/1c0>
Trace; c01c8a3f <tg3_rx+27f/330>
Trace; c01c6a07 <tg3_enable_ints+17/50>
Trace; c0116383 <schedule+483/540>
Trace; c011de1b <do_softirq+7b/e0>
Trace; c011e39f <ksoftirqd+bf/110>
Trace; c0107166 <kernel_thread+26/30>
Trace; c011e2e0 <ksoftirqd+0/110>
Trace; c010a2b2 <__global_cli+e2/170>
Trace; c01a42b8 <flush_to_ldisc+d8/120>
Trace; c011e2cd <__run_task_queue+5d/70>
Trace; c0126e05 <context_thread+145/200>
Trace; c0126cc0 <context_thread+0/200>
Trace; c0105000 <_stext+0/0>
Trace; c0107166 <kernel_thread+26/30>
Trace; c0126cc0 <context_thread+0/200>


3 warnings issued.  Results may not be reliable.

Andy
