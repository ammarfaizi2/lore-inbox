Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTHZKUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbTHZKUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:20:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:17341 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263667AbTHZKUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:20:48 -0400
Date: Tue, 26 Aug 2003 03:22:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.0-test4-mm1 oopses
Message-Id: <20030826032255.36273b65.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.53.0308261144300.20354@pitsa.pld.ttu.ee>
References: <Pine.GSO.4.53.0308261144300.20354@pitsa.pld.ttu.ee>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siim Vahtre <siim@pld.ttu.ee> wrote:
>
> 
> I did "modprobe i810fb fbcon" and I got two oopses (dmesg attatched).
> 
> After that, all VTs (except the first) were locked and unusable.
>

James is thattaway -->  ;)


PCI: Found IRQ 11 for device 0000:00:02.0
 I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device v0.9.0
 I810FB: Video RAM   : 4096K
 I810FB: Monitor     : H: 30-60 KHz V: 50-100 Hz
 I810FB: Mode        : 640x480-16bpp@99Hz
 Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 d0971e9a
 *pde = 00000000
 Oops: 0000 [#1]
 PREEMPT 
 CPU:    0
 EIP:    0060:[<d0971e9a>]    Not tainted VLI
 EFLAGS: 00010287
 EIP is at i810fb_cursor+0x1da/0x240 [i810fb]
 eax: 00000000   ebx: cf1b6800   ecx: cf7042a0   edx: 00000000
 esi: 00000000   edi: 00000010   ebp: cf3cfc00   esp: cdddd6f4
 ds: 007b   es: 007b   ss: 0068
 Process modprobe (pid: 796, threadinfo=cdddc000 task=ce2bd3a0)
 Stack: d4979000 00000000 0c000c8c 220f202e 00000010 00000008 d4979000 f0000000 
        00000001 00000003 00240400 8f0f0087 00000001 00000000 00000000 00000000 
        00000000 cfda6e80 00000001 cfa476a0 0000007f cdf36c40 0000002e 00000000 
 Call Trace:
  [<c02f42d6>] apic_timer_interrupt+0x1a/0x20
  [<c01585b5>] bh_lru_install+0xb5/0x100
  [<c0158673>] __find_get_block+0x73/0xf0
  [<c015871b>] __getblk+0x2b/0x60
  [<c01c5ccb>] is_tree_node+0x6b/0x70
  [<c01c63c9>] search_by_key+0x6f9/0xf30
  [<c01c6dbe>] search_for_position_by_key+0x1be/0x3d0
  [<c02f42d6>] apic_timer_interrupt+0x1a/0x20
  [<d4a024ac>] accel_putcs+0x2bc/0x370 [fbcon]
  [<c0246e65>] move_buf_aligned+0x35/0x50
  [<d4a038b5>] fbcon_cursor+0x3b5/0x500 [fbcon]
  [<d4a034f0>] fbcon_putcs+0x90/0xa0 [fbcon]
