Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSKNRDp>; Thu, 14 Nov 2002 12:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSKNRDd>; Thu, 14 Nov 2002 12:03:33 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:43715 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265034AbSKNRBk>; Thu, 14 Nov 2002 12:01:40 -0500
Date: Thu, 14 Nov 2002 18:08:07 +0100
From: Thorsten Mika <tmika@t-online.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: system lockups and shutdowns fo running processes
Message-Id: <20021114180807.20f1578f.tmika@t-online.de>
In-Reply-To: <Pine.LNX.4.33L2.0211140820150.3457-100000@dragon.pdx.osdl.net>
References: <20021114120526.4fe115ed.tmika@t-online.de>
	<Pine.LNX.4.33L2.0211140820150.3457-100000@dragon.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.5claws56 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> schrieb:

> On Thu, 14 Nov 2002, Thorsten Mika wrote:

[output of dmesg]

> 
> Please run that Oops text thru ksymoops so that it makes some sense.


here it is:
8139too Fast Ethernet driver 0.9.22
CPU:    0
EIP:    0010:[<c3130187>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013206
eax: 00000008   ebx: 00000001   ecx: c2059920   edx: 00001000
esi: c2059920   edi: 0000000a   ebp: 00000005   esp: c116bf30
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=c116b000)
Stack: c2059920 c2059920 c0c8dce0 c012f5b4 c2059920 c116a000 c0211a17
c116a24b
       0008e000 00000036 c19c0a40 c340b740 c32bd840 c38ee740 c18b0ea0
c2ff2500
       c3e95d80 c3a25d20 c11cc8c0 c3a35aa0 c1ed4600 c1ed49c0 c3f530c0
c27b4600
Call Trace: [<c012f5b4>] [<c0131c47>] [<c0131eb5>] [<c010546c>]
Code: 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20


>>EIP; c3130187 <___strtok+2e1def3/10a9ddcc>   <=====

>>ecx; c2059920 <___strtok+1d4768c/10a9ddcc>
>>esi; c2059920 <___strtok+1d4768c/10a9ddcc>
>>esp; c116bf30 <___strtok+e59c9c/10a9ddcc>

Trace; c012f5b4 <vfs_statfs+244/10d0>
Trace; c0131c47 <__wait_on_buffer+187/360>
Trace; c0131eb5 <file_fsync+15/2c0>
Trace; c010546c <machine_power_off+ec/140>

Code;  c3130187 <___strtok+2e1def3/10a9ddcc>
00000000 <_EIP>:
Code;  c3130187 <___strtok+2e1def3/10a9ddcc>   <=====
   0:   07                        pop    %es   <=====
Code;  c3130188 <___strtok+2e1def4/10a9ddcc>
   1:   20 07                     and    %al,(%edi)
Code;  c313018a <___strtok+2e1def6/10a9ddcc>
   3:   20 07                     and    %al,(%edi)
Code;  c313018c <___strtok+2e1def8/10a9ddcc>
   5:   20 07                     and    %al,(%edi)
Code;  c313018e <___strtok+2e1defa/10a9ddcc>
   7:   20 07                     and    %al,(%edi)
Code;  c3130190 <___strtok+2e1defc/10a9ddcc>
   9:   20 07                     and    %al,(%edi)
Code;  c3130192 <___strtok+2e1defe/10a9ddcc>
   b:   20 07                     and    %al,(%edi)
Code;  c3130194 <___strtok+2e1df00/10a9ddcc>
   d:   20 07                     and    %al,(%edi)
Code;  c3130196 <___strtok+2e1df02/10a9ddcc>
   f:   20 07                     and    %al,(%edi)
Code;  c3130198 <___strtok+2e1df04/10a9ddcc>
  11:   20 07                     and    %al,(%edi)
Code;  c313019a <___strtok+2e1df06/10a9ddcc>
  13:   20 00                     and    %al,(%eax)

 <1>Unable to handle kernel paging request at virtual address 11b9fcef
c0126416
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0126416>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c25a47e0   ecx: 00000001   edx: 000003e8
esi: ffffffec   edi: c1fb9fa4   ebp: c2593680   esp: c1fb9f40
ds: 0018   es: 0018   ss: 0018
Process wmaker (pid: 425, stackpage=c1fb9000)
Stack: c2593680 00000001 c0136d19 c2593680 00000001 c3ccd000 00000000
c1fb9fa4
       00000009 c01362be 00000009 c3ccd00f c25a47e0 c3ccd006 00000008
82ddc30a
       c0136d5a c01370b1 c1fb8000 c1fb9fa4 08162a90 bffffb8c c013446d
c1fb8000
Call Trace: [<c0136d19>] [<c01362be>] [<c0136d5a>] [<c01370b1>]
[<c013446d>]
   [<c0106b23>]
Code: 10 89 ee fc b9 11 00 00 00 f3 a5 8b 7c 24 1c 89 7b 08 8b 54


>>EIP; c0126416 <generic_file_mmap+a6/b90>   <=====

>>ebx; c25a47e0 <___strtok+229254c/10a9ddcc>
>>edi; c1fb9fa4 <___strtok+1ca7d10/10a9ddcc>
>>ebp; c2593680 <___strtok+22813ec/10a9ddcc>
>>esp; c1fb9f40 <___strtok+1ca7cac/10a9ddcc>

Trace; c0136d19 <cdput+199/980>
Trace; c01362be <bdget+10e/150>
Trace; c0136d5a <cdput+1da/980>
Trace; c01370b1 <cdput+531/980>
Trace; c013446d <block_symlink+26d/460>
Trace; c0106b23 <__up_wakeup+f63/2460>

Code;  c0126416 <generic_file_mmap+a6/b90>
00000000 <_EIP>:
Code;  c0126416 <generic_file_mmap+a6/b90>   <=====
   0:   10 89 ee fc b9 11         adc    %cl,0x11b9fcee(%ecx)   <=====
Code;  c012641c <generic_file_mmap+ac/b90>
   6:   00 00                     add    %al,(%eax)
Code;  c012641e <generic_file_mmap+ae/b90>
   8:   00 f3                     add    %dh,%bl
Code;  c0126420 <generic_file_mmap+b0/b90>
   a:   a5                        movsl  %ds:(%esi),%es:(%edi)
Code;  c0126421 <generic_file_mmap+b1/b90>
   b:   8b 7c 24 1c               mov    0x1c(%esp,1),%edi
Code;  c0126425 <generic_file_mmap+b5/b90>
   f:   89 7b 08                  mov    %edi,0x8(%ebx)
Code;  c0126428 <generic_file_mmap+b8/b90>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


1 warning and 1 error issued.  Results may not be reliable.

for me this is chinese, hope it is what you wanted.

  thx in advance,

  thorsten


-- 
Thorsten Mika                                  mailto: tmika@t-online.de
Hamm / Germany                                               TM5173-RIPE

Public Key ID: 41338C37 -- http://www.keyserver.net
