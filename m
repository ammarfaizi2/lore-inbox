Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTK3T5X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTK3T5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:57:23 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:18380 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S262925AbTK3T5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:57:21 -0500
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 09:34:44 -0800
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130.093449.-1591395.2.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0-13,15-26,28,30,32-64
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please post the oops (run through ksymoops as-needed).

I still think the one line test program was easier...

I hope this helps

# ksymoops -m /boot/System.map-2.4.22 Oops.file
ksymoops 2.4.9 on i586 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22 (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000000
c0141937
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0141937>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c1b14410   ecx: c1b143f0   edx: c1b14410
esi: 00000002   edi: 00000000   ebp: c1f81f80   esp: c1f81f60
ds: 0018   es: 0018   ss: 0018
Process a.out (pid: 1331, stackpage=c1f81000)
Stack: c1fe4f24 c38d25c0 c1fe46a0 c1fe46ac c1b143f0 00000000 00000000
c2047654 
       c1f81fbc c0133d06 c2047654 00000002 00000000 00000000 c0123c5c
0804a000 
       00001000 c1f80000 c0141820 ffffffea c1f80000 080495a8 00000002
bffffaa8 
Call Trace:    [<c0133d06>] [<c0123c5c>] [<c0141820>] [<c01071e3>]
Code: 89 10 8b 5d 08 8b 43 08 8b 40 08 8d 48 6c ff 40 6c 0f 8e f7 


>>EIP; c0141937 <dcache_dir_lseek+117/150>   <=====

>>ebx; c1b14410 <_end+186dcb8/455b908>
>>ecx; c1b143f0 <_end+186dc98/455b908>
>>edx; c1b14410 <_end+186dcb8/455b908>
>>ebp; c1f81f80 <_end+1cdb828/455b908>
>>esp; c1f81f60 <_end+1cdb808/455b908>

Trace; c0133d06 <sys_lseek+56/a0>
Trace; c0123c5c <sys_brk+ec/120>
Trace; c0141820 <dcache_dir_lseek+0/150>
Trace; c01071e3 <system_call+33/40>

Code;  c0141937 <dcache_dir_lseek+117/150>
00000000 <_EIP>:
Code;  c0141937 <dcache_dir_lseek+117/150>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c0141939 <dcache_dir_lseek+119/150>
   2:   8b 5d 08                  mov    0x8(%ebp),%ebx
Code;  c014193c <dcache_dir_lseek+11c/150>
   5:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c014193f <dcache_dir_lseek+11f/150>
   8:   8b 40 08                  mov    0x8(%eax),%eax
Code;  c0141942 <dcache_dir_lseek+122/150>
   b:   8d 48 6c                  lea    0x6c(%eax),%ecx
Code;  c0141945 <dcache_dir_lseek+125/150>
   e:   ff 40 6c                  incl   0x6c(%eax)
Code;  c0141948 <dcache_dir_lseek+128/150>
  11:   0f 8e f7 00 00 00         jle    10e <_EIP+0x10e>

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
