Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTIIRlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTIIRlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:41:32 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:34319 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S264324AbTIIRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:41:28 -0400
Message-ID: <00da01c376fa$4beb4fc0$6ff6d618@bp>
From: "Brad Parker" <parker@citynetwireless.net>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <007e01c3766a$bd0f8df0$6ff6d618@bp> <20030909173910.GA28279@matchmail.com>
Subject: Re: kernel BUG in sched.c
Date: Tue, 9 Sep 2003 12:46:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading Oops report from the terminal
kernel BUG at sched.c:564!
kernel BUG at sched.c:564!
invalid operand: 0000
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0115a7b>]    Not tainted
EFLAGS: 00010282
CPU:    0
EIP:    0010:[<c0115a7b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000018   ebx: c11be280   ecx: 00000001   edx: 00000001
eax: 00000018   ebx: c11be280   ecx: 00000001   edx: 00000001
esi: c38a6000   edi: c38a6000   ebp: c38a7fa0   esp: c38a7f80
esi: c38a6000   edi: c38a6000   ebp: c38a7fa0   esp: c38a7f80
esi: c38a6000   edi: c38a6000   ebp: c38a7fa0   esp: c38a7f80
ds: 0018   es: 0018   ss: 0018
ds: 0018   es: 0018   ss: 0018
Process ospfd (pid: 85, stackpage=c38a7000)
Process ospfd (pid: 85, stackpage=c38a7000)
Stack: c02d798a c38a6000 c38a6000 00000000 c38a6000 c11be280 c10b5200
Stack: c02d798a c38a6000 c38a6000 00000000 c38a6000 c11be280 c10b5200
c38a6000
c38a6000
       00000000 c011b51d c38a6000 4018db4c 00000000 bffff85c c011b65f
00000000
       00000000 c011b51d c38a6000 4018db4c 00000000 bffff85c c011b65f
00000000
       c01071d3 00000000 00000001 00000000 4018db4c 00000000 bffff85c
       c01071d3 00000000 00000001 00000000 4018db4c 00000000 bffff85c
00000001
00000001
Call Trace:    [<c011b51d>] [<c011b65f>] [<c01071d3>]
Call Trace:    [<c011b51d>] [<c011b65f>] [<c01071d3>]

Code: 0f 0b 34 02 82 79 2d c0 5a e9 1c fd ff ff 0f 0b 2d 02 82 79
Code: 0f 0b 34 02 82 79 2d c0 5a e9 1c fd ff ff 0f 0b 2d 02 82 79


>>EIP; c0115a7b <schedule+31b/340>   <=====

>>ebx; c11be280 <_end+e1d248/3848e028>
>>esi; c38a6000 <_end+3504fc8/3848e028>
>>edi; c38a6000 <_end+3504fc8/3848e028>
>>ebp; c38a7fa0 <_end+3506f68/3848e028>
>>esp; c38a7f80 <_end+3506f48/3848e028>

Trace; c011b51d <do_exit+14d/260>
Trace; c011b65f <sys_exit+f/10>
Trace; c01071d3 <system_call+33/40>

Code;  c0115a7b <schedule+31b/340>
00000000 <_EIP>:
Code;  c0115a7b <schedule+31b/340>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0115a7d <schedule+31d/340>
   2:   34 02                     xor    $0x2,%al
Code;  c0115a7f <schedule+31f/340>
   4:   82                        (bad)
Code;  c0115a80 <schedule+320/340>
   5:   79 2d                     jns    34 <_EIP+0x34> c0115aaf
<__wake_up+f/60>
Code;  c0115a82 <schedule+322/340>
   7:   c0 5a e9 1c               rcrb   $0x1c,0xffffffe9(%edx)
Code;  c0115a86 <schedule+326/340>
   b:   fd                        std
Code;  c0115a87 <schedule+327/340>
   c:   ff                        (bad)
Code;  c0115a88 <schedule+328/340>
   d:   ff 0f                     decl   (%edi)
Code;  c0115a8a <schedule+32a/340>
   f:   0b 2d 02 82 79 00         or     0x798202,%ebp

<0>Kernel panic: Aiee, killing interrupt handler!
<0>Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing


----- Original Message -----
From: "Mike Fedyk" <mfedyk@matchmail.com>
To: "Brad Parker" <parker@citynetwireless.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, September 09, 2003 12:39
Subject: Re: kernel BUG in sched.c


> On Mon, Sep 08, 2003 at 07:38:50PM -0500, Brad Parker wrote:
> > I got a kernel BUG mentioning the process ospfd (zebra/quagga routing
> > protocol daemon) while trying to  "shutdown -r now", I already contaced
the
> > quagga people, but I thought maybe this would be a kernel issue, so here
> > goes:
>
> You need to run it through ksymoops with the same modules loaded in the
same
> order also.
>

