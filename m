Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSE3Sk0>; Thu, 30 May 2002 14:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSE3SkZ>; Thu, 30 May 2002 14:40:25 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:46976 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S316820AbSE3SkX>; Thu, 30 May 2002 14:40:23 -0400
Date: Thu, 30 May 2002 11:40:12 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops Oops and more Oops 2.5.19
Message-ID: <20020530184012.GA1902@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.5.19 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy all! 
I been having all sorts of fun with the latest dozen or so kernels, and I thought
I might share some reports, as allways I am will to try patches, be flamed  share ad-
dtional information etc.

This oops is on bootup when I enable acpi
The system is a Athlon system with a via 266a chipset from Asus.


ksymoops 2.4.5 on i686 2.5.15.  Options used
     -v /usr/src/linux-2.5.19-debug/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.15/ (default)
     -m /usr/src/linux-2.5.19-debug/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel Null pointer dereference at virtual address 00000016
c019a847
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c019a847>]  not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 00000000   ebx: cffb2b40     ecx: effbcc00       edx: 00000088
esi: 00000004   edi: 00000008     ebp: effb2b40       esp: c16e5dcc
ds: 0018   es:0018    ss: 0018
Stack: effb2b40 c16ccbc0 00000000 effbcc00 0000000b c019dc2c effbcc00 effb2b40
       c16e5e00 effbcdb0 effbcc00 effbcdb0 00000000 00000000 c019dd51 effbcdb0
       effbcc00 00000001 c16ccbc0 c019e13b effbcdb0 effbcc00 effeb540 c16ccfc0
Call Trace: [<c019dc2c>] [<c019dd51>] [c019e13b>] [<c01960b9>] [<c0196c12>]        [<c01a3035>] [<c01a9307>] [<c01a33fd>] [<c01a341a>] [<c0195cb6>] [<c0195dca>]
   [<c01a078d>] [<c01a188a>] [<c01a06f0>] [<c01a1fbd>] [<c01a06f0>] [<c01a06a6>]
   [<c01a06f0>] [<c01a9aa3>] [<c0105027>] [<c0106fb8>]
Code: 8a 50 16 80 e2 04 b8 04 00 00 00 84 d2 0f 45 f8 39 fe 76 56


>>EIP; c019a847 <acpi_ex_read_data_from_field+57/150>   <=====

>>ebx; cffb2b40 <END_OF_CODE+fc5a52c/????>
>>ecx; effbcc00 <END_OF_CODE+2fc645ec/????>
>>ebp; effb2b40 <END_OF_CODE+2fc5a52c/????>
>>esp; c16e5dcc <END_OF_CODE+138d7b8/????>

Trace; c019dc2c <acpi_ex_resolve_node_to_value+bc/1a0>
Trace; c019dd51 <acpi_ex_resolve_to_value+41/50>
Trace; c01a078d <acpi_ns_init_one_object+9d/e0>
Trace; c01a188a <acpi_ns_walk_namespace+8a/110>
Trace; c01a06f0 <acpi_ns_init_one_object+0/e0>
Trace; c01a1fbd <acpi_walk_namespace+4d/70>
Trace; c01a06f0 <acpi_ns_init_one_object+0/e0>
Trace; c01a06a6 <acpi_ns_initialize_objects+26/30>
Trace; c01a06f0 <acpi_ns_init_one_object+0/e0>
Trace; c01a9aa3 <acpi_enable_subsystem+63/80>
Trace; c0105027 <init+7/120>
Trace; c0106fb8 <kernel_thread+28/40>

Code;  c019a847 <acpi_ex_read_data_from_field+57/150>
00000000 <_EIP>:
Code;  c019a847 <acpi_ex_read_data_from_field+57/150>   <=====
   0:   8a 50 16                  mov    0x16(%eax),%dl   <=====
Code;  c019a84a <acpi_ex_read_data_from_field+5a/150>
   3:   80 e2 04                  and    $0x4,%dl
Code;  c019a84d <acpi_ex_read_data_from_field+5d/150>
   6:   b8 04 00 00 00            mov    $0x4,%eax
Code;  c019a852 <acpi_ex_read_data_from_field+62/150>
   b:   84 d2                     test   %dl,%dl
Code;  c019a854 <acpi_ex_read_data_from_field+64/150>
   d:   0f 45 f8                  cmovne %eax,%edi
Code;  c019a857 <acpi_ex_read_data_from_field+67/150>
  10:   39 fe                     cmp    %edi,%esi
Code;  c019a859 <acpi_ex_read_data_from_field+69/150>
  12:   76 56                     jbe    6a <_EIP+0x6a> c019a8b1 <acpi_ex_read_data_from_field+c1/150>

 <0>Kernel panic: Attempted to kill init!


If I disable acpi I get these messages in dmsg 
And my system appears to run fairly slow but stablely.


PCI: IRQ 14 for device 00:11.3 doesn't match PIRQ mask - try pci=usepirqmask

If I add this to my lilo.conf append="pci=usepirqmask" I get another kind of oops.

ksymoops 2.4.5 on i686 2.5.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.19/ (default)
     -m /usr/src/linux-2.5.19/System.map (specified)

May 30 08:46:54 the-penguin kernel: kernel BUG at usb.c:987!
May 30 08:46:54 the-penguin kernel: invalid operand: 0000
May 30 08:46:54 the-penguin kernel: CPU:    0
May 30 08:46:54 the-penguin kernel: EIP:    0010:[usb_free_dev+38/96]    Not tainted
May 30 08:46:54 the-penguin kernel: EFLAGS: 00010246
May 30 08:46:54 the-penguin kernel: eax: 00000000   ebx: ef189000   ecx: effabee4   edx: c16cd240
May 30 08:46:54 the-penguin kernel: esi: efd11e80   edi: c02c11a4   ebp: ffffffff   esp: ed799f4c
May 30 08:46:54 the-penguin kernel: ds: 0018   es: 0018   ss: 0018
May 30 08:46:54 the-penguin kernel: Stack: ef1891f8 c01fb424 ef189000 efd11d80 f08ce020 f08c8000 bfffed8c 000000c4 
May 30 08:46:54 the-penguin kernel:        ef189000 f08cc8ea ef18bb60 effaa800 c019084f effaa800 f08c8000 fffffff0 
May 30 08:46:54 the-penguin kernel:        f08cca8a f08ce020 c0117ff7 f08c8000 fffffff0 d67ee000 bfffed8c c0117387 
May 30 08:46:54 the-penguin kernel: Call Trace: [usb_disconnect+340/352] [<f08ce020>] [<f08cc8ea>] [pci_unregister_driver+4
May 30 08:46:54 the-penguin kernel:    [<f08ce020>] [free_module+23/160] [sys_delete_module+247/448] [syscall_call+7/11] 
May 30 08:46:54 the-penguin kernel: Code: 0f 0b db 03 54 6c 28 c0 8b 83 cc 00 00 00 8b 40 1c 53 8b 40 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; ef189000 <_end+2ee542ac/3056e2ac>
>>ecx; effabee4 <_end+2fc77190/3056e2ac>
>>edx; c16cd240 <_end+13984ec/3056e2ac>
>>esi; efd11e80 <_end+2f9dd12c/3056e2ac>
>>edi; c02c11a4 <sd_template+24/48>
>>ebp; ffffffff <END_OF_CODE+f6f9330/????>
>>esp; ed799f4c <_end+2d4651f8/3056e2ac>

Trace; f08ce020 <[ohci-hcd]hc_start+d0/160>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   db 03                     fildl  (%ebx)
Code;  00000004 Before first symbol
   4:   54                        push   %esp
Code;  00000005 Before first symbol
   5:   6c                        insb   (%dx),%es:(%edi)
Code;  00000006 Before first symbol
   6:   28 c0                     sub    %al,%al
Code;  00000008 Before first symbol
   8:   8b 83 cc 00 00 00         mov    0xcc(%ebx),%eax
Code;  0000000e Before first symbol
   e:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  00000011 Before first symbol
  11:   53                        push   %ebx
Code;  00000012 Before first symbol
  12:   8b 40 00                  mov    0x0(%eax),%eax




-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


