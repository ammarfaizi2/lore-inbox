Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262026AbSIYQ4j>; Wed, 25 Sep 2002 12:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbSIYQ4j>; Wed, 25 Sep 2002 12:56:39 -0400
Received: from stingr.net ([212.193.32.15]:55303 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S262026AbSIYQ4i>;
	Wed, 25 Sep 2002 12:56:38 -0400
Date: Wed, 25 Sep 2002 21:01:52 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] Using poll speedup
Message-ID: <20020925170152.GA27904@stingr.net>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might be interested. This was got by using 1st version of patch
from -aa tree

----- Forwarded message from stingray@proxy.sgu.ru -----

ksymoops 2.4.1 on i686 2.4.19-pre5-ac3-s60.  Options used
     -v /lib/modules/2.4.20-pre7-ac3-s3/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-pre7-ac3-s3 (specified)
     -m /boot/System.map-2.4.20-pre7-ac3-s3 (specified)

Sep 25 19:01:50 proxy kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 25 19:01:50 proxy kernel: c011a064
Sep 25 19:01:50 proxy kernel: *pde = 00000000
Sep 25 19:01:50 proxy kernel: Oops: 0002
Sep 25 19:01:50 proxy kernel: CPU:    0
Sep 25 19:01:50 proxy kernel: EIP:    0010:[remove_wait_queue+4/32]    Not tainted
Sep 25 19:01:50 proxy kernel: EIP:    0010:[<c011a064>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 25 19:01:50 proxy kernel: EFLAGS: 00010092
Sep 25 19:01:50 proxy kernel: eax: 00000000   ebx: 00000292   ecx: 00000001   edx: e4a84ffc
Sep 25 19:01:50 proxy kernel: esi: e4a84000   edi: e4a84008   ebp: f706be90   esp: f706be54
Sep 25 19:01:50 proxy kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 19:01:50 proxy kernel: Process squid (pid: 1322, stackpage=f706b000)
Sep 25 19:01:50 proxy kernel: Stack: e4a84ff8 c015067e e572eb80 000000ba 00000000 000000ba c01513fc f706be90 
Sep 25 19:01:50 proxy kernel:        f706a000 000000ba 00000000 f706be90 e572eb80 00000000 00000000 00000000 
Sep 25 19:01:50 proxy kernel:        e4a73000 00000000 f706bfa8 f7e0f620 00000000 f706a000 ead9bf24 ead9bf24 
Sep 25 19:01:50 proxy kernel: Call Trace:    [poll_freewait+46/96] [sys_poll+940/960] [system_call+51/56]
Sep 25 19:01:50 proxy kernel: Call Trace:    [<c015067e>] [<c01513fc>] [<c0108bab>]
Sep 25 19:01:50 proxy kernel: Code: f0 fe 08 0f 88 e0 12 00 00 8b 4a 0c 8b 52 08 89 4a 04 89 11 

>>EIP; c011a064 <remove_wait_queue+4/20>   <=====
Trace; c015067e <poll_freewait+2e/60>
Trace; c01513fc <sys_poll+3ac/3c0>
Trace; c0108bab <system_call+33/38>
Code;  c011a064 <remove_wait_queue+4/20>
00000000 <_EIP>:
Code;  c011a064 <remove_wait_queue+4/20>   <=====
   0:   f0 fe 08                  lock decb (%eax)   <=====
Code;  c011a067 <remove_wait_queue+7/20>
   3:   0f 88 e0 12 00 00         js     12e9 <_EIP+0x12e9> c011b34d <.text.lock.fork+18/11b>
Code;  c011a06d <remove_wait_queue+d/20>
   9:   8b 4a 0c                  mov    0xc(%edx),%ecx
Code;  c011a070 <remove_wait_queue+10/20>
   c:   8b 52 08                  mov    0x8(%edx),%edx
Code;  c011a073 <remove_wait_queue+13/20>
   f:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  c011a076 <remove_wait_queue+16/20>
  12:   89 11                     mov    %edx,(%ecx)

----- End forwarded message -----

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
