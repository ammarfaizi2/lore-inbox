Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTHOQTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269555AbTHOQNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:35 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267561AbTHOQJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:45 -0400
Date: Fri, 15 Aug 2003 10:29:00 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20 + ksymoops
Message-ID: <Pine.LNX.4.56.0308151028050.28412@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What could this mean?

Unable to handle kernel NULL pointer dereference at virtual address
00000000
c0110036
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0110036>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210202
eax: 00008602   ebx: f05e0403   ecx: f05e0004   edx: 00000000
esi: 000051c0   edi: c02ff230   ebp: f05ebf1c   esp: e7d9bf38
ds: 0018   es: 0018   ss: 0018
Process galeon (pid: 11488, stackpage=e7d9b000)
Stack: f05ea000 e7d9a000 f1862730 e7d9bf6c ee6c51c0 e24b6000 ee6c51c0
e7d9a000
       00000000 c035ea00 0007f00c e7d9bf78 055d3ec7 e7d9bfa0 c0114ef2
e7d9bf78
       00000000 00000000 0007f00c e7d9a000 c0114e50 e7d9bfac 00000000
bf3ff7ec
Call Trace:    [<c0114ef2>] [<c0114e50>] [<c0120262>] [<c0108f13>]
Code: 88 1a 5b 5e 0f b6 c4 5f c3 90 55 57 56 53 53 8b 54 24 1c 8b


>>EIP; c0110036 <dump_extended_fpu+1316/18f0>   <=====

>>ebx; f05e0403 <___strtok+30247a63/386766c0>
>>ecx; f05e0004 <___strtok+30247664/386766c0>
>>edi; c02ff230 <rtc_lock+80/470>
>>ebp; f05ebf1c <___strtok+3025357c/386766c0>
>>esp; e7d9bf38 <___strtok+27a03598/386766c0>

Trace; c0114ef2 <schedule_timeout+52/d0>
Trace; c0114e50 <change_page_attr+1e0/230>
Trace; c0120262 <del_timer+8d2/e50>
Trace; c0108f13 <__up_wakeup+125b/1698>

Code;  c0110036 <dump_extended_fpu+1316/18f0>
00000000 <_EIP>:
Code;  c0110036 <dump_extended_fpu+1316/18f0>   <=====
   0:   88 1a                     mov    %bl,(%edx)   <=====
Code;  c0110038 <dump_extended_fpu+1318/18f0>
   2:   5b                        pop    %ebx
Code;  c0110039 <dump_extended_fpu+1319/18f0>
   3:   5e                        pop    %esi
Code;  c011003a <dump_extended_fpu+131a/18f0>
   4:   0f b6 c4                  movzbl %ah,%eax
Code;  c011003d <dump_extended_fpu+131d/18f0>
   7:   5f                        pop    %edi
Code;  c011003e <dump_extended_fpu+131e/18f0>
   8:   c3                        ret
Code;  c011003f <dump_extended_fpu+131f/18f0>
   9:   90                        nop
Code;  c0110040 <dump_extended_fpu+1320/18f0>
   a:   55                        push   %ebp
Code;  c0110041 <dump_extended_fpu+1321/18f0>
   b:   57                        push   %edi
Code;  c0110042 <dump_extended_fpu+1322/18f0>
   c:   56                        push   %esi
Code;  c0110043 <dump_extended_fpu+1323/18f0>
   d:   53                        push   %ebx
Code;  c0110044 <dump_extended_fpu+1324/18f0>
   e:   53                        push   %ebx
Code;  c0110045 <dump_extended_fpu+1325/18f0>
   f:   8b 54 24 1c               mov    0x1c(%esp,1),%edx
Code;  c0110049 <dump_extended_fpu+1329/18f0>
  13:   8b 00                     mov    (%eax),%eax


346 warnings and 14 errors issued.  Results may not be reliable.
war@war:~$
