Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbREOQTZ>; Tue, 15 May 2001 12:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbREOQTO>; Tue, 15 May 2001 12:19:14 -0400
Received: from 233-ZARA-X12.libre.retevision.es ([62.82.225.233]:45070 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S261910AbREOQTC>;
	Tue, 15 May 2001 12:19:02 -0400
Message-ID: <3B006909.7070705@zaralinux.com>
Date: Tue, 15 May 2001 01:23:53 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac6 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Unable to handle kernel paging request (2.4.4-ac6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, today I got an Oops in 2.4.4-ac6, X crashed and gdm restarted, my 
system is a dual 2x200MMX, 96Mb, Voodoo 3 2000pci XFree 4.0.3, no drm.

The firsts bits are the output of ksymoops, and the last ones are the 
ones in my /var/log/messages.

Unable to handle kernel paging request at virtual address f000ef6b
c0144b69
Oops: 0000
CPU:    0
EIP:    0010:[<c0144b69>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: 00001504   ebx: f000ef57   ecx: c0220820   edx: c1115b70
esi: 00000008   edi: 00000010   ebp: 00000000   esp: c3a3bf28
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1006, stackpage=c3a3b000)
Stack: 00000001 000002f6 00000021 c0144f2d c3a3bf54 c3a3bf54 00000304 
c3a3a000
      000002f6 00000021 00000000 00000000 c1a82000 00000008 081c4920 
c312e360
      00000100 c01452b9 00000021 c3a3bf90 c3a3bf8c c1caf780 fffffff5 
00000020
Call Trace: [<c0144f2d>] [<c01452b9>] [<c0106e57>]
Code: 8b 43 14 8d 53 04 e8 2c f8 fc ff 8b 03 e8 c5 11 ff ff 39 fb

 >>EIP; c0144b69 <poll_freewait+19/50>   <=====
Trace; c0144f2d <do_select+22d/250>
Trace; c01452b9 <sys_select+339/490>
Trace; c0106e57 <system_call+37/40>
Code;  c0144b69 <poll_freewait+19/50>
00000000 <_EIP>:
Code;  c0144b69 <poll_freewait+19/50>   <=====
  0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c0144b6c <poll_freewait+1c/50>
  3:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c0144b6f <poll_freewait+1f/50>
  6:   e8 2c f8 fc ff            call   fffcf837 <_EIP+0xfffcf837> 
c01143a0 <remove_wait_queue+0/20>
Code;  c0144b74 <poll_freewait+24/50>
  b:   8b 03                     mov    (%ebx),%eax
Code;  c0144b76 <poll_freewait+26/50>
  d:   e8 c5 11 ff ff            call   ffff11d7 <_EIP+0xffff11d7> 
c0135d40 <fput+0/e0>
Code;  c0144b7b <poll_freewait+2b/50>
  12:   39 fb                     cmp    %edi,%ebx


Unable to handle kernel paging request at virtual address f000ef6b
printing eip:
c0144b69
pgd entry c3a3df00: 0000000000000000
pmd entry c3a3df00: 0000000000000000
... pmd not present!
Oops: 0000
CPU:    0
EIP:    0010:[poll_freewait+25/80]
EFLAGS: 00013282
eax: 00001504   ebx: f000ef57   ecx: c0220820   edx: c1115b70
esi: 00000008   edi: 00000010   ebp: 00000000   esp: c3a3bf28
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1006, stackpage=c3a3b000)
Stack: 00000001 000002f6 00000021 c0144f2d c3a3bf54 c3a3bf54 00000304 
c3a3a000
      000002f6 00000021 00000000 00000000 c1a82000 00000008 081c4920 
c312e360
      00000100 c01452b9 00000021 c3a3bf90 c3a3bf8c c1caf780 fffffff5 
00000020
Call Trace: [do_select+557/592] [sys_select+825/1168] [system_call+55/64]

Code: 8b 43 14 8d 53 04 e8 2c f8 fc ff 8b 03 e8 c5 11 ff ff 39 fb

-- 
Jorge Nerin
<comandante@zaralinux.com>


