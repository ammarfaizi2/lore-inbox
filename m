Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbTHYJSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTHYJSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:18:55 -0400
Received: from ls401.hinet.hr ([195.29.150.2]:8836 "EHLO ls401.hinet.hr")
	by vger.kernel.org with ESMTP id S261524AbTHYJSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:18:52 -0400
Date: Mon, 25 Aug 2003 11:18:46 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825091846.GA15017@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Trace: ls401.hinet.hr 1061803127 17167 195.29.148.143 (Mon, 25 Aug 2003 11:18:47 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IBM Thinkpad R40 with 2.6.0-test4, alsa compiled as module.
If I plug in D-link DWL-650+ (_just_ a plug in a slot) and _then_
modprobe snd-intel8x0 within seconds this oops barfs on me.


ksymoops 2.4.9 on i686 2.6.0-test4.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.0-test4/ (default)
     -m /boot/System.map-2.6.0-test4 (specified)

No modules in ksyms, skipping objects
Aug 25 10:42:48 mozz-r40 kernel: invalid operand: 0000 [#1]
Aug 25 10:42:48 mozz-r40 kernel: CPU:    0
Aug 25 10:42:48 mozz-r40 kernel: EIP:    0060:[<d082300d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 25 10:42:48 mozz-r40 kernel: EFLAGS: 00010286
Aug 25 10:42:48 mozz-r40 kernel: eax: fffffbfa   ebx: d090c400   ecx: d090c3a0   edx: d090c3a0
Aug 25 10:42:48 mozz-r40 kernel: esi: ffffffed   edi: cf039400   ebp: cf0394a8   esp: cf48de6c
Aug 25 10:42:48 mozz-r40 kernel: ds: 007b   es: 007b   ss: 0068
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
Aug 25 10:42:48 mozz-r40 kernel: Code: d9 09 dc cc d8 c7 db 9a d8 2b dc b8 d8 39 dd 16 d9 a1 de 62 


>>EIP; d082300d <__crc_neigh_parms_release+357e3/b22398>   <=====

>>eax; fffffbfa <__kernel_rt_sigreturn+17ba/????>
>>ebx; d090c400 <__crc_neigh_parms_release+11ebd6/b22398>
>>ecx; d090c3a0 <__crc_neigh_parms_release+11eb76/b22398>
>>edx; d090c3a0 <__crc_neigh_parms_release+11eb76/b22398>
>>esi; ffffffed <__kernel_rt_sigreturn+1bad/????>
>>edi; cf039400 <__crc_truncate_inode_pages+49f68d/bf945e>
>>ebp; cf0394a8 <__crc_truncate_inode_pages+49f735/bf945e>
>>esp; cf48de6c <__crc_truncate_inode_pages+8f40f9/bf945e>

Trace; c01a837c <pci_device_probe_static+52/63>
Trace; c01a84cd <__pci_device_probe+3b/4e>
Trace; c01a850c <pci_device_probe+2c/4a>
Trace; c01ecddb <bus_match+3f/6a>
Trace; c01ece47 <device_attach+41/91>
Trace; c01ed006 <bus_add_device+5b/9f>
Trace; c01ec0cb <device_add+ca/100>
Trace; c01a4df1 <pci_bus_add_devices+cf/114>
Trace; d08cc04a <__crc_neigh_parms_release+de820/b22398>
Trace; d08c90e3 <__crc_neigh_parms_release+db8b9/b22398>
Trace; d08c9281 <__crc_neigh_parms_release+dba57/b22398>
Trace; d08c93cb <__crc_neigh_parms_release+dbba1/b22398>
Trace; c011d155 <default_wake_function+0/2e>
Trace; c010b0de <ret_from_fork+6/14>
Trace; c011d155 <default_wake_function+0/2e>
Trace; d08c92ab <__crc_neigh_parms_release+dba81/b22398>
Trace; c0109215 <kernel_thread_helper+5/b>

Code;  d082300d <__crc_neigh_parms_release+357e3/b22398>
00000000 <_EIP>:
Code;  d082300d <__crc_neigh_parms_release+357e3/b22398>   <=====
   0:   d9 09                     (bad)  (%ecx)   <=====
Code;  d082300f <__crc_neigh_parms_release+357e5/b22398>
   2:   dc cc                     fmul   %st,%st(4)
Code;  d0823011 <__crc_neigh_parms_release+357e7/b22398>
   4:   d8 c7                     fadd   %st(7),%st
Code;  d0823013 <__crc_neigh_parms_release+357e9/b22398>
   6:   db 9a d8 2b dc b8         fistpl 0xb8dc2bd8(%edx)
Code;  d0823019 <__crc_neigh_parms_release+357ef/b22398>
   c:   d8 39                     fdivrs (%ecx)
Code;  d082301b <__crc_neigh_parms_release+357f1/b22398>
   e:   dd 16                     fstl   (%esi)
Code;  d082301d <__crc_neigh_parms_release+357f3/b22398>
  10:   d9 a1 de 62 00 00         fldenv 0x62de(%ecx)


-- 
Mario Mikocevic (Mozgy)
mozgy at hinet dot hr
It's never too late to have a good childhood!
      The older you are, the better the toys!
My favourite FUBAR ...
