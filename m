Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbTGAG0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbTGAG0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:26:07 -0400
Received: from mail.city-map.de ([62.116.172.149]:53713 "EHLO mail.city-map.de")
	by vger.kernel.org with ESMTP id S266008AbTGAG0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:26:01 -0400
Message-ID: <009c01c33f9c$13bb5cc0$9700a8c0@eagle>
From: =?iso-8859-1?Q?S=F6nke_Ruempler?= <ruempler@topconcepts.com>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS in vmscan.c:553
Date: Tue, 1 Jul 2003 08:43:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

we had that OOPS the last night two times. does anyone know what to do? do
you need more info?

ksymoops 2.4.1 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Warning (compare_maps): ksyms_base symbol GPLONLY___ide_do_rw_disk not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_destroy_dmatable not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_dma_intr not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_get_best_pio_mode not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_register_driver
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pci_unregister_driver
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timings not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_set_xfer_rate not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_dma not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_device not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_devices not
found in System.map.  Ignoring ksyms_base entry
Jun 30 20:42:56 web01 kernel: kernel BUG at vmscan.c:553!
Jun 30 20:42:56 web01 kernel: invalid operand: 0000
Jun 30 20:42:56 web01 kernel: CPU:    0
Jun 30 20:42:56 web01 kernel: EIP:    0010:[refill_inactive+166/256]    Not
tainted
Jun 30 20:42:56 web01 kernel: EIP:    0010:[<c0127ff6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 30 20:42:56 web01 kernel: EFLAGS: 00010246
Jun 30 20:42:56 web01 kernel: eax: 00000000   ebx: c1122f80   ecx: c1122f9c
edx: c1b619b0
Jun 30 20:42:56 web01 kernel: esi: c1b619b0   edi: 00000007   ebp: 00000002
esp: c1c33f5c
Jun 30 20:42:56 web01 kernel: ds: 0018   es: 0018   ss: 0018
Jun 30 20:42:56 web01 kernel: Process kswapd (pid: 4, stackpage=c1c33000)
Jun 30 20:42:56 web01 kernel: Stack: 00000020 000001d0 00000006 00000020
c0128094 00000008 c0220500 00000006
Jun 30 20:42:56 web01 kernel:        000001d0 c0220500 00000000 c012811c
00000020 c0220500 00000002 c1c32000
Jun 30 20:42:56 web01 kernel:        c012822f c02203a0 00000000 ffffffff
0008e000 c01282a6 c02203a0 c1c32000
Jun 30 20:42:56 web01 kernel: Call Trace:    [shrink_caches+68/144]
[try_to_free_pages_zone+60/96] [kswapd_balance_pgdat+79/160]
[kswapd_balance+38/64] [kswapd+161/192]
Jun 30 20:42:56 web01 kernel: Call Trace:    [<c0128094>] [<c012811c>]
[<c012822f>] [<c01282a6>] [<c01283e1>]
Jun 30 20:42:56 web01 kernel:   [<c0128340>] [<c0105000>] [<c01055d6>]
[<c0128340>]
Jun 30 20:42:56 web01 kernel: Code: 0f 0b 29 02 26 c6 1f c0 89 f6 8b 43 18
a9 80 00 00 00 74 08

>>EIP; c0127ff6 <refill_inactive+a6/100>   <=====
Trace; c0128094 <shrink_caches+44/90>
Trace; c012811c <try_to_free_pages_zone+3c/60>
Trace; c012822f <kswapd_balance_pgdat+4f/a0>
Trace; c01282a6 <kswapd_balance+26/40>
Trace; c01283e1 <kswapd+a1/c0>
Trace; c0128340 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01055d6 <arch_kernel_thread+26/30>
Trace; c0128340 <kswapd+0/c0>
Code;  c0127ff6 <refill_inactive+a6/100>
00000000 <_EIP>:
Code;  c0127ff6 <refill_inactive+a6/100>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0127ff8 <refill_inactive+a8/100>
   2:   29 02                     sub    %eax,(%edx)
Code;  c0127ffa <refill_inactive+aa/100>
   4:   26 c6 1f c0               movb   $0xc0,%es:(%edi)
Code;  c0127ffe <refill_inactive+ae/100>
   8:   89 f6                     mov    %esi,%esi
Code;  c0128000 <refill_inactive+b0/100>
   a:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c0128003 <refill_inactive+b3/100>
   d:   a9 80 00 00 00            test   $0x80,%eax
Code;  c0128008 <refill_inactive+b8/100>
  12:   74 08                     je     1c <_EIP+0x1c> c0128012
<refill_inactive+c2/100>


14 warnings issued.  Results may not be reliable.

thx, soenke.

