Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTAISYu>; Thu, 9 Jan 2003 13:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbTAISYu>; Thu, 9 Jan 2003 13:24:50 -0500
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:42910 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP
	id <S266907AbTAISYs>; Thu, 9 Jan 2003 13:24:48 -0500
Date: Thu, 9 Jan 2003 19:33:32 +0100 (CET)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3-ac2 oops
Message-ID: <Pine.LNX.4.44.0301091929580.6240-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I encountered a kernel oops. When that happened, I was extracting XFree86
4.2.1 sources to a reiserfs filesystem.

ksymoops 2.4.5 on i686 2.4.20-ac2.  Options used
     -V (default)
     -k /var/log/ksymoops/20030109113946.ksyms (specified)
     -l /var/log/ksymoops/20030109113946.modules (specified)
     -o /lib/modules/2.4.21-pre3-ac2/ (specified)
     -m /boot/System.map-2.4.21-pre3-ac2 (specified)

Jan  9 19:02:36 warpers kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Jan  9 19:02:36 warpers kernel: c012ca10
Jan  9 19:02:36 warpers kernel: *pde = 00000000
Jan  9 19:02:36 warpers kernel: Oops: 0002
Jan  9 19:02:36 warpers kernel: CPU:    0
Jan  9 19:02:36 warpers kernel: EIP:    0010:[__free_pages_ok+624/652]
Not tainted
Jan  9 19:02:36 warpers kernel: EFLAGS: 00010246
Jan  9 19:02:36 warpers kernel: eax: 00000000   ebx: c106fa94   ecx:
c106fa94   edx: c12d0000
Jan  9 19:02:36 warpers kernel: esi: 00000000   edi: 00000020   ebp:
000001ba   esp: c12d1dc4
Jan  9 19:02:36 warpers kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 19:02:36 warpers kernel: Process kupdated (pid: 7, stackpage=c12d1000)
Jan  9 19:02:36 warpers kernel: Stack: c2899120 c106fa94 00000020
000001ba c013644e c106fa94 000000f0 00000020
Jan  9 19:02:36 warpers kernel:        000001ba c01349ac c2899120
c2899120 c2899120 c012d043 c012c11c 00000020
Jan  9 19:02:36 warpers kernel:        000000f0 00000020 00000006
00000006 c12d0000 00001145 000000f0 c029dd54
Jan  9 19:02:36 warpers kernel: Call Trace:
[try_to_free_buffers+146/236] [try_to_release_page+68/72] [__free_pages+27/28] [shrink_cache+724/764] [shrink_caches+88/136]
Jan  9 19:02:36 warpers kernel: Code: 89 58 04 89 03 8d 42 5c 89 43 04 89
5a 5c 89 73 0c ff 42 68
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c106fa94 <_end+d31120/d56968c>
>>ecx; c106fa94 <_end+d31120/d56968c>
>>edx; c12d0000 <_end+f9168c/d56968c>
>>esp; c12d1dc4 <_end+f93450/d56968c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 03                     mov    %eax,(%ebx)
Code;  00000005 Before first symbol
   5:   8d 42 5c                  lea    0x5c(%edx),%eax
Code;  00000008 Before first symbol
   8:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  0000000b Before first symbol
   b:   89 5a 5c                  mov    %ebx,0x5c(%edx)
Code;  0000000e Before first symbol
   e:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  00000011 Before first symbol
  11:   ff 42 68                  incl   0x68(%edx)


  Geller Sandor <wildy@petra.hos.u-szeged.hu>

