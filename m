Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbRHASYm>; Wed, 1 Aug 2001 14:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbRHASYc>; Wed, 1 Aug 2001 14:24:32 -0400
Received: from ma-northadams1a-359.bur.adelphia.net ([24.52.175.103]:260 "EHLO
	ma-northadams1a-359.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S267892AbRHASYZ>; Wed, 1 Aug 2001 14:24:25 -0400
Date: Wed, 1 Aug 2001 14:25:10 -0400
From: Eric Buddington <eric@ma-northadams1a-359.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-ac3 panic on boot (acpi?)
Message-ID: <20010801142510.A61@ma-northadams1a-359.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I began to report this bug a couple weeks back, under 2.4.6-ac3, but left on vacation before
capturing and parsing the panic.

So here it is on 2.4.7-ac3. My system is a K6-2. Most kernel stuff is compiled as modules.
Kernel 2.4.3-ac3 does *not* exhibit this problem.

Thanks again to whoever implemented serial console support - I would
have spent a lot more time on this without it.

-Eric



ksymoops 2.4.1 on i586 2.4.3-ac3.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /packages/linux/2.4.7-ac3/k6/lib/modules/2.4.7-ac3 (specified)
     -m /packages/linux/2.4.7-ac3/k6/boot/System.map (specified)

No modules in ksyms, skipping objects
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113d5e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000018   ebx: c1218000   ecx: 00000001   edx: 00000001
esi: c1219dc0   edi: c0198840   ebp: c1219d84   esp: c1219d60
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1219000)
Stack: c0272716 c1219dc0 c1218000 00000000 c1218000 00000711 c1218000 c1219dc0 
       c0198840 c1219e7c c0106f25 00000711 c0192010 c7fa2460 c1219dc0 c0198840 
       c1219e7c 00000008 00000018 00000018 00000078 c01054ed 00000010 00000206 
Call Trace: [<c0198840>] [<c0106f25>] [<c0192010>] [<c0198840>] [<c01054ed>] 
   [<c019215e>] [<c0192010>] [<c019229c>] [<c019889a>] [<c0198840>] [<c019812f>] 
   [<c01980a8>] [<c01991db>] [<c0191afc>] [<c01082e9>] [<c0191af0>] [<c0108476>] 
   [<c010a67e>] [<c0191c3a>] [<c019b20a>] [<c019aced>] [<c019a947>] [<c0199a1d>] 
   [<c01993fe>] [<c01988c5>] [<c0198860>] [<c0197fa7>] [<c0194d30>] [<c01aa015>] 
   [<c0105000>] [<c0105053>] [<c0105000>] [<c01054f6>] [<c0105040>] 
Code: 0f 0b 8d 65 f4 5b 5e 5f 5d c3 8b 45 e8 c1 e0 05 05 00 35 31 

>>EIP; c0113d5e <schedule+4e/3a0>   <=====
Trace; c0198840 <acpi_ev_global_lock_thread+0/20>
Trace; c0106f25 <reschedule+5/10>
Trace; c0192010 <acpi_os_queue_exec+0/e0>
Trace; c0198840 <acpi_ev_global_lock_thread+0/20>
Trace; c01054ed <kernel_thread+1d/30>
Trace; c019215e <acpi_os_schedule_exec+6e/120>
Trace; c0192010 <acpi_os_queue_exec+0/e0>
Trace; c019229c <acpi_os_queue_for_execution+8c/160>
Trace; c019889a <acpi_ev_global_lock_handler+3a/50>
Trace; c0198840 <acpi_ev_global_lock_thread+0/20>
Trace; c019812f <acpi_ev_fixed_event_dispatch+3f/d0>
Trace; c01980a8 <acpi_ev_fixed_event_detect+58/a0>
Trace; c01991db <acpi_ev_sci_handler+1b/30>
Trace; c0191afc <acpi_irq+c/10>
Trace; c01082e9 <handle_IRQ_event+39/80>
Trace; c0191af0 <acpi_irq+0/10>
Trace; c0108476 <do_IRQ+56/a0>
Trace; c010a67e <call_do_IRQ+5/17>
Trace; c0191c3a <acpi_os_out16+a/10>
Trace; c019b20a <acpi_hw_low_level_write+19a/1b0>
Trace; c019aced <acpi_hw_register_write+9d/260>
Trace; c019a947 <acpi_hw_register_bit_access+2e7/3f0>
Trace; c0199a1d <acpi_enable_event+6d/c0>
Trace; c01993fe <acpi_install_fixed_event_handler+7e/a0>
Trace; c01988c5 <acpi_ev_init_global_lock_handler+15/30>
Trace; c0198860 <acpi_ev_global_lock_handler+0/50>
Trace; c0197fa7 <acpi_ev_initialize+47/60>
Trace; c0194d30 <acpi_enable_subsystem+60/b0>
Trace; c01aa015 <acpi_init+135/180>
Trace; c0105000 <_stext+0/0>
Trace; c0105053 <init+13/140>
Trace; c0105000 <_stext+0/0>
Trace; c01054f6 <kernel_thread+26/30>
Trace; c0105040 <init+0/140>
Code;  c0113d5e <schedule+4e/3a0>
00000000 <_EIP>:
Code;  c0113d5e <schedule+4e/3a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113d60 <schedule+50/3a0>
   2:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
Code;  c0113d63 <schedule+53/3a0>
   5:   5b                        pop    %ebx
Code;  c0113d64 <schedule+54/3a0>
   6:   5e                        pop    %esi
Code;  c0113d65 <schedule+55/3a0>
   7:   5f                        pop    %edi
Code;  c0113d66 <schedule+56/3a0>
   8:   5d                        pop    %ebp
Code;  c0113d67 <schedule+57/3a0>
   9:   c3                        ret    
Code;  c0113d68 <schedule+58/3a0>
   a:   8b 45 e8                  mov    0xffffffe8(%ebp),%eax
Code;  c0113d6b <schedule+5b/3a0>
   d:   c1 e0 05                  shl    $0x5,%eax
Code;  c0113d6e <schedule+5e/3a0>
  10:   05 00 35 31 00            add    $0x313500,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

