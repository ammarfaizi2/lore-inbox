Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJVXCw>; Tue, 22 Oct 2002 19:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJVXCw>; Tue, 22 Oct 2002 19:02:52 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:22759 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262312AbSJVXCv> convert rfc822-to-8bit; Tue, 22 Oct 2002 19:02:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Markus Schoder <markus_schoder@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: Oops with kernel 2.4.20-pre10-ac2 on `ifconfig eth0 down' with PPPoE
Date: Wed, 23 Oct 2002 01:08:53 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210230108.53256.markus_schoder@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get an oops when issuing the above command while pppd is
running. I am using PPPoE. I also use Robert Love's configurable
HZ patch with HZ=1000.

Unable to handle kernel NULL pointer dereference at virtual address 000000e8 
 printing eip: 
f0924b7b 
*pde = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0010:[<f0924b7b>]    Not tainted 
EFLAGS: 00010286 
eax: ef8692c0   ebx: ef1d16c0   ecx: c02abf48  edx: 00000000 
esi: ef8692c0   edi: 00000000   ebp: ec6f5ef4   esp: ec6f5ebc 
ds: 0018   es: 0018   ss: 0018 
Process pppd (pid: 135, stackpage=ec6f5000) 
Stack: 00002e0c ef8692ea ec6f5ef4 0000001e ef0bb9d4 ec6f5ef4 0000001e bffffa28  
       c01fdbad ef0bb9d4 ec6f5ef4 0000001e 00000002 00000000 00000018 00000000  
       401a9000 7465ed04 23003068 702f4018 73726565 c02a642f c02a4900 00000000  
Call Trace:    [sys_connect+125/176] [do_IRQ+158/160] [fcntl_setlk+137/448] [sys_socketcall+167/608] [system_call+51/56] 
 
Code: ff 8a e8 00 00 00 0f 94 c0 84 c0 75 24 89 34 24 c7 44 24 04  

--
Markus

