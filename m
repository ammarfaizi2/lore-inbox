Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSKERt6>; Tue, 5 Nov 2002 12:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSKERt6>; Tue, 5 Nov 2002 12:49:58 -0500
Received: from [64.76.155.18] ([64.76.155.18]:35803 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S265096AbSKERtu>;
	Tue, 5 Nov 2002 12:49:50 -0500
Date: Tue, 5 Nov 2002 14:56:24 -0300 (CLST)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops when loading e100 module
Message-ID: <Pine.LNX.4.44.0211051450490.12033-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm getting this oops when loading e100 module, the weird thing is that 
the module oopses when I boot in runlevel 3, booting in runlevel 1 and 
then going to runlevel 3 works ok. I thought it was related to PnP, 
but I've recompiled without PnP support and the oops still ocurs. oops 
decoded follows, more information can be posted upon request. 

Best regards

ksymoops 2.4.5 on i686 2.5.46.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.46/ (default)
     -m /boot/System.map-2.5.46 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol fbcon_accel_R__ver_fbcon_accel not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_bmove_R__ver_fbcon_accel_bmove not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_clear_R__ver_fbcon_accel_clear not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_clear_margins_R__ver_fbcon_accel_clear_margins not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_putc_R__ver_fbcon_accel_putc not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_putcs_R__ver_fbcon_accel_putcs not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_revc_R__ver_fbcon_accel_revc not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_accel_setup_R__ver_fbcon_accel_setup not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_R__ver_fbcon_cfb24 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_bmove_R__ver_fbcon_cfb24_bmove not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_clear_R__ver_fbcon_cfb24_clear not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_clear_margins_R__ver_fbcon_cfb24_clear_margins not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_putc_R__ver_fbcon_cfb24_putc not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_putcs_R__ver_fbcon_cfb24_putcs not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_revc_R__ver_fbcon_cfb24_revc not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol fbcon_cfb24_setup_R__ver_fbcon_cfb24_setup not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol page_states__per_cpu_R__ver_page_states__per_cpu not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000002
d0878e34
*pde = 00000000
Oops: 0002
e100 iptable_filter ip_tables microcode ide-cd cdrom rtc  
CPU:    0
EIP:    0060:[<d0878e34>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000002   ebx: cec7fe1a   ecx: d5110038   edx: d088200e
esi: ced7f160   edi: 00000000   ebp: 00000001   esp: cec7fe04
ds: 0068   es: 0068   ss: 0068
Stack: d088200e d0878ae0 ced7f160 00000006 00000003 00020000 ced7f160 ced7f000 
       00000000 cfde2000 d08712e9 ced7f160 ced7f160 00000000 cfde2000 d0870a00 
       ced7f160 d08711e3 ced7f160 0000ffff 00000006 00000000 00000000 ced7f160 
 [<d0878ae0>] e100_eeprom_size+0x140/0x2b0 [e100]
 [<d08712e9>] e100_sw_init+0x29/0x50 [e100]
 [<d0870a00>] e100_check_options+0x250/0x2b0 [e100]
 [<d08711e3>] e100_init+0x23/0x100 [e100]
 [<d0870367>] e100_found1+0x167/0x420 [e100]
 [<d087f0c5>] e100_driver_version+0x0/0xb [e100]
 [<d087f100>] e100_driver+0x0/0xa0 [e100]
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<c01de16e>] pci_device_probe+0x5e/0x70
 [<d087e308>] e100_id_table+0x348/0x10bc [e100]
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<c022a765>] bus_match+0x45/0x70
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<c022a8a2>] driver_attach+0x72/0x90
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<d087f13c>] e100_driver+0x3c/0xa0 [e100]
 [<c022abbc>] bus_add_driver+0x6c/0x90
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<d087be98>] .rodata.str1.1+0x171/0x20d9 [e100]
 [<d087f14c>] e100_driver+0x4c/0xa0 [e100]
 [<c022b2e1>] driver_register+0x91/0xa0
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<c01de2a7>] pci_register_driver+0x47/0x60
 [<d087f128>] e100_driver+0x28/0xa0 [e100]
 [<d0870729>] init_module+0x19/0x70 [e100]
 [<d087f100>] e100_driver+0x0/0xa0 [e100]
 [<c011f031>] sys_init_module+0x4e1/0x640
 [<d0870060>] e100_wait_scb+0x0/0xa0 [e100]
 [<d0870060>] e100_wait_scb+0x0/0xa0 [e100]
 [<c010b023>] syscall_call+0x7/0xb
Code: 00 00 57 56 53 83 ec 10 8b 74 24 24 0f b7 4c 24 64 f1 87 d0 


>>EIP; d0878e34 <[e100]shift_out_bits+4/120>   <=====

>>ebx; cec7fe1a <_end+e7decc2/10366f08>
>>ecx; d5110038 <END_OF_CODE+488a1d5/????>
>>edx; d088200e <[e100].bss.end+1afb/3b4d>
>>esi; ced7f160 <_end+e8de008/10366f08>
>>esp; cec7fe04 <_end+e7decac/10366f08>

Code;  d0878e34 <[e100]shift_out_bits+4/120>
00000000 <_EIP>:
Code;  d0878e34 <[e100]shift_out_bits+4/120>   <=====
   0:   00 00                     add    %al,(%eax)   <=====
Code;  d0878e36 <[e100]shift_out_bits+6/120>
   2:   57                        push   %edi
Code;  d0878e37 <[e100]shift_out_bits+7/120>
   3:   56                        push   %esi
Code;  d0878e38 <[e100]shift_out_bits+8/120>
   4:   53                        push   %ebx
Code;  d0878e39 <[e100]shift_out_bits+9/120>
   5:   83 ec 10                  sub    $0x10,%esp
Code;  d0878e3c <[e100]shift_out_bits+c/120>
   8:   8b 74 24 24               mov    0x24(%esp,1),%esi
Code;  d0878e40 <[e100]shift_out_bits+10/120>
   c:   0f b7 4c 24 64            movzwl 0x64(%esp,1),%ecx
Code;  d0878e45 <[e100]shift_out_bits+15/120>
  11:   f1                        (bad)  
Code;  d0878e46 <[e100]shift_out_bits+16/120>
  12:   87 d0                     xchg   %edx,%eax


18 warnings issued.  Results may not be reliable.
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

