Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTEOHDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTEOHDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:03:54 -0400
Received: from s4.uklinux.net ([80.84.72.14]:3290 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S262283AbTEOHDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:03:51 -0400
Date: Thu, 15 May 2003 08:05:56 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 oops
Message-ID: <20030515070555.GA1589@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have been having continual problems with recent kernels
(2..4.{18,19,20}) locking up. It usually happens at night when the
machine is idle. Usually the logs are empty. Sys-Rq produces no
response. The only option is a total reset.

It has happened again overnight. Looking in the logs, there is an oops
late yesterday evening, which I hope is the cause and will help this to
get nailed.

K6 200. TX motherboard.

Let me know if you need any more information.

Thanks.

Mark


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=oops

ksymoops 2.3.7 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

May 14 18:22:23 titan kernel: Unable to handle kernel paging request at virtual address c9d99cac
May 14 18:22:23 titan kernel: c0124a83
May 14 18:22:23 titan kernel: *pde = 00000000
May 14 18:22:23 titan kernel: Oops: 0002
May 14 18:22:23 titan kernel: CPU:    0
May 14 18:22:23 titan kernel: EIP:    0010:[kfree+63/180]    Tainted: P 
May 14 18:22:23 titan kernel: EFLAGS: 00013012
May 14 18:22:23 titan kernel: eax: 0f000000   ebx: 01e93f25   ecx: c234a000   edx: 0000001d
May 14 18:22:23 titan kernel: esi: c10b30a0   edi: 00003282   ebp: c3523f64   esp: c3523f54
May 14 18:22:23 titan kernel: ds: 0018   es: 0018   ss: 0018
May 14 18:22:23 titan kernel: Process squiral (pid: 20673, stackpage=c3523000)
May 14 18:22:23 titan kernel: Stack: 00000000 c234a940 00000000 00000000 c3523f70 c013757f c234a940 c3523fbc 
May 14 18:22:23 titan kernel:        c01379c4 c234a940 00000000 c3522000 00000000 bffff980 0000541b 0000001f 
May 14 18:22:23 titan kernel:        00000000 00000000 c234a940 00000000 c234a940 c234a940 c234a940 c234a940 
May 14 18:22:23 titan kernel: Call Trace:    [select_bits_free+11/16] [sys_select+1088/1100] [system_call+51/64]
May 14 18:22:23 titan kernel: Code: 89 44 99 18 89 59 14 8b 41 10 8d 50 ff 89 51 10 83 f8 01 75 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)
Code;  00000004 Before first symbol
   4:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  0000000a Before first symbol
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  0000000d Before first symbol
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  00000010 Before first symbol
  10:   83 f8 01                  cmp    $0x1,%eax
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15>


6 warnings issued.  Results may not be reliable.

--VS++wcV0S1rZb1Fb--
