Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269410AbUJLA41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269410AbUJLA41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUJLAyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:54:16 -0400
Received: from mail.conectcor.com.br ([200.208.220.172]:57993 "EHLO
	mail.conectcor.com.br") by vger.kernel.org with ESMTP
	id S269417AbUJLAoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:44:02 -0400
Message-ID: <416B28CC.9070803@michel.eti.br>
Date: Mon, 11 Oct 2004 21:43:56 -0300
From: Michel Angelo da Silva Pereira <michel@michel.eti.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041006
X-Accept-Language: pt-br, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4-mm1 - Some OOPS
Content-Type: multipart/mixed;
 boundary="------------030508070803070204060804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030508070803070204060804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

	Get the attached OOPs when running mozilla and liferea with the new kernel.

Linux nerdbook 2.6.9-rc4-mm1 #2 Sat Jun 5 23:21:43 BRT 2004 i686 unknown

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      0.9.15-pre4
e2fsprogs              1.35
reiserfsprogs          3.6.18
reiser4progs           line
pcmcia-cs              3.2.7
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.6
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               2.0
Modules Loaded         snd_mixer_oss microcode md5 ipv6 ppp_synctty ppp_async pp
p_generic slhc ipt_MASQUERADE iptable_nat ip_conntrack ip_tables snd_es1938 snd_
pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore 3c589_cs ds yenta_socket pcmcia_core


-- 
http://www.michel.eti.br

--------------030508070803070204060804
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

** When booting

Device 'i823650' does not have a release() function, it is broken and must be fixed.
Badness in device_release at drivers/base/core.c:85
 [<c01c5df8>] kobject_cleanup+0x98/0xa0
 [<c01c5e00>] kobject_release+0x0/0x10
 [<c01c6559>] kref_put+0x39/0xa0
 [<c01c5e2f>] kobject_put+0x1f/0x30
 [<c01c5e2f>] kobject_put+0x1f/0x30
 [<c01c5e00>] kobject_release+0x0/0x10
 [<ca8ec333>] init_i82365+0x1c3/0x1d9 [i82365]
 [<c0134464>] sys_init_module+0x1d4/0x2a0
 [<c010518f>] syscall_call+0x7/0xb

** When starting mozilla 1.8.5a

Unable to handle kernel paging request at virtual address 00013d9c
 printing eip:
c011c5b6
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: snd_mixer_oss microcode md5 ipv6 ppp_synctty ppp_async crc_ccitt ppp_generic slhc ipt_MASQUERADE iptable_nat ip_conntrack ip_tables snd_es1938 snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c589_cs ds yenta_socket pcmcia_core
CPU:    0
EIP:    0060:[<c011c5b6>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1ass) 
EIP is at profile_hit+0x26/0x30
eax: 00013d9c   ebx: c3de4020   ecx: 00000000   edx: 00000000
esi: ffffffea   edi: 00000000   ebp: c3e87fbc   esp: c3e87f8c
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 2681, threadinfo=c3e86000 task=c3de4020)
Stack: c011875e 00000002 c010518f 00000004 c03af9e0 c01189dc bffff588 00200082 
       00000000 00000a79 400f7b00 400f4a40 c3e86000 c010518f 00000a79 00000000 
       bffff588 400f7b00 400f4a40 bffff568 0000009c 0000007b 0000007b 0000009c 
Call Trace:
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c01189dc>] sys_sched_getparam+0x6c/0xc0
 [<c010518f>] syscall_call+0x7/0xb
Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 6c 4c 3b c0 8b 15 68 4c 3b c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 64 4c 3b c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d 76 00 8d bc 
 <6>note: mozilla-bin[2681] exited with preempt_count 2
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c01191fd>] __might_sleep+0x9d/0xb0
 [<c011bb17>] printk+0x17/0x20
 [<c011db9c>] do_exit+0x9c/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0148080>] handle_mm_fault+0xe0/0x180
 [<c011653c>] do_page_fault+0x1fc/0x650
 [<c0117e70>] scheduler_tick+0x170/0x470
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c01189dc>] sys_sched_getparam+0x6c/0xc0
 [<c010518f>] syscall_call+0x7/0xb
scheduling while atomic: mozilla-bin/0x04000002/2681
 [<c02c5382>] schedule+0x542/0x550
 [<c0146283>] unmap_page_range+0x53/0x80
 [<c02c581d>] cond_resched+0x2d/0x50
 [<c0146455>] unmap_vmas+0x1a5/0x200
 [<c014af2e>] exit_mmap+0x7e/0x160
 [<c01195e4>] mmput+0x34/0xc0
 [<c011dbfb>] do_exit+0xfb/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0148080>] handle_mm_fault+0xe0/0x180
 [<c011653c>] do_page_fault+0x1fc/0x650
 [<c0117e70>] scheduler_tick+0x170/0x470
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c01189dc>] sys_sched_getparam+0x6c/0xc0
 [<c010518f>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 00013d9c
 printing eip:
c011c5b6
*pde = 00000000
Oops: 0002 [#2]
PREEMPT 
Modules linked in: snd_mixer_oss microcode md5 ipv6 ppp_synctty ppp_async crc_ccitt ppp_generic slhc ipt_MASQUERADE iptable_nat ip_conntrack ip_tables snd_es1938 snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c589_cs ds yenta_socket pcmcia_core
CPU:    0
EIP:    0060:[<c011c5b6>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1ass) 
EIP is at profile_hit+0x26/0x30
eax: 00013d9c   ebx: c3e79060   ecx: 00000000   edx: 00000000
esi: ffffffea   edi: 00000000   ebp: c3e1bfbc   esp: c3e1bf8c
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 2689, threadinfo=c3e1a000 task=c3e79060)
Stack: c011875e 00000002 c010518f 00000004 c03af9e0 c01189dc bffff588 00200086 
       00000000 00000a81 400f7b00 400f4a40 c3e1a000 c010518f 00000a81 00000000 
       bffff588 400f7b00 400f4a40 bffff568 0000009c 0000007b 0000007b 0000009c 
Call Trace:
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c01189dc>] sys_sched_getparam+0x6c/0xc0
 [<c010518f>] syscall_call+0x7/0xb
Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 6c 4c 3b c0 8b 15 68 4c 3b c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 64 4c 3b c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d 76 00 8d bc 
 <6>note: mozilla-bin[2689] exited with preempt_count 2
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c01191fd>] __might_sleep+0x9d/0xb0
 [<c011bb17>] printk+0x17/0x20
 [<c011db9c>] do_exit+0x9c/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0117752>] activate_task+0x62/0x80
 [<c01178b8>] wake_up_state+0x18/0x20
 [<c01258f2>] signal_wake_up+0x22/0x30
 [<c012630e>] __group_send_sig_info+0x8e/0xc0
 [<c0126480>] group_send_sig_info+0xa0/0xb0
 [<c0123df4>] __mod_timer+0x134/0x1a0
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c01189dc>] sys_sched_getparam+0x6c/0xc0
 [<c010518f>] syscall_call+0x7/0xb
scheduling while atomic: mozilla-bin/0x04000002/2689
 [<c02c5382>] schedule+0x542/0x550
 [<c0146283>] unmap_page_range+0x53/0x80
 [<c02c581d>] cond_resched+0x2d/0x50
 [<c0146455>] unmap_vmas+0x1a5/0x200
 [<c014af2e>] exit_mmap+0x7e/0x160
 [<c01195e4>] mmput+0x34/0xc0
 [<c011dbfb>] do_exit+0xfb/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0117752>] activate_task+0x62/0x80
 [<c01178b8>] wake_up_state+0x18/0x20
 [<c01258f2>] signal_wake_up+0x22/0x30
 [<c012630e>] __group_send_sig_info+0x8e/0xc0
 [<c0126480>] group_send_sig_info+0xa0/0xb0
 [<c0123df4>] __mod_timer+0x134/0x1a0
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c01189dc>] sys_sched_getparam+0x6c/0xc0
 [<c010518f>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 00013d9c
 printing eip:
c011c5b6
*pde = 00000000
Oops: 0002 [#3]
PREEMPT 
Modules linked in: snd_mixer_oss microcode md5 ipv6 ppp_synctty ppp_async crc_ccitt ppp_generic slhc ipt_MASQUERADE iptable_nat ip_conntrack ip_tables snd_es1938 snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c589_cs ds yenta_socket pcmcia_core
CPU:    0
EIP:    0060:[<c011c5b6>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1ass) 
EIP is at profile_hit+0x26/0x30
eax: 00013d9c   ebx: c3e79550   ecx: 00000000   edx: 00000000
esi: ffffffea   edi: 00000000   ebp: c5147fbc   esp: c5147f8c
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 2705, threadinfo=c5146000 task=c3e79550)
Stack: c011875e 00000002 c010518f 00000004 c03af9e0 402c5260 00200046 00200086 
       00000000 00000a91 400f7b00 400f4a40 c5146000 c010518f 00000a91 00000000 
       bffff408 400f7b00 400f4a40 bffff3e8 0000009c 0000007b 0000007b 0000009c 
Call Trace:
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c010518f>] syscall_call+0x7/0xb
Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 6c 4c 3b c0 8b 15 68 4c 3b c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 64 4c 3b c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d 76 00 8d bc 
 <6>note: mozilla-bin[2705] exited with preempt_count 2
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c01191fd>] __might_sleep+0x9d/0xb0
 [<c011bb17>] printk+0x17/0x20
 [<c011db9c>] do_exit+0x9c/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0148080>] handle_mm_fault+0xe0/0x180
 [<c011653c>] do_page_fault+0x1fc/0x650
 [<c0117d1f>] scheduler_tick+0x1f/0x470
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c010518f>] syscall_call+0x7/0xb
scheduling while atomic: mozilla-bin/0x04000002/2705
 [<c02c5382>] schedule+0x542/0x550
 [<c0146283>] unmap_page_range+0x53/0x80
 [<c02c581d>] cond_resched+0x2d/0x50
 [<c0146455>] unmap_vmas+0x1a5/0x200
 [<c014af2e>] exit_mmap+0x7e/0x160
 [<c01195e4>] mmput+0x34/0xc0
 [<c011dbfb>] do_exit+0xfb/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0148080>] handle_mm_fault+0xe0/0x180
 [<c011653c>] do_page_fault+0x1fc/0x650
 [<c0117d1f>] scheduler_tick+0x1f/0x470
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c010518f>] syscall_call+0x7/0xb
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled on user request.
Unable to handle kernel paging request at virtual address 00013d9c
 printing eip:
c011c5b6
*pde = 00000000
Oops: 0002 [#4]
PREEMPT 
Modules linked in: snd_mixer_oss microcode md5 ipv6 ppp_synctty ppp_async crc_ccitt ppp_generic slhc ipt_MASQUERADE iptable_nat ip_conntrack ip_tables snd_es1938 snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c589_cs ds yenta_socket pcmcia_core
CPU:    0
EIP:    0060:[<c011c5b6>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1ass) 
EIP is at profile_hit+0x26/0x30
eax: 00013d9c   ebx: c0042a60   ecx: 00000000   edx: 00000000
esi: ffffffea   edi: 00000000   ebp: c0047fbc   esp: c0047f8c
ds: 007b   es: 007b   ss: 0068
Process liferea-bin (pid: 2799, threadinfo=c0046000 task=c0042a60)
Stack: c011875e 00000002 c010518f 00000004 c03af9e0 0000226b c03afa10 00200086 
       00000000 00000aef bf7ffbe0 00000000 c0046000 c010518f 00000aef 00000000 
       bf7ffcf8 bf7ffbe0 00000000 bf7ffbcc 0000009c c010007b 0000007b 0000009c 
Call Trace:
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c010518f>] syscall_call+0x7/0xb
Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 6c 4c 3b c0 8b 15 68 4c 3b c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 64 4c 3b c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d 76 00 8d bc 
 <6>note: liferea-bin[2799] exited with preempt_count 2
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c01191fd>] __might_sleep+0x9d/0xb0
 [<c011bb17>] printk+0x17/0x20
 [<c011db9c>] do_exit+0x9c/0x440
 [<c010635d>] die+0x18d/0x190
 [<c011bb17>] printk+0x17/0x20
 [<c011669c>] do_page_fault+0x35c/0x650
 [<c0117f1a>] scheduler_tick+0x21a/0x470
 [<c0116340>] do_page_fault+0x0/0x650
 [<c0105b99>] error_code+0x2d/0x38
 [<c01c007b>] find_undo+0x21b/0x2f0
 [<c011c5b6>] profile_hit+0x26/0x30
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c010518f>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 00013d9c
 printing eip:
c011c5b6
*pde = 00000000
Oops: 0002 [#5]
PREEMPT 
Modules linked in: snd_mixer_oss microcode md5 ipv6 ppp_synctty ppp_async crc_ccitt ppp_generic slhc ipt_MASQUERADE iptable_nat ip_conntrack ip_tables snd_es1938 snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c589_cs ds yenta_socket pcmcia_core
CPU:    0
EIP:    0060:[<c011c5b6>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1ass) 
EIP is at profile_hit+0x26/0x30
eax: 00013d9c   ebx: c0042570   ecx: 00000000   edx: 00000000
esi: ffffffea   edi: 00000000   ebp: c0049fbc   esp: c0049f8c
ds: 007b   es: 007b   ss: 0068
Process liferea-bin (pid: 2800, threadinfo=c0048000 task=c0042570)
Stack: c011875e 00000002 c010518f 00000004 c03af9e0 fffbfeef fffffffe 00200082 
       00000000 00000af0 bf5ffbe0 00000000 c0048000 c010518f 00000af0 00000000 
       bf5ffcf8 bf5ffbe0 00000000 bf5ffbcc 0000009c c010007b 0000007b 0000009c 
Call Trace:
 [<c011875e>] setscheduler+0xae/0x210
 [<c010518f>] syscall_call+0x7/0xb
 [<c010518f>] syscall_call+0x7/0xb
Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 6c 4c 3b c0 8b 15 68 4c 3b c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 64 4c 3b c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d 76 00 8d bc 
 <6>note: liferea-bin[2800] exited with preempt_count 2

--------------030508070803070204060804
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc4-mm1
# Mon Oct 11 15:47:34 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION="ass"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_KOBJECT_UEVENT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_THINKPAD=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
CONFIG_ARPD=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_RAW=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
CONFIG_SND_ES1938=m
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------030508070803070204060804--
