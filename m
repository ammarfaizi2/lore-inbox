Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSHYVnV>; Sun, 25 Aug 2002 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317611AbSHYVnV>; Sun, 25 Aug 2002 17:43:21 -0400
Received: from ip68-14-11-228.ri.ri.cox.net ([68.14.11.228]:62284 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S317597AbSHYVnU>; Sun, 25 Aug 2002 17:43:20 -0400
Message-ID: <3D694FA5.6020109@blue-labs.org>
Date: Sun, 25 Aug 2002 17:44:05 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] PPPoE turbulance again
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another report of PPPoE oopsing with 2.4.20-pre2-ac6.  Just 
before it oopsed it printed this on the console:

PPPIOCDETACH file->f_count=3



Unable to handle kernel NULL pointer dereference at virtual address 
000000e8 c01f19b3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01f19b3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c03f60a8   ebx: c5753940   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 0000001e   ebp: c742a5e0   esp: c5597edc
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 4428, stackpage=c5597000)
Stack: c742bcd4 c5597f14 0000001e bffff7d8 bffff7b0 c02918e4 c742bcd4 
c5597f14
       0000001e 00000002 00000002 00000004 bffff874 00000000 00000018 
00000000
       00671000 7465e1a8 36003068 00004018 04090000 c74e0000 00000246 
c5597f6c
Call Trace:    [<c02918e4>] [<c0140e18>] [<c013d460>] [<c02921e3>] 
[<c0106ba3>]
Code: ff 8a e8 00 00 00 0f 94 c0 84 c0 74 09 52 e8 8e 6b 0a 00 83

 >>EIP; c01f19b3 <pppoe_connect+d7/248>   <=====
Trace; c02918e4 <sys_connect+58/78>
Trace; c0140e18 <fcntl_setlk+1e4/1f4>
Trace; c013d460 <do_fcntl+148/1fc>
Trace; c02921e3 <sys_socketcall+87/1bc>
Trace; c0106ba3 <system_call+33/40>
Code;  c01f19b3 <pppoe_connect+d7/248>
00000000 <_EIP>:
Code;  c01f19b3 <pppoe_connect+d7/248>   <=====
   0:   ff 8a e8 00 00 00         decl   0xe8(%edx)   <=====
Code;  c01f19b9 <pppoe_connect+dd/248>
   6:   0f 94 c0                  sete   %al
Code;  c01f19bc <pppoe_connect+e0/248>
   9:   84 c0                     test   %al,%al
Code;  c01f19be <pppoe_connect+e2/248>
   b:   74 09                     je     16 <_EIP+0x16> c01f19c9 
<pppoe_connect+ed/248>
Code;  c01f19c0 <pppoe_connect+e4/248>
   d:   52                        push   %edx
Code;  c01f19c1 <pppoe_connect+e5/248>
   e:   e8 8e 6b 0a 00            call   a6ba1 <_EIP+0xa6ba1> c0298554 
<netdev_finish_unregister+0/9c>
Code;  c01f19c6 <pppoe_connect+ea/248>
  13:   83 00 00                  addl   $0x0,(%eax)

-- 
I may have the information you need and I may choose only HTML.  It's up to
you. Disclaimer: I am not responsible for any email that you send me nor am
I bound to any obligation to deal with any received email in any given
fashion.  If you send me spam or a virus, I may in whole or part send you
50,000 return copies of it. I may also publically announce any and all
emails and post them to message boards, news sites, and even parody sites. 
I may also mark them up, cut and paste, print, and staple them to telephone
poles for the enjoyment of people without internet access.  This is not a
confidential medium and your assumption that your email can or will be
handled confidentially is akin to baring your backside, burying your head in
the ground, and thinking nobody can see you butt nekkid and in plain view
for miles away.  Don't be a cluebert, buy one from K-mart today.


