Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbQLUOsH>; Thu, 21 Dec 2000 09:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbQLUOrs>; Thu, 21 Dec 2000 09:47:48 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:29569 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S130139AbQLUOro>; Thu, 21 Dec 2000 09:47:44 -0500
Message-ID: <3A4210EC.EE3BB5B1@home.com>
Date: Thu, 21 Dec 2000 09:17:16 -0500
From: Arthur Pedyczak <arthur-p@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Problems in 2.4.0-test12
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I had been running 2.4.0-test12 for 7 days. Worked great. Then the
system just froze. No oopses,
no log entries, no telneting to the box, no SysRq. Hard reboot. Some 12
hrs. later I got the following Oops in xfs. At that time I was
installing Corel Photopaint and the install was going through fonts. The
oops is _NOT_ reproducible (after reboot installation went fine).

ksymoops 2.3.4 on i686 2.4.0-test12.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /usr/src/linux/System.map (specified)

Dec 21 00:44:22 cs865114-a kernel: Unable to handle kernel paging
request at virtual address 42e46ae0
Dec 21 00:44:22 cs865114-a kernel: c01411cc
Dec 21 00:44:22 cs865114-a kernel: *pde = 00000000
Dec 21 00:44:22 cs865114-a kernel: Oops: 0000
Dec 21 00:44:22 cs865114-a kernel: CPU:    0
Dec 21 00:44:22 cs865114-a kernel: EIP:    0010:[find_inode+28/72]
Dec 21 00:44:22 cs865114-a kernel: EFLAGS: 00010207
Dec 21 00:44:22 cs865114-a kernel: eax: 00000000   ebx: 42e46ac0   ecx:
0000001c   edx: 00000eee
Dec 21 00:44:22 cs865114-a kernel: esi: 42e46ac0   edi: 00000000   ebp:
000da680   esp: ce0f7e80
Dec 21 00:44:22 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Dec 21 00:44:22 cs865114-a kernel: Process xfs (pid: 637,
stackpage=ce0f7000)
Dec 21 00:44:22 cs865114-a kernel: Stack: 000da680 cffc7770 000da680
c1460600 c0141581 c1460600 000da680 cffc7770 
Dec 21 00:44:23 cs865114-a kernel:        00000000 00000000 000da680
ca80c260 ce066040 c3412f20 c014d14b c1460600 
Dec 21 00:44:23 cs865114-a kernel:        000da680 00000000 00000000
fffffff4 ca80c260 ce066040 c685a098 c013883a 
Dec 21 00:44:23 cs865114-a kernel: Call Trace: [iget4+69/204]
[ext2_lookup+95/140] [real_lookup+82/192] [path_walk+1381/1964]
[sock_recvmsg+61/172] [<f28ebd75>] [open_namei+128/1388] 
Dec 21 00:44:23 cs865114-a kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39
86 8c 00 00 00 75 e3 85 ff 74 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6e 20                  cmp    %ebp,0x20(%esi)
Code;  00000003 Before first symbol
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4>
fffffff4 <END_OF_CODE+28608a55/????>
Code;  00000005 Before first symbol
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  00000009 Before first symbol
   9:   39 86 8c 00 00 00         cmp    %eax,0x8c(%esi)
Code;  0000000f Before first symbol
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4>
fffffff4 <END_OF_CODE+28608a55/????>
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before
first symbol
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
