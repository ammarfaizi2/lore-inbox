Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271158AbTHRAUK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271146AbTHRAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:20:10 -0400
Received: from puffin.mail.pas.earthlink.net ([207.217.120.139]:31190 "EHLO
	puffin.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S271158AbTHRAT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:19:58 -0400
Message-ID: <3F401B97.5020400@earthlink.net>
Date: Sun, 17 Aug 2003 20:19:35 -0400
From: Raptorfan <raptorfan@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-wlan-user@lists.linux-wlan.com
CC: linux-kernel@vger.kernel.org, raptorfan@earthlink.net
Subject: oops with wlan-ng & pcmcia in 2.4.22 < pre7
Content-Type: multipart/mixed;
 boundary="------------070303000106060508050009"
X-ELNK-Trace: 35870deef6828a6f85338a7d01cb3b6a7e972de0d01da940dc4eb4ff4bfb6ae25e46d79321033fa0350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303000106060508050009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Howdy. Since somewhere around the .22-pre7 (or -pre6) area wlan-ng
stopped working. I've tried the wlan-ng-2.4.1-pre1[01] drivers with
various pristine and -ac kernels since .22-pre8 and

The file oops.txt is generated when trying to load prism2_cs in a
2.4.22-rc2-ac3 kernel; the file oopsout.txt is from 2.4.22-rc2. Both are
trying to load the wlan-ng 2.4.1-pre11 driver. It looks like a problem
within prism2_cs.. but the drivers work with 2.4.21* so my ignorant guts
tell me it's more likely pcmcia has changed somehow to affect this.

Let me know if anyone requires further info. I'll do what I can.

-r


--------------070303000106060508050009
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.8 on i686 2.4.22-rc2-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc2-ac3/ (default)
     -m /boot/System.map (specified)

Dell Latitude C600 machine detected. Mousepad Resume Bug workaround enabled.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xf0000-0xfffff
Unable to handle kernel NULL pointer dereference at virtual address 00000000
e0896321
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e0896321>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: 00000000   ebx: df87d0dc   ecx: 00000246   edx: 00000000
esi: df87d000   edi: df87d000   ebp: df6f9c8c   esp: df6f9c7c
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 67, stackpage=df6f9000)
Stack: e089192f df9e1600 df9a2800 c15ffed4 df6f9ca8 e08a5505 df87d000 c15ffdcc 
       df7e2884 e08a5400 df6f9cee df6f9cc4 e088a993 c15ffed4 dfe4beac 00000000 
       4050643f 00000050 df6f9f90 e088b19b 00000000 df6f9ce4 00000050 00000000 
Call Trace:    [<e089192f>] [<e08a5505>] [<e08a5400>] [<e088a993>] [<e088b19b>]
  [<c01665f3>] [<c0152c72>] [<c0135600>] [<c01c0677>] [<c01c1fc2>] [<c01c1286>]
  [<c01c4373>] [<c01b4f3d>] [<c01b49b0>] [<c01357bd>] [<c0125ad7>] [<c013f328>]
  [<c014cc01>] [<c013da6f>] [<c0107367>]
Code: 8b 00 ff 4b 08 c7 42 08 00 00 00 00 89 58 04 89 86 dc 00 00 


>>EIP; e0896321 <[prism2_cs]hfa384x_destroy+61/110>   <=====

>>ebx; df87d0dc <_end+1f55aa24/205229a8>
>>esi; df87d000 <_end+1f55a948/205229a8>
>>edi; df87d000 <_end+1f55a948/205229a8>
>>ebp; df6f9c8c <_end+1f3d75d4/205229a8>
>>esp; df6f9c7c <_end+1f3d75c4/205229a8>

Trace; e089192f <[p80211]wlan_unsetup+6f/a0>
Trace; e08a5505 <[prism2_cs]prism2sta_detach+105/190>
Trace; e08a5400 <[prism2_cs]prism2sta_detach+0/190>
Trace; e088a993 <[ds]unbind_request+a3/100>
Trace; e088b19b <[ds]ds_ioctl+42b/730>
Trace; c01665f3 <ext3_getblk+93/2f0>
Trace; c0152c72 <inode_init_once+22/f0>
Trace; c0135600 <kmem_cache_init_objs+130/140>
Trace; c01c0677 <scrup+117/130>
Trace; c01c1fc2 <lf+72/80>
Trace; c01c1286 <hide_cursor+66/a0>
Trace; c01c4373 <do_con_write+2b3/6b0>
Trace; c01b4f3d <tty_fasync+8d/140>
Trace; c01b49b0 <release_dev+6a0/6f0>
Trace; c01357bd <kmem_cache_free_one+fd/210>
Trace; c0125ad7 <sys_rt_sigaction+77/b0>
Trace; c013f328 <fput+c8/120>
Trace; c014cc01 <sys_ioctl+b1/240>
Trace; c013da6f <sys_close+4f/60>
Trace; c0107367 <system_call+33/38>

Code;  e0896321 <[prism2_cs]hfa384x_destroy+61/110>
00000000 <_EIP>:
Code;  e0896321 <[prism2_cs]hfa384x_destroy+61/110>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  e0896323 <[prism2_cs]hfa384x_destroy+63/110>
   2:   ff 4b 08                  decl   0x8(%ebx)
Code;  e0896326 <[prism2_cs]hfa384x_destroy+66/110>
   5:   c7 42 08 00 00 00 00      movl   $0x0,0x8(%edx)
Code;  e089632d <[prism2_cs]hfa384x_destroy+6d/110>
   c:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  e0896330 <[prism2_cs]hfa384x_destroy+70/110>
   f:   89 86 dc 00 00 00         mov    %eax,0xdc(%esi)

ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)


--------------070303000106060508050009
Content-Type: text/plain;
 name="oopsout.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oopsout.txt"

ksymoops 2.4.8 on i686 2.4.22-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc2/ (default)
     -m /boot/System.map (specified)

cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xf0000-0xfffff
Unable to handle kernel NULL pointer dereference at virtual address 00000000
e08bd321
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e08bd321>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: 00000000   ebx: df72c0dc   ecx: 00000246   edx: 00000000
esi: df72c000   edi: df72c000   ebp: df71fc8c   esp: df71fc7c
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 67, stackpage=df71f000)
Stack: e08b88df dfe3fa00 df6d2064 df901000 df71fca8 e08cc57c df72c000 c1592ed4 
       df86cab4 dfe3b8a6 df71fcee df71fcc4 e08b1983 df6d2064 df7a82b4 00000000 
       4050643f 00000050 df71ff90 e08b2157 00000000 df71fce4 00000050 00000000 
Call Trace:    [<e08b88df>] [<e08cc57c>] [<e08b1983>] [<e08b2157>] [<c013a61f>]
  [<c015fc48>] [<c014c862>] [<c0131d3b>] [<c0130116>] [<c01b72d0>] [<c01b8c02>]
  [<c01b7e94>] [<c01bae7e>] [<c01ac0de>] [<c01abb9a>] [<c01302c3>] [<c012201c>]
  [<c0139562>] [<c0146931>] [<c0137cdf>] [<c01073cf>]
Code: 8b 00 ff 4b 08 c7 42 08 00 00 00 00 89 58 04 89 86 dc 00 00 


>>EIP; e08bd321 <[prism2_cs]hfa384x_destroy+61/110>   <=====

>>ebx; df72c0dc <_end+1f437e3c/20550dc0>
>>esi; df72c000 <_end+1f437d60/20550dc0>
>>edi; df72c000 <_end+1f437d60/20550dc0>
>>ebp; df71fc8c <_end+1f42b9ec/20550dc0>
>>esp; df71fc7c <_end+1f42b9dc/20550dc0>

Trace; e08b88df <[p80211]wlan_unsetup+6f/a0>
Trace; e08cc57c <[prism2_cs]prism2sta_detach+10c/190>
Trace; e08b1983 <[ds]unbind_request+a3/100>
Trace; e08b2157 <[ds]ds_ioctl+3e7/700>
Trace; c013a61f <getblk+4f/60>
Trace; c015fc48 <ext3_getblk+88/2d0>
Trace; c014c862 <inode_init_once+22/f0>
Trace; c0131d3b <__alloc_pages+4b/190>
Trace; c0130116 <kmem_cache_init_objs+126/130>
Trace; c01b72d0 <scrup+110/130>
Trace; c01b8c02 <lf+72/80>
Trace; c01b7e94 <hide_cursor+64/b0>
Trace; c01bae7e <do_con_write+2be/6f0>
Trace; c01ac0de <tty_fasync+7e/140>
Trace; c01abb9a <release_dev+54a/590>
Trace; c01302c3 <kmem_cache_free_one+f3/210>
Trace; c012201c <sys_rt_sigaction+7c/b0>
Trace; c0139562 <fput+c2/110>
Trace; c0146931 <sys_ioctl+b1/240>
Trace; c0137cdf <sys_close+4f/60>
Trace; c01073cf <system_call+33/38>

Code;  e08bd321 <[prism2_cs]hfa384x_destroy+61/110>
00000000 <_EIP>:
Code;  e08bd321 <[prism2_cs]hfa384x_destroy+61/110>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  e08bd323 <[prism2_cs]hfa384x_destroy+63/110>
   2:   ff 4b 08                  decl   0x8(%ebx)
Code;  e08bd326 <[prism2_cs]hfa384x_destroy+66/110>
   5:   c7 42 08 00 00 00 00      movl   $0x0,0x8(%edx)
Code;  e08bd32d <[prism2_cs]hfa384x_destroy+6d/110>
   c:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  e08bd330 <[prism2_cs]hfa384x_destroy+70/110>
   f:   89 86 dc 00 00 00         mov    %eax,0xdc(%esi)



--------------070303000106060508050009--

