Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277188AbRKAWtg>; Thu, 1 Nov 2001 17:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279838AbRKAWt1>; Thu, 1 Nov 2001 17:49:27 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:9459 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S277188AbRKAWtH>; Thu, 1 Nov 2001 17:49:07 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6E5@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Carl Ritson'" <critson@perlfu.co.uk>
Cc: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: RE: OOPS on boot in 2.4.13-ac5 & 2.4.14-pre6
Date: Thu, 1 Nov 2001 14:49:03 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're not the first to report this but we don't have a fix yet.

Regards -- Andy

> -----Original Message-----
> From: Carl Ritson [mailto:critson@perlfu.co.uk]
> Sent: Thursday, November 01, 2001 2:15 PM
> To: critson@perlfu.co.uk
> Cc: linux-kernel@vger.kernel.org;
> acpi@phobos.fachschaften.tu-muenchen.de
> Subject: OOPS on boot in 2.4.13-ac5 & 2.4.14-pre6
> 
> 
> This occurs about 3 seconds into booting on my test system during the
> initialization of the ACPI Subsystem.  The kernel boots ok 
> without ACPI
> support.  The box is a K6-3 450Mhz, 192Mb of RAM, 10Gb IDE HDD disk.
> 
> Attached is my kernel config for 2.4.13-ac5.
> 
> Further testing with Verbose BUG() reporting tells me that we 
> are doing
> "Schdeduling in interrupt" - sched.c line 712, not nice :(
> 
> Maybe I will stare at it again tomorrow morning when I am awake..
> 
> ---
> Carl Ritson
> critson@perlfu.co.uk
> 
> 
> --- OOPS ---
> ksymoops 2.4.0 on i586 2.4.4.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.13-ac5/ (specified)
>      -m /usr/src/linux/System.map (specified)
> 
> No modules in ksyms, skipping objects
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0111d4d>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010092
> eax: 00000018   ebx: cbf7e000   ecx: 00000001   edx: 00000001
> esi: 00000001   edi: c028a8c0   ebp: cbf7fd80   esp: cbf7fd5c
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=cbf7f000)
> Stack: c024a036 cbf7fdbc cbf7e000 00000000 cbf7e000 00000711 cbf7e000
> cbf7fdbc
>        c0182b80 cbf7fe78 c0106dc5 00000711 c017d4a0 cbf5f5e0 cbf7fdbc
> c0182b80
>        cbf7fe78 00000008 00000018 00000018 00000078 c010550d 00000010
> 00000206
> Call Trace: [<c0182b80>] [<c0106dc5>] [<c017d4a0>] [<c0182b80>]
> [<c010550d>]
>    [<c017d509>] [<c017d4a0>] [<c017d5b4>] [<c0182bdb>] [<c0182b80>]
> [<c018250c>]
>    [<c0182425>] [<c01833b5>] [<c017d09d>] [<c01080da>] [<c017d090>]
> [<c010825d>]
>    [<c010a314>] [<c017d242>] [<c0185278>] [<c0184fc2>] [<c0184b3c>]
> [<c0183bc1>]
>    [<c01835b4>] [<c0182c05>] [<c0182ba0>] [<c0182333>] [<c017f4be>]
> [<c0191a27>]
>    [<c0105000>] [<c0105049>] [<c0105000>] [<c0105516>] [<c0105040>]
> Code: 0f 0b 8d 65 f4 5b 5e 5f 5d c3 89 f6 8d bc 27 00 00 00 00 55
> 
> >>EIP; c0111d4d <schedule+35d/370>   <=====
> Trace; c0182b80 <acpi_ev_global_lock_thread+0/20>
> Trace; c0106dc5 <reschedule+5/10>
> Trace; c017d4a0 <acpi_os_queue_exec+0/50>
> Trace; c0182b80 <acpi_ev_global_lock_thread+0/20>
> Trace; c010550d <kernel_thread+1d/30>
> Trace; c017d509 <acpi_os_schedule_exec+19/30>
> Trace; c017d4a0 <acpi_os_queue_exec+0/50>
> Trace; c017d5b4 <acpi_os_queue_for_execution+94/a0>
> Trace; c0182bdb <acpi_ev_global_lock_handler+3b/50>
> Trace; c0182b80 <acpi_ev_global_lock_thread+0/20>
> Trace; c018250c <acpi_ev_fixed_event_dispatch+9c/a0>
> Trace; c0182425 <acpi_ev_fixed_event_detect+55/a0>
> Trace; c01833b5 <acpi_ev_sci_handler+25/40>
> Trace; c017d09d <acpi_irq+d/10>
> Trace; c01080da <handle_IRQ_event+3a/70>
> Trace; c017d090 <acpi_irq+0/10>
> Trace; c010825d <do_IRQ+6d/b0>
> Trace; c010a314 <call_do_IRQ+5/11>
> Trace; c017d242 <acpi_os_write_port+32/40>
> Trace; c0185278 <acpi_hw_low_level_write+78/f0>
> Trace; c0184fc2 <acpi_hw_register_write+122/260>
> Trace; c0184b3c <acpi_hw_register_bit_access+2ec/3b0>
> Trace; c0183bc1 <acpi_enable_event+71/c0>
> Trace; c01835b4 <acpi_install_fixed_event_handler+64/90>
> Trace; c0182c05 <acpi_ev_init_global_lock_handler+15/30>
> Trace; c0182ba0 <acpi_ev_global_lock_handler+0/50>
> Trace; c0182333 <acpi_ev_initialize+53/60>
> Trace; c017f4be <acpi_enable_subsystem+4e/90>
> Trace; c0191a27 <acpi_init+107/150>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105049 <init+9/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105516 <kernel_thread+26/30>
> Trace; c0105040 <init+0/140>
> Code;  c0111d4d <schedule+35d/370>
> 00000000 <_EIP>:
> Code;  c0111d4d <schedule+35d/370>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0111d4f <schedule+35f/370>
>    2:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
> Code;  c0111d52 <schedule+362/370>
>    5:   5b                        pop    %ebx
> Code;  c0111d53 <schedule+363/370>
>    6:   5e                        pop    %esi
> Code;  c0111d54 <schedule+364/370>
>    7:   5f                        pop    %edi
> Code;  c0111d55 <schedule+365/370>
>    8:   5d                        pop    %ebp
> Code;  c0111d56 <schedule+366/370>
>    9:   c3                        ret
> Code;  c0111d57 <schedule+367/370>
>    a:   89 f6                     mov    %esi,%esi
> Code;  c0111d59 <schedule+369/370>
>    c:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
> Code;  c0111d60 <__wake_up+0/a0>
>   13:   55                        push   %ebp
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 
