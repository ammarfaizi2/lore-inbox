Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289374AbSBGQoQ>; Thu, 7 Feb 2002 11:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289764AbSBGQoC>; Thu, 7 Feb 2002 11:44:02 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:6390 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S289374AbSBGQno>; Thu, 7 Feb 2002 11:43:44 -0500
Message-ID: <3C62AF01.B58441AF@oracle.com>
Date: Thu, 07 Feb 2002 17:44:49 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre2 oopses on boot
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like -pre1 did. I can decode the new oops but for the moment I'll
 simply repost the -pre1 one:

ksymoops 2.4.1 on i686 2.5.3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.4-pre1 (specified)
     -m /boot/System.map-2.5.4-pre1 (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c01a6418>]     Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cfd43048   ecx: 00000074   edx: cfd483c0
esi: c028e260   edi: fffffff4   ebp: cfd43048   esp: c13cbae4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c13cb000)
Stack: cfd43048 c13dda20 cfd48340 cfd43000 c01db079 cfd43048 c028e260 302e3030 
       cfd43000 00000001 01000007 cfd43000 00000007 cfd43000 cfd43000 c01d8b49 
       cfd43000 cfd431cc c01e3b66 cfd43000 c13ddaa0 cfd43000 37363534 0000000b 
 [<c01db079>] [<c01d8b49>] [<c01e3b66>] [<c01e0f04>] [<c01e0de9>]
 [<c01e2314>] [<c012e000>] [<c0115105>] [<c011f13b>] [<c01e164d>]
 [<c014e367>] [<c014e542>] [<c01df9e0>] [<c01ee610>] [<c0105000>]
 [<c0105030>] [<c0105000>] [<c0107186>] [<c0105020>]
Code: 0f 0b eb b5 8d 74 26 00 53 8b 5c 24 08 8b 54 24 0c 85 db 74

>>EIP; c01a6418 <device_create_file+68/70>   <=====
Code;  c01a6418 <device_create_file+68/70>
00000000 <_EIP>:
Code;  c01a6418 <device_create_file+68/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01a641a <device_create_file+6a/70>
   2:   eb b5                     jmp    ffffffb9 <_EIP+0xffffffb9> c01a63d1 <device_create_file+21/70>
Code;  c01a641c <device_create_file+6c/70>
   4:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01a6420 <device_remove_file+0/40>
   8:   53                        push   %ebx
Code;  c01a6421 <device_remove_file+1/40>
   9:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  c01a6425 <device_remove_file+5/40>
   d:   8b 54 24 0c               mov    0xc(%esp,1),%edx
Code;  c01a6429 <device_remove_file+9/40>
  11:   85 db                     test   %ebx,%ebx
Code;  c01a642b <device_remove_file+b/40>
  13:   74 00                     je     15 <_EIP+0x15> c01a642d <device_remove_file+d/40>


Thanks,

--alessandro

 "If your heart is a flame burning brightly
   you'll have light and you'll never be cold
  And soon you will know that you just grow / You're not growing old"
                              (Husker Du, "Flexible Flyer")
