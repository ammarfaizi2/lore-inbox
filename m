Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293088AbSCAOpC>; Fri, 1 Mar 2002 09:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293108AbSCAOox>; Fri, 1 Mar 2002 09:44:53 -0500
Received: from [216.66.12.254] ([216.66.12.254]:37565 "HELO
	ep1.elevenprospect.com") by vger.kernel.org with SMTP
	id <S293088AbSCAOoo>; Fri, 1 Mar 2002 09:44:44 -0500
Message-ID: <3C7F93B6.904@xblox.net>
Date: Fri, 01 Mar 2002 14:44:06 +0000
From: Matthew Allum <mallum@xblox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020205
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
Content-Type: multipart/mixed;
 boundary="------------080309090600080109060104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309090600080109060104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi ;
I've been attempting to get Linux to run on a Fujitsu pt510 [1], 
unfortunatly without much success. The kernels die almost instantly 
after cpu initialisation. I have tried both a debian woody stock 2.2 
kernel and a home built 2.4.17 kernel both built for 386. Attached is 
the kymoops output for the 2.4.17 kernel. 

Id really appreciate some help on this matter. Theres plenty of these 
510's on ebay at the moment going very cheapy ( 100$) and they'd make 
nice wireless 'web pads'.

Many thanks;

Matthew Allum

[1] Morebasic  specs on the machine here;
 http://www.mobilityconcepts.com/products/hardware/discontinued/point510/

--------------080309090600080109060104
Content-Type: text/plain;
 name="typescript"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="typescript"

Script started on Sun Feb 24 20:26:12 2002
debian:~# ksymoops -K -L -m /boot/System.map-2.4.17 -o /lib/modules/2.4.17 ~mall 
um/kernel-log.txt
ksymoops 2.4.3 on i686 2.2.20.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.17 (specified)
     -m /boot/System.map-2.4.17 (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c0124e5d>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: ffffffff   ebx: 00000000   ecx: 00000008   edx: ffffffff
esi: c10ff338   edi: 00000000   ebp: c3aef000   esp: c0261eb4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid:0, stackpage=c0261000)
Stack: c10ff340 c10ff338 000001f0 00000246 00000001 c10f8d9c ffffffff c10ff348
       00000000 00000001 c3aef000 c0125229 c10ff338 000001f0 00000000 c10f8044
       c10fa044 00000000 00000008 00000001 c013c52f c10ff338 000001f0 00000000
Call Trace: [<c0125229>] [<c013c52f>] [<c013c6dc>] [<c01404ff>] [<c0130808>]
   [<c0130c22>] [<c0131090>] [<c0105000>] 
Code: c7 00 71 f0 2c 5a 8b 46 18 8b 4c 24 18 c7 44 08 fc 71 f0 2c 

>>EIP; c0124e5c <kmem_cache_grow+170/300>   <=====
Trace; c0125228 <kmem_cache_alloc+1b0/1c8>
Trace; c013c52e <d_alloc+1a/16c>
Trace; c013c6dc <d_alloc_root+18/3c>
Trace; c01404fe <rootfs_read_super+62/84>
Trace; c0130808 <read_super+90/110>
Trace; c0130c22 <get_sb_nodev+2e/54>
Trace; c0131090 <do_kern_mount+cc/140>
Trace; c0105000 <_stext+0/0>
Code;  c0124e5c <kmem_cache_grow+170/300>
00000000 <_EIP>:
Code;  c0124e5c <kmem_cache_grow+170/300>   <=====
   0:   c7 00 71 f0 2c 5a         movl   $0x5a2cf071,(%eax)   <=====
Code;  c0124e62 <kmem_cache_grow+176/300>
   6:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c0124e64 <kmem_cache_grow+178/300>
   9:   8b 4c 24 18               mov    0x18(%esp,1),%ecx
Code;  c0124e68 <kmem_cache_grow+17c/300>
   d:   c7 44 08 fc 71 f0 2c      movl   $0x2cf071,0xfffffffc(%eax,%ecx,1)
Code;  c0124e70 <kmem_cache_grow+184/300>
  14:   00 

debian:~# 
Script done on Sun Feb 24 20:26:21 2002

--------------080309090600080109060104--

