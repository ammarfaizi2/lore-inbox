Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTALXfv>; Sun, 12 Jan 2003 18:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTALXfv>; Sun, 12 Jan 2003 18:35:51 -0500
Received: from kilroy.chi.il.us ([205.243.139.239]:7296 "EHLO kilroy.chi.il.us")
	by vger.kernel.org with ESMTP id <S267641AbTALXfp>;
	Sun, 12 Jan 2003 18:35:45 -0500
Subject: Kernel oops in 2.4.21-pre3-ac2
From: Edward Kuns <ekuns@kilroy.chi.il.us>
To: linux-kernel@vger.kernel.org
Cc: Edward Kuns <ekuns@kilroy.chi.il.us>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042415250.1602.14.camel@kilroy.chi.il.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Jan 2003 17:47:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Red Hat 8.0 with all updates plus red carpet downlaod version of
Evolution plus 1.3b verson of Mozilla plus acroread from Acrobat5. 
That's pretty much all that was running at the time.  Withoiut warning,
X hung, mouse hung, keyboard hung, CTL-ALT-DEL had no effect,
CTL-ALT-BACKSPACE had no effect.  However, ALT-SysRq-S worked,
ALT-SysRq-B worked.

My X server is NVidia's latest release, build 4191.

Rebooted into the same kerne so I could run ksymoops.  Looked in
/var/log/messages and found two OOPses.  They are decoded below.  I
don't know why I got the various "cannot stat(....)" lines, nor why I
got the complaints "cannot match loaded modile raid0 to a unique module
object" (and same for ehci-hcd).

Do I need to provide some options to ksymoops?  It found the correct
system map file and the correct directory for modules.

I don't absolutely know that these oopses resulted in the
X/keyboard/mouse crash.  I don't *think* these oopses take place in
NVidia code but I don't know enough about reading this stack dump to be
able to tell.  If it is in fact the NVidia code, someone plesae let me
know and I'll happily ask them for support.

Plesae CC me with any responses.  I'll provide any additional
information on request (such as .config for kernel).  I am just not
certain which additional information would be helpful.

     Thank you

          Eddie


ksymoops 2.4.5 on i686 2.4.21-pre3-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac2/ (default)
     -m /boot/System.map-2.4.21-pre3-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/raid5.o) for raid5
Error (expand_objects): cannot stat(/lib/xor.o) for xor
Error (expand_objects): cannot stat(/lib/raid0.o) for raid0
Error (expand_objects): cannot stat(/lib/md.o) for md
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/usb-storage.o) for usb-storage
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Error (expand_objects): cannot stat(/lib/usb-uhci.o) for usb-uhci
Error (expand_objects): cannot stat(/lib/ehci-hcd.o) for ehci-hcd
Error (expand_objects): cannot stat(/lib/usb-ohci.o) for usb-ohci
Error (expand_objects): cannot stat(/lib/usbcore.o) for usbcore
Warning (map_ksym_to_module): cannot match loaded module raid0 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module ehci-hcd to a unique module object.  Trace may not be reliable.
Jan 12 16:40:42 kilroy kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jan 12 16:40:42 kilroy kernel: c0136026
Jan 12 16:40:42 kilroy kernel: *pde = 00000000
Jan 12 16:40:42 kilroy kernel: Oops: 0002
Jan 12 16:40:42 kilroy kernel: CPU:    0
Jan 12 16:40:42 kilroy kernel: EIP:    0010:[<c0136026>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 12 16:40:42 kilroy kernel: EFLAGS: 00210246
Jan 12 16:40:42 kilroy kernel: eax: 00000000   ebx: c13d94d4   ecx: cc926000   edx: cc92605c
Jan 12 16:40:42 kilroy kernel: esi: 00000000   edi: 00000000   ebp: cc927dfc   esp: cc927dcc
Jan 12 16:40:42 kilroy kernel: ds: 0018   es: 0018   ss: 0018
Jan 12 16:40:42 kilroy kernel: Process gs (pid: 12948, stackpage=cc927000)
Jan 12 16:40:42 kilroy kernel: Stack: 24000001 cc927de4 e09fcd1a dfda8000 cc927de0 00000001 cc927df4 e09fd960
Jan 12 16:40:42 kilroy kernel:        00000000 00000000 c13d94d4 00001de0 cc927e30 c01351ce c13d94d4 d6a144c0
Jan 12 16:40:42 kilroy kernel:        24000001 cc926000 00000200 000001d2 c02c0470 00000020 00000020 000001d2
Jan 12 16:40:42 kilroy kernel: Call Trace:    [<e09fcd1a>] [<e09fd960>] [<c01351ce>] [<c0135410>] [<c0135489>]
Jan 12 16:40:42 kilroy kernel:   [<c013633c>] [<c01365c1>] [<c012bc3c>] [<c012beff>] [<c0117ff0>] [<e086ac70>]
Jan 12 16:40:42 kilroy kernel:   [<e086ad1d>] [<c01254dc>] [<c0124b76>] [<c0121272>] [<c0121166>] [<c010a97d>]
Jan 12 16:40:42 kilroy kernel:   [<c0117e90>] [<c01092c8>]
Jan 12 16:40:42 kilroy kernel: Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bd 0f


>>EIP; c0136026 <__free_pages_ok+266/290>   <=====

>>ebx; c13d94d4 <_end+1089870/204ee3fc>
>>ecx; cc926000 <_end+c5d639c/204ee3fc>
>>edx; cc92605c <_end+c5d63f8/204ee3fc>
>>ebp; cc927dfc <_end+c5d8198/204ee3fc>
>>esp; cc927dcc <_end+c5d8168/204ee3fc>

Trace; e09fcd1a <[iptable_nat].bss.end+13843/14b89>
Trace; e09fd960 <[iptable_nat].bss.end+14489/14b89>
Trace; c01351ce <shrink_cache+21e/310>
Trace; c0135410 <shrink_caches+60/a0>
Trace; c0135489 <try_to_free_pages_zone+39/60>
Trace; c013633c <balance_classzone+5c/1f0>
Trace; c01365c1 <__alloc_pages+f1/190>
Trace; c012bc3c <do_anonymous_page+5c/110>
Trace; c012beff <handle_mm_fault+6f/100>
Trace; c0117ff0 <do_page_fault+160/527>
Trace; e086ac70 <[usb-uhci]rh_int_timer_do+0/50>
Trace; e086ad1d <[usb-uhci]rh_init_int_timer+5d/70>
Trace; c01254dc <run_timer_list+14c/170>
Trace; c0124b76 <update_wall_time+16/40>
Trace; c0121272 <bh_action+22/50>
Trace; c0121166 <tasklet_hi_action+46/70>
Trace; c010a97d <do_IRQ+bd/f0>
Trace; c0117e90 <do_page_fault+0/527>
Trace; c01092c8 <error_code+34/3c>

Code;  c0136026 <__free_pages_ok+266/290>
00000000 <_EIP>:
Code;  c0136026 <__free_pages_ok+266/290>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0136029 <__free_pages_ok+269/290>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c013602b <__free_pages_ok+26b/290>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c013602e <__free_pages_ok+26e/290>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c0136031 <__free_pages_ok+271/290>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c0136034 <__free_pages_ok+274/290>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c0136037 <__free_pages_ok+277/290>
  11:   eb bd                     jmp    ffffffd0 <_EIP+0xffffffd0>
Code;  c0136039 <__free_pages_ok+279/290>
  13:   0f 00 00                  sldtl  (%eax)

Jan 12 16:40:42 kilroy kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jan 12 16:40:42 kilroy kernel: c0136026
Jan 12 16:40:42 kilroy kernel: *pde = 00000000
Jan 12 16:40:42 kilroy kernel: Oops: 0002
Jan 12 16:40:42 kilroy kernel: CPU:    0
Jan 12 16:40:42 kilroy kernel: EIP:    0010:[<c0136026>]    Tainted: PF
Jan 12 16:40:42 kilroy kernel: EFLAGS: 00210246
Jan 12 16:40:42 kilroy kernel: eax: 00000000   ebx: c11a361c   ecx: cc926000   edx: cc92605c
Jan 12 16:40:42 kilroy kernel: esi: 00000000   edi: 00000000   ebp: cc927c04   esp: cc927bd4
Jan 12 16:40:42 kilroy kernel: ds: 0018   es: 0018   ss: 0018
Jan 12 16:40:42 kilroy kernel: Process gs (pid: 12948, stackpage=cc927000)
Jan 12 16:40:42 kilroy kernel: Stack: cc927c04 c01d2fb6 00000006 c0326097 00000001 000065f8 000065f8 c11a361c
Jan 12 16:40:42 kilroy kernel:        cc927c04 00000000 c64ecbbc 0006e000 cc927c30 c012c48a c11a361c 00000000
Jan 12 16:40:42 kilroy kernel:        00000003 c02c65c0 c11a361c 00000001 08400000 cc68a084 0835d000 cc927c68
Jan 12 16:40:42 kilroy kernel: Call Trace:    [<c01d2fb6>] [<c012c48a>] [<c012ad3a>] [<c012db6e>] [<c011a878>]
Jan 12 16:40:42 kilroy kernel:   [<c011f742>] [<c010987e>] [<c011815c>] [<c0117e90>] [<c01092c8>] [<e0b40018>]
Jan 12 16:40:42 kilroy kernel:   [<c0136026>] [<e09fcd1a>] [<e09fd960>] [<c01351ce>] [<c0135410>] [<c0135489>]
Jan 12 16:40:42 kilroy kernel:   [<c013633c>] [<c01365c1>] [<c012bc3c>] [<c012beff>] [<c0117ff0>] [<e086ac70>]
Jan 12 16:40:42 kilroy kernel:   [<e086ad1d>] [<c01254dc>] [<c0124b76>] [<c0121272>] [<c0121166>] [<c010a97d>]
Jan 12 16:40:42 kilroy kernel:   [<c0117e90>] [<c01092c8>]
Jan 12 16:40:42 kilroy kernel: Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bd 0f


>>EIP; c0136026 <__free_pages_ok+266/290>   <=====

>>ebx; c11a361c <_end+e539b8/204ee3fc>
>>ecx; cc926000 <_end+c5d639c/204ee3fc>
>>edx; cc92605c <_end+c5d63f8/204ee3fc>
>>ebp; cc927c04 <_end+c5d7fa0/204ee3fc>
>>esp; cc927bd4 <_end+c5d7f70/204ee3fc>

Trace; c01d2fb6 <vt_console_print+56/310>
Trace; c012c48a <zap_pte_range+fa/120>
Trace; c012ad3a <zap_page_range+9a/100>
Trace; c012db6e <exit_mmap+be/160>
Trace; c011a878 <mmput+48/a0>
Trace; c011f742 <do_exit+92/240>
Trace; c010987e <die+7e/c0>
Trace; c011815c <do_page_fault+2cc/527>
Trace; c0117e90 <do_page_fault+0/527>
Trace; c01092c8 <error_code+34/3c>
Trace; e0b40018 <[nvidia]__nvsym04358+54/a0>
Trace; c0136026 <__free_pages_ok+266/290>
Trace; e09fcd1a <[iptable_nat].bss.end+13843/14b89>
Trace; e09fd960 <[iptable_nat].bss.end+14489/14b89>
Trace; c01351ce <shrink_cache+21e/310>
Trace; c0135410 <shrink_caches+60/a0>
Trace; c0135489 <try_to_free_pages_zone+39/60>
Trace; c013633c <balance_classzone+5c/1f0>
Trace; c01365c1 <__alloc_pages+f1/190>
Trace; c012bc3c <do_anonymous_page+5c/110>
Trace; c012beff <handle_mm_fault+6f/100>
Trace; c0117ff0 <do_page_fault+160/527>
Trace; e086ac70 <[usb-uhci]rh_int_timer_do+0/50>
Trace; e086ad1d <[usb-uhci]rh_init_int_timer+5d/70>
Trace; c01254dc <run_timer_list+14c/170>
Trace; c0124b76 <update_wall_time+16/40>
Trace; c0121272 <bh_action+22/50>
Trace; c0121166 <tasklet_hi_action+46/70>
Trace; c010a97d <do_IRQ+bd/f0>
Trace; c0117e90 <do_page_fault+0/527>
Trace; c01092c8 <error_code+34/3c>

Code;  c0136026 <__free_pages_ok+266/290>
00000000 <_EIP>:
Code;  c0136026 <__free_pages_ok+266/290>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0136029 <__free_pages_ok+269/290>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c013602b <__free_pages_ok+26b/290>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c013602e <__free_pages_ok+26e/290>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c0136031 <__free_pages_ok+271/290>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c0136034 <__free_pages_ok+274/290>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c0136037 <__free_pages_ok+277/290>
  11:   eb bd                     jmp    ffffffd0 <_EIP+0xffffffd0>
Code;  c0136039 <__free_pages_ok+279/290>
  13:   0f 00 00                  sldtl  (%eax)


3 warnings and 12 errors issued.  Results may not be reliable.



-- 
Edward Kuns <ekuns@kilroy.chi.il.us>
