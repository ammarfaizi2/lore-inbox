Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291560AbSBSSLK>; Tue, 19 Feb 2002 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291571AbSBSSKy>; Tue, 19 Feb 2002 13:10:54 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:20627 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S291560AbSBSSKh>; Tue, 19 Feb 2002 13:10:37 -0500
Subject: OOPS 2.4.17 devfs
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 10:10:36 -0800
Message-Id: <1014142236.551.1.camel@heat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.17 i386 SMP with devfs gave me this oops.  I don't know what might
have triggered it.



invalid operand: 0000
CPU:    1
EIP:    0010:[<c0143ee1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 5a5a5a00   ebx: dbf71160   ecx: dbbf79a0   edx: dbf71190
esi: dbbf79a0   edi: df3ab620   ebp: dbf71160   esp: df0a3f18
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 253, stackpage=df0a3000)
Stack: d9d7c8a0 c0169eae dbf71160 dbbf79a0 dbf71160 00000000 df0a3fa4
df3a29a0 
       c013b76e dbf71160 00000000 df0a3f74 c013bf31 df3a29a0 df0a3f74
00000000 
       df695000 00000000 df0a3fa4 00000009 00000009 df695005 00000000
df695004 
Call Trace: [<c0169eae>] [<c013b76e>] [<c013bf31>] [<c013c1aa>]
[<c013c621>] 
   [<c013936d>] [<c0132984>] [<c0106d7b>] 
Code: 0f 0b f0 fe 0d 80 a6 2c c0 0f 88 28 d2 0d 00 85 c9 74 12 8b 

>>EIP; c0143ee0 <d_instantiate+10/44>   <=====
Trace; c0169eae <devfs_d_revalidate_wait+8e/b8>
Trace; c013b76e <cached_lookup+2e/54>
Trace; c013bf30 <link_path_walk+580/7e0>
Trace; c013c1aa <path_walk+1a/1c>
Trace; c013c620 <__user_walk+34/50>
Trace; c013936c <sys_stat64+18/70>
Trace; c0132984 <sys_read+bc/c4>
Trace; c0106d7a <system_call+32/38>
Code;  c0143ee0 <d_instantiate+10/44>
00000000 <_EIP>:
Code;  c0143ee0 <d_instantiate+10/44>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0143ee2 <d_instantiate+12/44>
   2:   f0 fe 0d 80 a6 2c c0      lock decb 0xc02ca680
Code;  c0143ee8 <d_instantiate+18/44>
   9:   0f 88 28 d2 0d 00         js     dd237 <_EIP+0xdd237> c0221116
<stext_lock+2c16/7f16>
Code;  c0143eee <d_instantiate+1e/44>
   f:   85 c9                     test   %ecx,%ecx
Code;  c0143ef0 <d_instantiate+20/44>
  11:   74 12                     je     25 <_EIP+0x25> c0143f04
<d_instantiate+34/44>
Code;  c0143ef2 <d_instantiate+22/44>
  13:   8b 00                     mov    (%eax),%eax


