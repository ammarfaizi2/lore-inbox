Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDMT2s>; Sat, 13 Apr 2002 15:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSDMT2q>; Sat, 13 Apr 2002 15:28:46 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:43306 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S293632AbSDMT1o>; Sat, 13 Apr 2002 15:27:44 -0400
Message-ID: <3CB88785.2060109@blue-labs.org>
Date: Sat, 13 Apr 2002 15:31:17 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020402
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Unable to handle kernel NULL pointer deref.. 2.4.19-pre6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 00000132
c01497b8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01497b8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: ccd519d4   ebx: c27bde74   ecx: 00000000   edx: c27bde74
esi: 00000100   edi: 00000000   ebp: 00000001   esp: c968df88
ds: 0018   es: 0018   ss: 0018
Process mozilla-bin (pid: 217, stackpage=c968d000)
Stack: c27bde74 00000000 41b22e90 bffff0e8 c013553d 00000000 c27bde74 
00000000
       c27bde74 00000049 c01355b3 c27bde74 cb99b898 c968c000 c0108a9b 
00000049
       00000001 4020b858 00000049 41b22e90 bffff0e8 00000006 c010002b 
0000002b
Call Trace: [<c013553d>] [<c01355b3>] [<c0108a9b>]
Code: 0f b7 46 32 25 00 f0 00 00 66 3d 00 40 74 0a b8 ec ff ff ff

 >>EIP; c01497b8 <fcntl_dirnotify+28/170>   <=====
Trace; c013553d <filp_close+2d/60>
Trace; c01355b3 <sys_close+43/50>
Trace; c0108a9b <system_call+33/38>
Code;  c01497b8 <fcntl_dirnotify+28/170>
00000000 <_EIP>:
Code;  c01497b8 <fcntl_dirnotify+28/170>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c01497bc <fcntl_dirnotify+2c/170>
   4:   25 00 f0 00 00            and    $0xf000,%eax
Code;  c01497c1 <fcntl_dirnotify+31/170>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c01497c5 <fcntl_dirnotify+35/170>
   d:   74 0a                     je     19 <_EIP+0x19> c01497d1 
<fcntl_dirnotify+41/170>
Code;  c01497c7 <fcntl_dirnotify+37/170>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax


