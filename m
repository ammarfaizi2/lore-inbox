Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbQLLEqg>; Mon, 11 Dec 2000 23:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbQLLEqR>; Mon, 11 Dec 2000 23:46:17 -0500
Received: from pulsar.ucolick.org ([128.114.22.166]:49681 "EHLO
	pulsar.ucolick.org") by vger.kernel.org with ESMTP
	id <S131163AbQLLEqI>; Mon, 11 Dec 2000 23:46:08 -0500
Date: Mon, 11 Dec 2000 20:15:33 -0800
From: Walter Brisken <walterfb@pulsar.ucolick.org>
Message-Id: <200012120415.UAA31071@pulsar.ucolick.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] x2 Kernel 2.2.16 on Athlon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the writing of a CDRW, I had a pair of oopses.  System uptime was
48 days, CD writing has never failed before.  Below are the OOPSes after
being passed through ksymoops 2.3.5 .  If anything interesting comes of
this, I'd be interested in hearing it, so could you cc me any replies?
The Kernel is RedHats 2.2.16-1.

		Thanks,

		Walter

OOPS #1 -------------------------------------------------

ksymoops 2.3.5 on i686 2.2.16-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-1/ (default)
     -m /boot/System.map-2.2.16-1 (specified)

Unable to handle kernel paging request at virtual address 00dfe168
current->tss.cr3 = 00101000, %%cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[find_vma+62/100]
EFLAGS: 00210206
eax: 00dfe160   ebx: cf02ada0   ecx: 00000000   edx: cbdfee60
esi: 00000000   edi: ce21a000   ebp: 00000030   esp: cffc7f8c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, process nr: 5, stackpage=cffc7000)
Stack: cf02ada0 00000000 ce21a000 00000000 000001f5 00000006 c012222b ce21a000
       00000030 00000006 00000006 00000030 00000008 cd1c09c0 c01222a2 00000006
       00000030 cffc6000 c01d8eee cffc61c1 c0122337 00000030 00000f00 cffebfc0
Call Trace: [swap_out+171/204] [do_try_to_free_pages+86/120] [tvecs+7374/13920] [kswapd+115/180] [get_options+0/116] [kernel_thread+35/48]
Code: 39 48 08 76 0d 89 c2 39 4a 04 76 0e 8b 42 18 eb eb 90 8b 40
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  00000003 Before first symbol
   3:   76 0d                     jbe    12 <_EIP+0x12> 00000012 Before first symbol
Code;  00000005 Before first symbol
   5:   89 c2                     mov    %eax,%edx
Code;  00000007 Before first symbol
   7:   39 4a 04                  cmp    %ecx,0x4(%edx)
Code;  0000000a Before first symbol
   a:   76 0e                     jbe    1a <_EIP+0x1a> 0000001a Before first symbol
Code;  0000000c Before first symbol
   c:   8b 42 18                  mov    0x18(%edx),%eax
Code;  0000000f Before first symbol
   f:   eb eb                     jmp    fffffffc <_EIP+0xfffffffc> fffffffc <END_OF_CODE+2ff443cd/????>
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   8b 40 00                  mov    0x0(%eax),%eax


OOPS #2 -------------------------------------------------

ksymoops 2.3.5 on i686 2.2.16-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-1/ (default)
     -m /boot/System.map-2.2.16-1 (specified)

Unable to handle kernel paging request at virtual address 00dfe168
current->tss.cr3 = 0d750000, %%cr3 = 0d750000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[find_vma+62/100]
EFLAGS: 00013206
eax: 00dfe160   ebx: cf02ada0   ecx: 00000000   edx: cbdfee60
esi: 00000000   edi: ce21a000   ebp: 00000015   esp: c0b53e90
ds: 0018   es: 0018   ss: 0018
Process X (pid: 15004, process nr: 43, stackpage=c0b53000)
Stack: cf02ada0 00000000 ce21a000 00000000 000001f5 0000000d c012222b ce21a000
       00000015 00000006 00000006 00000015 0000002a cd1c09c0 c01222a2 00000006
       00000015 00000001 00000015 00000015 c01223a0 00000015 c0b52000 00000080
Call Trace: [swap_out+171/204] [do_try_to_free_pages+86/120] [try_to_free_pages+40/52] [__get_free_pages+180/1020] [alloc_wait+20/152] [do_select+82/516] [sys_select+1014/1360] [system_call+52/56]
Code: 39 48 08 76 0d 89 c2 39 4a 04 76 0e 8b 42 18 eb eb 90 8b 40
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  00000003 Before first symbol
   3:   76 0d                     jbe    12 <_EIP+0x12> 00000012 Before first symbol
Code;  00000005 Before first symbol
   5:   89 c2                     mov    %eax,%edx
Code;  00000007 Before first symbol
   7:   39 4a 04                  cmp    %ecx,0x4(%edx)
Code;  0000000a Before first symbol
   a:   76 0e                     jbe    1a <_EIP+0x1a> 0000001a Before first symbol
Code;  0000000c Before first symbol
   c:   8b 42 18                  mov    0x18(%edx),%eax
Code;  0000000f Before first symbol
   f:   eb eb                     jmp    fffffffc <_EIP+0xfffffffc> fffffffc <END_OF_CODE+2ff443cd/????>
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   8b 40 00                  mov    0x0(%eax),%eax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
