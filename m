Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSFXP47>; Mon, 24 Jun 2002 11:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSFXP46>; Mon, 24 Jun 2002 11:56:58 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:36107 "EHLO
	mail.ludost.net") by vger.kernel.org with ESMTP id <S314325AbSFXP44>;
	Mon, 24 Jun 2002 11:56:56 -0400
Date: Mon, 24 Jun 2002 18:56:56 +0300 (EEST)
From: Vasil Kolev <vasil@dobrich.net>
X-X-Sender: <vasil@doom.bastun.net>
To: <urban@teststation.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: SMBFS related oops in 2.4.18
Message-ID: <Pine.LNX.4.33.0206241855130.18918-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an oops i got, after smbfs got stuck (and the file server was
working perfectly) and i killed smbmount, so i can umount it.

Any solution?


Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/media/video/bttv.o for module bttv has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/media/video/tuner.o for module tuner has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/i2c/i2c-algo-bit.o for module i2c-algo-bit has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/i2c/i2c-dev.o for module i2c-dev has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/i2c/i2c-core.o for module i2c-core has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/usb/usb-uhci.o for module usb-uhci has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/usb/usbcore.o for module usbcore has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/drivers/net/tulip/tulip.o for module tulip has changed since load
Unable to handle kernel paging request at virtual address e0000000
c016a6c7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c016a6c7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 6c888fd6   ebx: e0000000   ecx: fd40e3fd   edx: e281b65e
esi: bb92d60a   edi: ce79fe34   ebp: ce79fecc   esp: ce79fde4
ds: 0018   es: 0018   ss: 0018
Process du (pid: 13931, stackpage=ce79f000)
Stack: c0137db0 ce79fe9c e0866198 00000001 00000000 00000000 00000000 c999b980
       c8fc1480 00000000 030f4e99 00000000 00000000 00000000 ddb53000 00000002
       00000000 00000000 00000001 00000004 c0168fe5 dbf7f180 ce79ffb0 c0137db0
Call Trace: [<c0137db0>] [<c0168fe5>] [<c0137db0>] [<c0137db0>] [<c01207bb>]
   [<c0169074>] [<c0137db0>] [<c0169f2b>] [<c0137db0>] [<c0137a2b>] [<c0137db0>]
   [<c0137f13>] [<c0137db0>] [<c013741b>] [<c0106b1b>]
Code: 0f b6 03 43 89 c2 c1 e2 04 01 f2 c1 e8 04 01 c2 8d 04 92 8d


>>EIP; c016a6c7 <smb_fill_cache+53/2dc>   <=====

>>eax; 6c888fd6 Before first symbol
>>ebx; e0000000 <_end+1fd09ca4/20519ca4>
>>ecx; fd40e3fd <END_OF_CODE+1cbbf35e/????>
>>edx; e281b65e <END_OF_CODE+1fcc5bf/????>
>>esi; bb92d60a Before first symbol
>>edi; ce79fe34 <_end+e4a9ad8/20519ca4>
>>ebp; ce79fecc <_end+e4a9b70/20519ca4>
>>esp; ce79fde4 <_end+e4a9a88/20519ca4>

Trace; c0137db0 <filldir64+0/114>
Trace; c0168fe5 <smb_proc_readdir_long+3d1/434>
Trace; c0137db0 <filldir64+0/114>
Trace; c0137db0 <filldir64+0/114>
Trace; c01207bb <find_or_create_page+b7/d0>
Trace; c0169074 <smb_proc_readdir+2c/40>
Trace; c0137db0 <filldir64+0/114>
Trace; c0169f2b <smb_readdir+37b/41c>
Trace; c0137db0 <filldir64+0/114>
Trace; c0137a2b <vfs_readdir+5b/7c>
Trace; c0137db0 <filldir64+0/114>
Trace; c0137f13 <sys_getdents64+4f/b3>
Trace; c0137db0 <filldir64+0/114>
Trace; c013741b <sys_fcntl64+7f/88>
Trace; c0106b1b <system_call+33/38>

Code;  c016a6c7 <smb_fill_cache+53/2dc>
00000000 <_EIP>:
Code;  c016a6c7 <smb_fill_cache+53/2dc>   <=====
   0:   0f b6 03                  movzbl (%ebx),%eax   <=====
Code;  c016a6ca <smb_fill_cache+56/2dc>
   3:   43                        inc    %ebx
Code;  c016a6cb <smb_fill_cache+57/2dc>
   4:   89 c2                     mov    %eax,%edx
Code;  c016a6cd <smb_fill_cache+59/2dc>
   6:   c1 e2 04                  shl    $0x4,%edx
Code;  c016a6d0 <smb_fill_cache+5c/2dc>
   9:   01 f2                     add    %esi,%edx
Code;  c016a6d2 <smb_fill_cache+5e/2dc>
   b:   c1 e8 04                  shr    $0x4,%eax
Code;  c016a6d5 <smb_fill_cache+61/2dc>
   e:   01 c2                     add    %eax,%edx
Code;  c016a6d7 <smb_fill_cache+63/2dc>
  10:   8d 04 92                  lea    (%edx,%edx,4),%eax
Code;  c016a6da <smb_fill_cache+66/2dc>
  13:   8d 00                     lea    (%eax),%eax


8 warnings issued.  Results may not be reliable.

