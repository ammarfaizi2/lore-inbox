Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317712AbSGVQjc>; Mon, 22 Jul 2002 12:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317714AbSGVQjc>; Mon, 22 Jul 2002 12:39:32 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:18816 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S317712AbSGVQja>; Mon, 22 Jul 2002 12:39:30 -0400
Date: Mon, 22 Jul 2002 09:42:21 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: console lockup and oops 2.5.27
Message-ID: <20020722164221.GA1358@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.5.24 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!
I have for the last couple kernels been unable to boot(2.5.24 runs
fine), no oops that I saw in 2.5.26 but then again not a funtional
system. On 2.5.27 I did get a oops. Symptoms are: system seems to boot
up to the time to login. no console login and only Ctr Scroll Lock
works. Daemons show up as active tasks running. About a minute latter
message appears on console

Init: Id "1" respawning to fast disabled for 5 minutes.
Init: Id "5" respawning to fast disabled for 5 minutes.
Init: Id "6" respawning to fast disabled for 5 minutes.
And then it oops.

ksymoops 2.4.5 on i686 2.5.24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27/ (specified)
     -m /usr/src/linux-2.5.27/System.map (specified)

<SNIP> on miss-matches.

Unable to handle kernel paging request at virtual address 20706573
20706573
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<20706573>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: efb30130   ebx: c02aa284   ecx: 7272746d   edx: 20706573
esi: c17b9fa4   edi: effc37ca   ebp: c17b8000   esp: c17b9f94
ds: 0018   es: 0018   ss: 0018
Stack: c011adac 7272746d effc3580 c0257a0b efb30130 c02aa284 c01229e9 c02a3568 
       00000700 effc5fc4 c02d8180 0008e000 effc3580 00000001 00000000 effc5fc4 
       00010000 00000000 00000000 effc3580 c0113f10 00000000 00000000 c0106fc8 
Call Trace: [<c011adac>] [<c01229e9>] [<c0113f10>] [<c0106fc8>] 
Code:  Bad EIP value.


>>EIP; 20706573 Before first symbol   <=====

>>eax; efb30130 <_end+2f802d7c/3058bc4c>
>>ebx; c02aa284 <console_callback_tq+0/14>
>>ecx; 7272746d Before first symbol
>>edx; 20706573 Before first symbol
>>esi; c17b9fa4 <_end+148cbf0/3058bc4c>
>>edi; effc37ca <_end+2fc96416/3058bc4c>
>>ebp; c17b8000 <_end+148ac4c/3058bc4c>
>>esp; c17b9f94 <_end+148cbe0/3058bc4c>

Trace; c011adac <__run_task_queue+4c/60>
Trace; c01229e9 <context_thread+149/1e0>
Trace; c0113f10 <default_wake_function+0/40>
Trace; c0106fc8 <kernel_thread+28/40>


1465 warnings issued.  Results may not be reliable.

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.5.24 #17 Wed Jul 17 09:59:23 PDT 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12
Modules Loaded         nls_cp437 nls_iso8859-1 smbfs snd-cmipci snd-opl3-lib snd-hwdep snd-mpu401-uart snd-rawmidi radeon ipx psnap p8022 binfmt_misc hid usbmouse uhci-hcd ohci-hcd ehci-hcd vfat fat sr_mod cdrom 3c59x




As allways if anyone need additional info I am more then happy to help. 

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


