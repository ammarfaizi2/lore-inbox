Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282991AbRK0XkX>; Tue, 27 Nov 2001 18:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282984AbRK0XkN>; Tue, 27 Nov 2001 18:40:13 -0500
Received: from web12808.mail.yahoo.com ([216.136.174.43]:26127 "HELO
	web12808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282990AbRK0Xj7>; Tue, 27 Nov 2001 18:39:59 -0500
Message-ID: <20011127233958.33562.qmail@web12808.mail.yahoo.com>
Date: Tue, 27 Nov 2001 15:39:58 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Oops in 2.4.16, usb/HID stuff
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.16, kgcc (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)), dell dimension 8100, HID(usb) mouse
and kbd.

Could it be that hid is invalid in hid-core.c:1231?

Here is the relevant info:
----cut-here-----
hub.c: USB new device connect on bus1/1, assigned device
number 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: USB new device connect on bus1/2, assigned device
number 3
input0: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse
M-BA47] on usb1:3.0
hub.c: USB new device connect on bus1/1/1, assigned device
number 4
input1: USB HID v1.00 Keyboard [NMB Dell USB 7HK Keyboard]
on usb1:4.0
input2<1>Unable to handle kernel paging request at virtual
address ffffffff
 printing eip:
c02bba40
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02bba40>]    Not tainted
EFLAGS: 00010097
eax: ffffffff   ebx: ffffffff   ecx: ffffffff   edx:
fffffffe
esi: c03986d0   edi: ffffffff   ebp: 00000000   esp:
dfe83e6c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 10, stackpage=dfe83000)
Stack: 00000000 dfbd2000 00000246 00000002 c0307354
00002392 00000246 0000238c 
       00002392 c01163bb 0000238c 00002392 0000004e
00000000 c0398abf 0000000a 
       c0116563 c03986c0 00000400 c0307354 dfe83ee4
00000000 dfbd2000 ffffffff 
Call Trace: [<c01163bb>] [<c0116563>] [<c024660b>]
[<c02387e5>] [<c02388c9>] 
   [<c023a78c>] [<c023bc60>] [<c023be00>] [<c023bfb5>]
[<c0105000>] [<c01056a3>] 

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 c7 f7 c5
10 00 
----cut-here-----

-l





=====
--

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
