Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKIWit>; Thu, 9 Nov 2000 17:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129148AbQKIWij>; Thu, 9 Nov 2000 17:38:39 -0500
Received: from napalm.go.cz ([212.24.148.98]:4356 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S129091AbQKIWi0>;
	Thu, 9 Nov 2000 17:38:26 -0500
Date: Thu, 9 Nov 2000 23:37:59 +0100
From: Jan Dvorak <johnydog@go.cz>
To: chaffee@cs.berkeley.edu
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 oops
Message-ID: <20001109233759.A489@napalm.go.cz>
Mail-Followup-To: chaffee@cs.berkeley.edu, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

attached oops came from writing to vfat fs. 

Jan Dvorak <johnydog@go.cz>



--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.3.5 on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
kernel BUG at file.c:79!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015b77b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000019   ebx: 00000000   ecx: c7cb4000   edx: 00000001
esi: 000ed9c8   edi: c058cae0   ebp: c796ba40   esp: c7cb5e5c
ds: 0018   es: 0018   ss: 0018
Process mc (pid: 310, stackpage=c7cb5000)
Stack: c02ae005 c02ae187 0000004f 00000000 00000200 1db39000 c7cb5eb4 c0134d38
       c058cae0 000ed9c8 c796ba40 00000001 00000000 00000000 1db39000 00000000
       c066a000 c796ba40 00000200 000ed9c8 00000000 c796ba40 c7f2697c 0000066a
Call trace: [<c02ae005>] [<c02ae187>] [<c0134d38>] [<c01352c9>] [<c015b6b4>] [<c015d04e>] [<c015b6b4>]
       [<c0128b98>] [<c0126b42>] [<c015b7ee>] [<c015b7c5>] [<c013255b>] [<c010b113>]
Code: 0f 0b 83 c4 0c 0f b7 47 20 66 89 45 0c 89 5d 04 80 4d 18 30

>>EIP; c015b77b <fat_get_block+c7/e4>   <=====
Trace; c02ae005 <tvecs+b59d/1fa78>
Trace; c02ae187 <tvecs+b71f/1fa78>
Trace; c0134d38 <__block_prepare_write+f4/248>
Trace; c01352c9 <cont_prepare_write+18d/230>
Trace; c015b6b4 <fat_get_block+0/e4>
Trace; c015d04e <fat_prepare_write+26/2c>
Trace; c015b6b4 <fat_get_block+0/e4>
Trace; c0128b98 <generic_file_write+2a4/3dc>
Trace; c0126b42 <do_generic_file_read+236/544>
Trace; c015b7ee <default_fat_file_write+22/58>
Trace; c015b7c5 <fat_file_write+2d/34>
Trace; c013255b <sys_write+8f/c4>
Trace; c010b113 <system_call+33/38>
Code;  c015b77b <fat_get_block+c7/e4>
00000000 <_EIP>:
Code;  c015b77b <fat_get_block+c7/e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015b77d <fat_get_block+c9/e4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c015b780 <fat_get_block+cc/e4>
   5:   0f b7 47 20               movzwl 0x20(%edi),%eax
Code;  c015b784 <fat_get_block+d0/e4>
   9:   66 89 45 0c               mov    %ax,0xc(%ebp)
Code;  c015b788 <fat_get_block+d4/e4>
   d:   89 5d 04                  mov    %ebx,0x4(%ebp)
Code;  c015b78b <fat_get_block+d7/e4>
  10:   80 4d 18 30               orb    $0x30,0x18(%ebp)


1 warning issued.  Results may not be reliable.

--tThc/1wpZn/ma/RB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
