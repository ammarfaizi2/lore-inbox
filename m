Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316459AbSEWLtU>; Thu, 23 May 2002 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316464AbSEWLtT>; Thu, 23 May 2002 07:49:19 -0400
Received: from matrix.rvs.uni-bielefeld.de ([129.70.123.40]:26070 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S316459AbSEWLtS>; Thu, 23 May 2002 07:49:18 -0400
Subject: Oops: tcp_v4_get_port
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 23 May 2002 13:47:21 +0200
Message-Id: <1022154442.20761.2.camel@linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an Oops (see below) and found on the mailing list that David
Miller has posted a patch to solve this problem.

http://marc.theaimsgroup.com/?l=linux-kernel&m=101605881126597&w=2

Nobody has answered the mail from David and I can't find the patch in
2.4.19-pre8. But if I look into 2.5.17, I see that the patch is
included. Is there any reason why it is not included in the 2.4.x
kernel?

Regards

Marcel


*****
ksymoops 2.4.5 on i686 2.4.12.  Options used
     -v vmlinuz (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12/ (default)
     -m /root/System.map-2.4.12siemens (specified)

Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is vmlinuz a valid
vmlinux file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
glycl031 login: Unable to handle kernel NULL pointer dereference at
virtual
addr
c0217642

*pde = 00000000

Oops: 0000

CPU:    0

EIP:    0010:[<c0217642>]    Not tainted

Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292

eax: 000000f4   ebx: c52f5b20   ecx: d2134800   edx: 00000002

esi: 0000028d   edi: 00000000   ebp: f7781468   esp: deaf1eb8

ds: 0018   es: 0018   ss: 0018

Process httpd (pid: 3019, stackpage=deaf1000)

Stack: 00000000 d2134800 c02e5048 0000028d 00000000 c0236a3b c022323b
d2134800  
       0000028d db70f960 deaf1f14 00000010 bffff2cc ffffffea 00000003
c01f3980  
       db70f960 deaf1f14 00000010 00000001 bffff2bc ffffffff 00000000
8d020002  
Call Trace: [<c0236a3b>] [<c022323b>] [<c01f3980>] [<c01f2bc0>]
[<c01f37c4>]

   [<c01f4470>] [<c0106d7b>]

Code: 8b 42 0c 39 41 0c 75 e7 83 7c 24 10 00 74 0d 80 7a 26 00 74



>>EIP; c0217642 <tcp_v4_get_port+146/274>   <=====

>>ebx; c52f5b20 <END_OF_CODE+4fe0d44/????>
>>ecx; d2134800 <END_OF_CODE+11e1fa24/????>
>>ebp; f7781468 <END_OF_CODE+3746c68c/????>
>>esp; deaf1eb8 <END_OF_CODE+1e7dd0dc/????>

Trace; c0236a3b <vsnprintf+3df/420>
Trace; c022323b <inet_bind+17f/290>
Trace; c01f3980 <sys_bind+54/74>
Trace; c01f2bc0 <sock_map_fd+128/1b0>
Trace; c01f37c4 <sys_socket+30/50>
Trace; c01f4470 <sys_socketcall+78/200>
Trace; c0106d7b <system_call+33/38>

Code;  c0217642 <tcp_v4_get_port+146/274>
00000000 <_EIP>:
Code;  c0217642 <tcp_v4_get_port+146/274>   <=====
   0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====
Code;  c0217645 <tcp_v4_get_port+149/274>
   3:   39 41 0c                  cmp    %eax,0xc(%ecx)
Code;  c0217648 <tcp_v4_get_port+14c/274>
   6:   75 e7                     jne    ffffffef <_EIP+0xffffffef>
c0217631
<tcp_v4_get_port+135/274>
Code;  c021764a <tcp_v4_get_port+14e/274>
   8:   83 7c 24 10 00            cmpl   $0x0,0x10(%esp,1)
Code;  c021764f <tcp_v4_get_port+153/274>
   d:   74 0d                     je     1c <_EIP+0x1c> c021765e
<tcp_v4_get_port+162/274>
Code;  c0217651 <tcp_v4_get_port+155/274>
   f:   80 7a 26 00               cmpb   $0x0,0x26(%edx)
Code;  c0217655 <tcp_v4_get_port+159/274>
  13:   74 00                     je     15 <_EIP+0x15> c0217657
<tcp_v4_get_port+15b/274>

 <0>Kernel panic: Aiee, killing interrupt handler!


1 warning and 1 error issued.  Results may not be reliable.

******


