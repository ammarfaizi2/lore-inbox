Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbRBTIYD>; Tue, 20 Feb 2001 03:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBTIXn>; Tue, 20 Feb 2001 03:23:43 -0500
Received: from scan1.fhg.de ([153.96.1.35]:64166 "EHLO scan1.fhg.de")
	by vger.kernel.org with ESMTP id <S129150AbRBTIXY>;
	Tue, 20 Feb 2001 03:23:24 -0500
Date: Tue, 20 Feb 2001 09:23:19 +0100
From: Sven Geggus <sven@geggus.net>
To: linux-kernel@vger.kernel.org
Subject: syslinux+2.2.19pre9 "oops at Kernel Boot time"
Message-ID: <20010220092319.A503@venus.iitb.fhg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-giggls-priority: very high :P
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I ran into a boot Problem on an embedded Box (AMD Elan400 based)
using syslinux and a 2.2.19pre7 Kernel (does not work on 2.2.19pre9 as well).

Strange enough the box boots just fine when using a raw boot kernel on
Floppy Disk instead of syslinux using exactly the same Kernelimage and
a DOS formated Floppy with syslinux installed.

Here is what ksymoops tells (on a 2.2.19pre7, but its the very same on the
2.2.19pre9).

I hope that you are more familiar in interpreting this than I am.

Sven

--cut--
ksymoops 2.3.7 on i686 2.2.19pre7.  Options used
     -v kernel/kernel-2.2.19pre7/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m kernel/kernel-2.2.19pre7/System.map (specified)

CPU:    0
EIP:    0010:[<c011e8e8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000009f   ebx: c3aff0d8   ecx: ffffffff   edx: c0307800
esi: 00000028   edi: ffffffff   ebp: c3afffe0   esp: c0217f38
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr:0, stackpage=c0217000)
Stack: c0204720 00000282 ffffffff 00000212 00000001 00000015 00000020 00000000
       c011eaf1 c0204720 00000015 00000000 00000020 00000000 00000000 c011e015
       c0204720 00000015 00000000 00099800 00000000 00000000 00000008 c021b1df
Call Trace: [<c011eaf1>] [<c011e015>] [<c0106000>] [<c01dc05e>] [<c0106000>] [<c0106000>] [<c0100176>]
Code: 89 07 8b 4c 24 10 8b 09 89 4c 24 10 83 ee 01 73 b8 c7 01 00

>>EIP; c011e8e8 <kmem_cache_grow+2a8/380>   <=====
Trace; c011eaf1 <kmem_cache_alloc+d1/130>
Trace; c011e015 <kmem_cache_create+125/530>
Trace; c0106000 <get_options+0/70>
Trace; c01dc05e <tvecs+15be/3580>
Trace; c0106000 <get_options+0/70>
Trace; c0106000 <get_options+0/70>
Trace; c0100176 <L6+0/2>
Code;  c011e8e8 <kmem_cache_grow+2a8/380>
00000000 <_EIP>:
Code;  c011e8e8 <kmem_cache_grow+2a8/380>   <=====
   0:   89 07                     movl   %eax,(%edi)   <=====
Code;  c011e8ea <kmem_cache_grow+2aa/380>
   2:   8b 4c 24 10               movl   0x10(%esp,1),%ecx
Code;  c011e8ee <kmem_cache_grow+2ae/380>
   6:   8b 09                     movl   (%ecx),%ecx
Code;  c011e8f0 <kmem_cache_grow+2b0/380>
   8:   89 4c 24 10               movl   %ecx,0x10(%esp,1)
Code;  c011e8f4 <kmem_cache_grow+2b4/380>
   c:   83 ee 01                  subl   $0x1,%esi
Code;  c011e8f7 <kmem_cache_grow+2b7/380>
   f:   73 b8                     jae    ffffffc9 <_EIP+0xffffffc9> c011e8b1 <kmem_cache_grow+271/380>
Code;  c011e8f9 <kmem_cache_grow+2b9/380>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing
--cut--


-- 
Microsoft Outlook, the Software which made the "Good Times"
Email-virus Hoax a reality.

/me is giggls@ircnet, http://geggus.net/sven/ on the Web
