Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbRGTU6C>; Fri, 20 Jul 2001 16:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbRGTU5w>; Fri, 20 Jul 2001 16:57:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16345 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267384AbRGTU5k>; Fri, 20 Jul 2001 16:57:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paul Larson <plars@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-pre9 oops
Date: Fri, 20 Jul 2001 15:58:52 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072015585201.07147@plars.austin.ibm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I got this oops message with 2.4.7-pre9 on SuSE 7.2 today.  It happened 
during bootup, from the boot.omsg log, it looks like maybe right after the 
swapspace was added.  Ksymoops parsed oops message is attached below.  Please 
let me know if any other information would help.  I'm not a subscriber, so 
please email me directly.

Thanks,
Paul Larson

ksymoops 2.4.1 on i686 2.4.4-64GB-SMP.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.4-64GB-SMP/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
<4> WARNING: unexpected IO-APIC, please mail
<4>cpu: 0, clocks: 1329068, slice: 664534
<5>ds: no socket drivers loaded!
<1>Unable to handle kernel NULL pointer dereference at virtual address 
0000007c
<4>c01458f2
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[proc_pid_make_inode+130/176]
<4>EFLAGS: 00010206
<4>eax: 00000000   ebx: c1450000   ecx: cf9ca400   edx: c1056564
<4>esi: cfedc000   edi: 0000000b   ebp: cf9f0760   esp: cf9f7eb4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process ps (pid: 59, stackpage=cf9f7000)
<4>Stack: c02a52c0 cf9f07c0 c0247b0f c0145b1a cfedc000 c1450000 0000000b 
fffffff4
<4>       cf9ca220 cf9f0760 cf9f06e0 ffffffea c0136e6b cf9ca220 cf9f0760 
cf9f7f2c
<4>       00000000 cf9ca220 cf9f7f84 c0137511 cf9f06e0 cf9f7f2c 00000000 
c149c000
<4>Call Trace: [proc_base_lookup+134/536] [real_lookup+83/196] 
[path_walk+1321/1880] [open_namei+134/1404] [filp_open+59/92] 
[sys_open+56/184] [system_call+51/56]
<4>Code: f6 40 7c 01 74 12 8b 83 24 01 00 00 89 41 30 8b 83 34 01 00
Using defaults from ksymoops -t elf32-i386 -a i386
 
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)
Code;  00000004 Before first symbol
   4:   74 12                     je     18 <_EIP+0x18> 00000018 Before first 
symbol
Code;  00000006 Before first symbol
   6:   8b 83 24 01 00 00         mov    0x124(%ebx),%eax
Code;  0000000c Before first symbol
   c:   89 41 30                  mov    %eax,0x30(%ecx)
Code;  0000000f Before first symbol
   f:   8b 83 34 01 00 00         mov    0x134(%ebx),%eax
