Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTHFSPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270982AbTHFSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:15:49 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:65490 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270751AbTHFSPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:15:32 -0400
Date: Wed, 6 Aug 2003 15:18:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.4.22rc1 bug report
In-Reply-To: <03B790J11@hubert.heliogroup.fr>
Message-ID: <Pine.LNX.4.44.0308061516160.4979-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hubert, 

I thought the oops wasnt happening at boot time and that it killed the 
box. I misread your report first time.

The problem seems to be happening in the network driver or somewhere in 
the PCMCIA code.

Can you please run ksymoops to convert the oops output in human readable 
format ?

On Wed, 6 Aug 2003, Hubert Tonneau wrote:

> It seams that 2.4.22 rc1 is raising a bug at boot time, also it seams to recover
> gracefully.
> See 'Unable to handle kernel NULL pointer dereference at virtual address 0000002c'
> in the kernel log attached below.
> 
> 2.4.21 works fine, and I have not tested anything in the middle of 2.4.21 and
> 2.4.22rc1
> 
> Also as Marcelo suggested, I tester the box with memtest86 and it is fine.
> 
> Regards,
> Hubert Tonneau
> 
> 
> <4>Linux version 2.4.22 (root@hubert) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Aug 6 03:07:09 CEST 2003
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> <4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> <4> BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
> <4> BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
> <4> BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
> <4> BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
> <4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> <5>255MB LOWMEM available.
> <4>On node 0 totalpages: 65520

<snip>

> <6>Intel ISA/PCI/CardBus PCIC probe:
> <6>PCI: Found IRQ 11 for device 00:04.0
> <6>PCI: Sharing IRQ 11 with 00:04.1
> <6>PCI: Sharing IRQ 11 with 01:00.0
> <6>PCI: Found IRQ 11 for device 00:04.1
> <6>PCI: Sharing IRQ 11 with 00:04.0
> <6>PCI: Sharing IRQ 11 with 01:00.0
> <6>  TI 1225 rev 01 PCI-to-CardBus at slot 00:04, mem 0x10000000
> <6>    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 2/5]
> <6>    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 6/9]
> <6>    ISA irqs (scanned) = 3,4,7,10 PCI status changes
> <1>Unable to handle kernel NULL pointer dereference at virtual address 0000002c
> <4> printing eip:
> <4>c01800d6
> <1>*pde = 00000000
> <4>Oops: 0000
> <4>CPU:    0
> <4>EIP:    0010:[<c01800d6>]    Not tainted
> <4>EFLAGS: 00010046
> <4>eax: 00000006   ebx: 00000246   ecx: 00000024   edx: 00000006
> <4>esi: 0000001c   edi: 0000001c   ebp: c77d7b50   esp: c77d7b0c
> <4>ds: 0018   es: 0018   ss: 0018
> <4>Process cardctl (pid: 40, stackpage=c77d7000)
> <4>Stack: 00000024 c7804000 d0a88866 0000001c 00000024 ffffffff ff000000 00000006 
> <4>       c0121908 00000006 c01f21e0 000001ff 00000001 00000000 c780408c 00000000 
> <4>       00000286 c77d7b90 d0a88a51 c7804000 00000006 000001d2 cfe9a3a0 00000002 
> <4>Call Trace:    [<d0a88866>] [<c0121908>] [<d0a88a51>] [<d0a84b22>] [<c0121908>]
> <4>  [<c0121908>] [<c012a0a6>] [<c0120eed>] [<d0a84f3e>] [<c0121908>] [<d0a84d5b>]
> <4>  [<c01213c2>] [<c012190e>] [<d0a83b5f>] [<d0a9bc33>] [<c01c9c26>] [<c0121908>]
> <4>  [<c0147644>] [<c01239b3>] [<c012a2b0>] [<c012a0a6>] [<c0120db6>] [<c0123329>]
> <4>  [<c013266b>] [<c013085e>] [<c0130707>] [<c013077a>] [<c013122f>] [<c0124494>]
> <4>  [<c01244c1>] [<c0131850>] [<c014f2c9>] [<c014fe61>] [<c015265d>] [<c013917f>]
> <4>  [<c013b197>] [<c0106be3>]
> <4>
> <4>Code: 8b 46 10 8b 50 30 8b 44 24 14 50 51 56 8b 42 14 ff d0 83 c4 
> <4> <6>cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5257
> <6>3c59x.c:v0.99Q 5/16/2000 Donald Becker, becker@scyld.com
> <6>  http://www.scyld.com/network/vortex.html
> <6>cs: cb_config(bus 2)
> <6>cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
> <6>cs: IO port probe 0x0380-0x03f7: clean.
> <6>cs: IO port probe 0x0400-0x04cf: clean.
> <6>cs: IO port probe 0x04d8-0x04ff: clean.
> <6>cs: IO port probe 0x0800-0x08ff: clean.
> <6>cs: IO port probe 0x0a00-0x0aff: clean.
> <6>cs: IO port probe 0x0c00-0x0cff: clean.
> <6>  fn 0 bar 1: io 0x200-0x27f
> <6>  fn 0 bar 2: mem 0x60021000-0x6002107f
> <6>  fn 0 bar 3: mem 0x60020000-0x6002007f
> <6>  fn 0 rom: mem 0x60000000-0x6001ffff
> <6>  irq 11
> <7>cs: cb_enable(bus 2)
> <7>  bridge io map 0 (flags 0x21): 0x200-0x27f
> <7>  bridge mem map 0 (flags 0x1): 0x60000000-0x60021fff
> <6>vortex_attach(device 02:00.0)
> <6>eth0: 3Com 3CCFE575CT Tornado CardBus at 0x200, 00:01:02:e3:cc:c0, irq 11
> <6>  product code 'ZX' rev 10.0 date 10-19-00
> <6>  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
> <4>spurious 8259A interrupt: IRQ7.


