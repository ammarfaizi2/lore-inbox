Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTHYKZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTHYKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:25:30 -0400
Received: from ls401.hinet.hr ([195.29.150.2]:5006 "EHLO ls401.hinet.hr")
	by vger.kernel.org with ESMTP id S261613AbTHYKZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:25:22 -0400
Date: Mon, 25 Aug 2003 12:25:04 +0200
From: Mario Mikocevic <mario.mikocevic@htnet.hr>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825102504.GC14801@danielle.hinet.hr>
References: <20030825091846.GA15017@danielle.hinet.hr> <20030825104035.B30952@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030825104035.B30952@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Pon, Kol 25, 2003 at 11:40:35 +0200
X-Mailer: Balsa 2.0.13
X-Trace: ls401.hinet.hr 1061807105 32414 195.29.148.143 (Mon, 25 Aug 2003 12:25:05 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.08.25 11:40, Russell King wrote:
> On Mon, Aug 25, 2003 at 11:18:46AM +0200, Mario Mikocevic wrote:
> > IBM Thinkpad R40 with 2.6.0-test4, alsa compiled as module.
> > If I plug in D-link DWL-650+ (_just_ a plug in a slot) and _then_
> > modprobe snd-intel8x0 within seconds this oops barfs on me.
> 
> After asking akpm what an "invalid operand" on x86 means, he says its
> a BUG() statement.  So, can you please supply both the ksymoops'd
> *and* the raw undecoded kernel messages.  Apparantly ksymoops cuts off
> the lines which indicate that it was a bug and where the BUG() statement
> was.

Aug 25 10:41:55 mozz-r40 kernel: intel8x0: clocking to 48000
Aug 25 10:42:47 mozz-r40 kernel: spurious 8259A interrupt: IRQ7.
Aug 25 10:42:48 mozz-r40 kernel: invalid operand: 0000 [#1]
Aug 25 10:42:48 mozz-r40 kernel: CPU:    0
Aug 25 10:42:48 mozz-r40 kernel: EIP:    0060:[<d082300d>]    Not tainted
Aug 25 10:42:48 mozz-r40 kernel: EFLAGS: 00010286
Aug 25 10:42:48 mozz-r40 kernel: EIP is at 0xd082300d
Aug 25 10:42:48 mozz-r40 kernel: eax: fffffbfa   ebx: d090c400   ecx: d090c3a0   edx: d090c3a0
Aug 25 10:42:48 mozz-r40 kernel: esi: ffffffed   edi: cf039400   ebp: cf0394a8   esp: cf48de6c
Aug 25 10:42:48 mozz-r40 kernel: ds: 007b   es: 007b   ss: 0068
Aug 25 10:42:48 mozz-r40 kernel: Process pccardd (pid: 3202, threadinfo=cf48c000 task=cf95cc80)
Aug 25 10:42:48 mozz-r40 kernel: Stack: c01a837c cf039400 d090c3a0 cf039400 d090c400 ffffffed c01a84cd d090c400
Aug 25 10:42:48 mozz-r40 kernel:        cf039400 d090c400 cf039400 c01a850c d090c400 cf039400 d090c428 cf039454
Aug 25 10:42:48 mozz-r40 kernel:        c01ecddb cf039454 d090c428 d090c458 cf039454 c032661c c01ece47 cf039454
Aug 25 10:42:48 mozz-r40 kernel: Call Trace:
Aug 25 10:42:48 mozz-r40 kernel:  [<c01a837c>] pci_device_probe_static+0x52/0x63
Aug 25 10:42:48 mozz-r40 kernel:  [<c01a84cd>] __pci_device_probe+0x3b/0x4e
Aug 25 10:42:48 mozz-r40 kernel:  [<c01a850c>] pci_device_probe+0x2c/0x4a
Aug 25 10:42:48 mozz-r40 kernel:  [<c01ecddb>] bus_match+0x3f/0x6a
Aug 25 10:42:48 mozz-r40 kernel:  [<c01ece47>] device_attach+0x41/0x91
Aug 25 10:42:48 mozz-r40 kernel:  [<c01ed006>] bus_add_device+0x5b/0x9f
Aug 25 10:42:48 mozz-r40 kernel:  [<c01ec0cb>] device_add+0xca/0x100
Aug 25 10:42:48 mozz-r40 kernel:  [<c01a4df1>] pci_bus_add_devices+0xcf/0x114
Aug 25 10:42:48 mozz-r40 kernel:  [<d08cc04a>] cb_alloc+0xab/0xe5 [pcmcia_core]
Aug 25 10:42:48 mozz-r40 kernel:  [<d08c90e3>] socket_insert+0x7f/0x92 [pcmcia_core]
Aug 25 10:42:48 mozz-r40 kernel:  [<d08c9281>] socket_detect_change+0x58/0x82 [pcmcia_core]
Aug 25 10:42:48 mozz-r40 kernel:  [<d08c93cb>] pccardd+0x120/0x1c1 [pcmcia_core]
Aug 25 10:42:48 mozz-r40 kernel:  [<c011d155>] default_wake_function+0x0/0x2e
Aug 25 10:42:48 mozz-r40 kernel:  [<c010b0de>] ret_from_fork+0x6/0x14
Aug 25 10:42:48 mozz-r40 kernel:  [<c011d155>] default_wake_function+0x0/0x2e
Aug 25 10:42:48 mozz-r40 kernel:  [<d08c92ab>] pccardd+0x0/0x1c1 [pcmcia_core]
Aug 25 10:42:48 mozz-r40 kernel:  [<c0109215>] kernel_thread_helper+0x5/0xb
Aug 25 10:42:48 mozz-r40 kernel:
Aug 25 10:42:48 mozz-r40 kernel: Code: d9 09 dc cc d8 c7 db 9a d8 2b dc b8 d8 39 dd 16 d9 a1 de 62

The only missing lines were ->
Aug 25 10:42:48 mozz-r40 kernel: EIP is at 0xd082300d
Aug 25 10:42:48 mozz-r40 kernel: Process pccardd (pid: 3202, threadinfo=cf48c000 task=cf95cc80)

Do you need full dmesg and/or .config ?


-- 
Mario Mikocevic (Mozgy)
mozgy at hinet dot hr
It's never too late to have a good childhood!
      The older you are, the better the toys!
My favourite FUBAR ...
