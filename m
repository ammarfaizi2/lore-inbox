Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135292AbRD3OqV>; Mon, 30 Apr 2001 10:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135296AbRD3OqD>; Mon, 30 Apr 2001 10:46:03 -0400
Received: from hees.nijmegen.inter.nl.net ([193.67.237.8]:14736 "EHLO
	hees.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S135292AbRD3Opw>; Mon, 30 Apr 2001 10:45:52 -0400
Date: Mon, 30 Apr 2001 16:46:31 +0200
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 Oops
Message-ID: <20010430164631.A968@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is a dual PIII. Oops occurred while starting the automounter
(autofs).  starting it later on by hand again gave no oops anymore.

ksymoops 2.3.5 on i686 2.4.4-x40.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-x40/ (default)
     -m /boot/System.map-2.4.4-x40 (specified)

Apr 30 16:20:53 iapetus kernel: Unable to handle kernel paging request at virtual address 08058000 
Apr 30 16:20:53 iapetus kernel: c021b5f6 
Apr 30 16:20:53 iapetus kernel: *pde = 0894e067 
Apr 30 16:20:53 iapetus kernel: Oops: 0000 
Apr 30 16:20:53 iapetus kernel: CPU:    1 
Apr 30 16:20:53 iapetus kernel: EIP:    0010:[<c021b5f6>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 30 16:20:53 iapetus kernel: EFLAGS: 00010206 
Apr 30 16:20:53 iapetus kernel: eax: 00000000   ebx: 00001000   ecx: 00000276   edx: 00000000 
Apr 30 16:20:53 iapetus kernel: esi: 08058000   edi: c86e1628   ebp: 080579d8   esp: cbdd5f64 
Apr 30 16:20:53 iapetus kernel: ds: 0018   es: 0018   ss: 0018 
Apr 30 16:20:54 iapetus kernel: Process mount (pid: 416, stackpage=cbdd5000) 
Apr 30 16:20:54 iapetus kernel: Stack: 00001000 c86e1000 080579d8 00001000 c0145d99 cbdd4000 c0138c0d c86e1000  
Apr 30 16:20:54 iapetus kernel:        080579d8 00001000 cbdd4000 c0ed0000 08057a38 bffffa88 c0138f15 080579d8  
Apr 30 16:20:54 iapetus kernel:        cbdd5fbc cbdd4000 c0ed0000 08057a38 00000000 c0106e0c 00000000 c0106cdb  
Apr 30 16:20:54 iapetus kernel: Call Trace: [<c0145d99>] [<c0138c0d>] [<c0138f15>] [<c0106e0c>] [<c0106cdb>]  
Apr 30 16:20:54 iapetus kernel: Code: f3 a5 89 c1 f3 a4 89 cb eb 16 89 d9 c1 e9 02 31 c0 f3 ab f6  

>>EIP; c021b5f6 <__generic_copy_from_user+3a/64>   <=====
Trace; c0145d99 <dput+19/154>
Trace; c0138c0d <copy_mount_options+51/9c>
Trace; c0138f15 <sys_mount+15/120>
Trace; c0106e0c <error_code+34/3c>
Trace; c0106cdb <system_call+33/38>
Code;  c021b5f6 <__generic_copy_from_user+3a/64>
00000000 <_EIP>:
Code;  c021b5f6 <__generic_copy_from_user+3a/64>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c021b5f8 <__generic_copy_from_user+3c/64>
   2:   89 c1                     movl   %eax,%ecx
Code;  c021b5fa <__generic_copy_from_user+3e/64>
   4:   f3 a4                     repz movsb %ds:(%esi),%es:(%edi)
Code;  c021b5fc <__generic_copy_from_user+40/64>
   6:   89 cb                     movl   %ecx,%ebx
Code;  c021b5fe <__generic_copy_from_user+42/64>
   8:   eb 16                     jmp    20 <_EIP+0x20> c021b616 <__generic_copy_from_user+5a/64>
Code;  c021b600 <__generic_copy_from_user+44/64>
   a:   89 d9                     movl   %ebx,%ecx
Code;  c021b602 <__generic_copy_from_user+46/64>
   c:   c1 e9 02                  shrl   $0x2,%ecx
Code;  c021b605 <__generic_copy_from_user+49/64>
   f:   31 c0                     xorl   %eax,%eax
Code;  c021b607 <__generic_copy_from_user+4b/64>
  11:   f3 ab                     repz stosl %eax,%es:(%edi)
Code;  c021b609 <__generic_copy_from_user+4d/64>
  13:   f6 00 00                  testb  $0x0,(%eax)


-- 
Frank
