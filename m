Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUGISMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUGISMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUGISMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:12:00 -0400
Received: from smtp0.libero.it ([193.70.192.33]:61402 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S265148AbUGISLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:11:53 -0400
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.6.7-mm7 and parport_pc
Date: Fri, 9 Jul 2004 19:40:11 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407091940.11425.jorge78@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.
I've got this oops after modprobe parport_pc...

------------------------------------------------------
root@D998:/home/io# tail -n 32 mess.txt
Jul  9 19:23:03 D998 kernel: parport: PnPBIOS parport detected.
Jul  9 19:23:03 D998 kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
Jul  9 19:23:03 D998 kernel: c010c7f3
Jul  9 19:23:03 D998 kernel: PREEMPT
Jul  9 19:23:03 D998 kernel: Modules linked in: parport_pc parport acpi 
thermal fan button processor ac battery slamr yenta_socket nls_iso8859_1 
nls_cp437 speedstep_lib freq_table snd_intel8x0 snd_ac97_codec snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart 
snd_rawmidi snd_seq_device evdev unix
Jul  9 19:23:03 D998 kernel: CPU:    0
Jul  9 19:23:03 D998 kernel: EIP:    0060:[dma_alloc_coherent+27/249]    
Tainted: P   VLI
Jul  9 19:23:03 D998 kernel: EFLAGS: 00210216   (2.6.7-mm7)
Jul  9 19:23:03 D998 kernel: EIP is at dma_alloc_coherent+0x1b/0xf9
Jul  9 19:23:03 D998 kernel: eax: 00000000   ebx: ffffffff   ecx: 00000fff   
edx: 00000000
Jul  9 19:23:03 D998 kernel: esi: d3e65800   edi: 00000004   ebp: 00000020   
esp: d428ee5c
Jul  9 19:23:03 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jul  9 19:23:03 D998 kernel: Process modprobe (pid: 4562, threadinfo=d428e000 
task=dda5f110)
Jul  9 19:23:03 D998 kernel: Stack: c0108525 00000007 d72cf3e0 e0c9a634 
c1535e00 d3e65800 00000004 d3e65824
Jul  9 19:23:03 D998 kernel:        e0c98913 00000000 00001000 d3e6581c 
00000020 c1535e00 d72cf3e0 d72cf400
Jul  9 19:23:03 D998 kernel:        ffffffff c149a800 00000003 00000378 
00000007 e0c99524 00000378 00000778
Jul  9 19:23:03 D998 kernel: Call Trace:
Jul  9 19:23:03 D998 kernel:  [request_irq+131/197] request_irq+0x83/0xc5
Jul  9 19:23:03 D998 kernel:  [__crc_agp_memory_reserved+4176199/8627286] 
parport_pc_probe_port+0x449/0x72e [parport_pc]
Jul  9 19:23:03 D998 kernel:  [__crc_agp_memory_reserved+4179288/8627286] 
parport_pc_pnp_probe+0xa4/0xdb [parport_pc]
Jul  9 19:23:03 D998 kernel:  [__crc_agp_memory_reserved+4179124/8627286] 
parport_pc_pnp_probe+0x0/0xdb [parport_pc]
Jul  9 19:23:03 D998 kernel:  [pnp_device_probe+111/164] 
pnp_device_probe+0x6f/0xa4
Jul  9 19:23:03 D998 kernel:  [bus_match+63/106] bus_match+0x3f/0x6a
Jul  9 19:23:03 D998 kernel:  [driver_attach+86/128] driver_attach+0x56/0x80
Jul  9 19:23:03 D998 kernel:  [bus_add_driver+145/175] 
bus_add_driver+0x91/0xaf
Jul  9 19:23:03 D998 kernel:  [driver_register+47/51] 
driver_register+0x2f/0x33
Jul  9 19:23:03 D998 kernel:  [pnp_register_driver+45/91] 
pnp_register_driver+0x2d/0x5b
Jul  9 19:23:03 D998 kernel:  [__crc_default_hwif_transport+1463856/1650103] 
parport_pc_find_ports+0x71/0x84 [parport_pc]
Jul  9 19:23:03 D998 kernel:  [__crc_default_hwif_transport+1464647/1650103] 
parport_pc_init+0xa0/0xa2 [parport_pc]
Jul  9 19:23:03 D998 kernel:  [sys_init_module+279/559] 
sys_init_module+0x117/0x22f
Jul  9 19:23:03 D998 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  9 19:23:03 D998 kernel: Code: ff ff ff 51 e8 ff 9f 0e 00 59 e9 68 ff ff 
ff 90 55 57 56 53 bb ff ff ff ff 83 ec 10 8b 4c 24 28 8b 44 24 24 8b 6c 24 30 
83 e9 01 <8b> b0 b8 00 00 00 c1 e9 0b 89 4c 24 0c 83 c3 01 d1 6c 24 0c 75


---------------------------------
oot@D998:/home/io# ksymoops <oops.txt
ksymoops 2.4.9 on i686 2.6.7-mm7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.7-mm7/ (default)
     -m /boot/System.map-2.6.7-mm7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jul  9 19:19:15 D998 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul  9 19:19:15 D998 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul  9 19:23:03 D998 kernel: c010c7f3
Jul  9 19:23:03 D998 kernel: CPU:    0
Jul  9 19:23:03 D998 kernel: EIP:    0060:[dma_alloc_coherent+27/249]    
Tainted: P   VLI
Jul  9 19:23:03 D998 kernel: EFLAGS: 00210216   (2.6.7-mm7)
Jul  9 19:23:03 D998 kernel: eax: 00000000   ebx: ffffffff   ecx: 00000fff   
edx: 00000000
Jul  9 19:23:03 D998 kernel: esi: d3e65800   edi: 00000004   ebp: 00000020   
esp: d428ee5c
Jul  9 19:23:03 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jul  9 19:23:03 D998 kernel: Stack: c0108525 00000007 d72cf3e0 e0c9a634 
c1535e00 d3e65800 00000004 d3e65824
Jul  9 19:23:03 D998 kernel:        e0c98913 00000000 00001000 d3e6581c 
00000020 c1535e00 d72cf3e0 d72cf400
Jul  9 19:23:03 D998 kernel:        ffffffff c149a800 00000003 00000378 
00000007 e0c99524 00000378 00000778
Jul  9 19:23:03 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>esi; d3e65800 <__crc_kcalloc+3d4fb/8501a>
>>esp; d428ee5c <__crc_nr_swap_pages+338f3/d0d8f>

Jul  9 19:23:03 D998 kernel: Code: ff ff ff 51 e8 ff 9f 0e 00 59 e9 68 ff ff 
ff 90 55 57 56 53 bb ff ff ff ff 83 ec 10 8b 4c 24 28 8b 44 24 24 8b 6c 24 30 
83 e9 01 <8b> b0 b8 00 00 00 c1 e9 0b 89 4c 24 0c 83 c3 01 d1 6c 24 0c 75
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   ff                        (bad)
Code;  ffffffd6 <__kernel_rt_sigreturn+1b96/????>
   1:   ff                        (bad)
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   ff 51 e8                  call   *0xffffffe8(%ecx)
Code;  ffffffda <__kernel_rt_sigreturn+1b9a/????>
   5:   ff 9f 0e 00 59 e9         lcall  *0xe959000e(%edi)
Code;  ffffffe0 <__kernel_rt_sigreturn+1ba0/????>
   b:   68 ff ff ff 90            push   $0x90ffffff
Code;  ffffffe5 <__kernel_rt_sigreturn+1ba5/????>
  10:   55                        push   %ebp
Code;  ffffffe6 <__kernel_rt_sigreturn+1ba6/????>
  11:   57                        push   %edi
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   56                        push   %esi
Code;  ffffffe8 <__kernel_rt_sigreturn+1ba8/????>
  13:   53                        push   %ebx
Code;  ffffffe9 <__kernel_rt_sigreturn+1ba9/????>
  14:   bb ff ff ff ff            mov    $0xffffffff,%ebx
Code;  ffffffee <__kernel_rt_sigreturn+1bae/????>
  19:   83 ec 10                  sub    $0x10,%esp
Code;  fffffff1 <__kernel_rt_sigreturn+1bb1/????>
  1c:   8b 4c 24 28               mov    0x28(%esp,1),%ecx
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  fffffff9 <__kernel_rt_sigreturn+1bb9/????>
  24:   8b 6c 24 30               mov    0x30(%esp,1),%ebp
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   83 e9 01                  sub    $0x1,%ecx
Code;  00000000 Before first symbol
  2b:   8b b0 b8 00 00 00         mov    0xb8(%eax),%esi
Code;  00000006 Before first symbol
  31:   c1 e9 0b                  shr    $0xb,%ecx
Code;  00000009 Before first symbol
  34:   89 4c 24 0c               mov    %ecx,0xc(%esp,1)
Code;  0000000d Before first symbol
  38:   83 c3 01                  add    $0x1,%ebx
Code;  00000010 Before first symbol
  3b:   d1 6c 24 0c               shrl   0xc(%esp,1)
Code;  00000014 Before first symbol
  3f:   75                        .byte 0x75


2 warnings and 1 error issued.  Results may not be reliable.
root@D998:/home/io#

TIA.
					
-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.

Mario "Jorge" Di Nitto --- [Linux Registered User #334335]
