Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131547AbRCQEwE>; Fri, 16 Mar 2001 23:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131550AbRCQEvp>; Fri, 16 Mar 2001 23:51:45 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:38916 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S131547AbRCQEvm> convert rfc822-to-8bit; Fri, 16 Mar 2001 23:51:42 -0500
Date: Sat, 17 Mar 2001 01:53:26 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops in 2.4.2-ac20
Message-ID: <20010317015326.A650@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What the subject says.

I copied the oops by hand, but the output of ksymoops doesn't
seem too totally wrong, so I guess I didn't botch it :)

I can't blame the box; I was about to Aiee myself, radeonfb is so
slow.


ksymoops output:
---8<----
ksymoops 2.3.7 on i686 2.4.2-ac20.  Options used
     -V (default)
     -k /var/log/ksymoops/20010317003908.ksyms (specified)
     -l /var/log/ksymoops/20010317003908.modules (specified)
     -O (specified)
     -M (specified)

Kernel BUG at printk.c:458!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011839c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: ce27090c   ecx: c02a97c0   edx: 00004dee
esi: cda3b000   edi: cda3b16f   ebp: 00000000   esp: c0dc7e34
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02c7000)
Stack: c0255934 000001ca c01a0a10 cda3b000 c0194caf cda3b000 00000003 cda3b000
       00000001 cda3b56c c02ae800 42000246 c01adacf 00000000 0000a000 cda3b56f
       cda3b16f c0344260 c01b2e55 c03442a0 c01b2770 000003e8 c01b2cb8 00000002
Call Trace: [<c01a0a10>] [<c0194caf>] [<c01adacf>] [<c01b4e55>] [<c01b2770>] [<c01b2cb8>] [<c0113c0b>]
       [<c01a64e2>] [<c01924a7>] [<c011d299>] [<c011ff5e>] [<c011d0a5>] [<c011cf85>] [<c011cdac>] [<c010affa>]
       [<c01071e0>] [<c01071e0>] [<c010962c>] [<c01071e0>] [<c01071e0>] [<c0100018>] [<c010720d>] [<c0107272>]
       [<c0105000>] [<c01001cf>]
Code: 0f 0b 83 c4 08 b9 c0 97 2a c0 f0 ff 0d c0 97 2a c0 0f 88 a1

>>EIP; c011839c <acquire_console_sem+2c/1c4>   <=====
Trace; c01a0a10 <vc_resize+3230/347c>
Trace; c0194caf <tty_unregister_driver+2447/34e8>
Trace; c01adacf <ide_set_handler+9f/f0>
Trace; c01b4e55 <ide_config_drive_speed+2aa5/3ed0>
Trace; c01b2770 <ide_config_drive_speed+3c0/3ed0>
Trace; c01b2cb8 <ide_config_drive_speed+908/3ed0>
Trace; c0113c0b <iounmap+18b/40c>
Trace; c01a64e2 <handle_scancode+386/6448>
Trace; c01924a7 <do_SAK+347/350>
Trace; c011d299 <__run_task_queue+cd/278>
Trace; c011ff5e <del_timer_sync+112/f84>
Trace; c011d0a5 <tasklet_kill+d1/1b4>
Trace; c011cf85 <get_fast_time+99d/9c8>
Trace; c011cdac <get_fast_time+7c4/9c8>
Trace; c010affa <enable_irq+2ae/2c0>
Trace; c01071e0 <enable_hlt+8/1dc>
Trace; c01071e0 <enable_hlt+8/1dc>
Trace; c010962c <__read_lock_failed+1440/2804>
Trace; c01071e0 <enable_hlt+8/1dc>
Trace; c01071e0 <enable_hlt+8/1dc>
Trace; c0100018 Before first symbol
Trace; c010720d <enable_hlt+35/1dc>
Trace; c0107272 <enable_hlt+9a/1dc>
Trace; c0105000 <gdt+4d94/6f64>
Trace; c01001cf Before first symbol
Code;  c011839c <acquire_console_sem+2c/1c4>
00000000 <_EIP>:
Code;  c011839c <acquire_console_sem+2c/1c4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011839e <acquire_console_sem+2e/1c4>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c01183a1 <acquire_console_sem+31/1c4>
   5:   b9 c0 97 2a c0            mov    $0xc02a97c0,%ecx
Code;  c01183a6 <acquire_console_sem+36/1c4>
   a:   f0 ff 0d c0 97 2a c0      lock decl 0xc02a97c0
Code;  c01183ad <acquire_console_sem+3d/1c4>
  11:   0f 88 a1 00 00 00         js     b8 <_EIP+0xb8> c0118454 <acquire_console_sem+e4/1c4>

 <0>Kernel panic: Aiee, killing interrupt handler!
---->8---

output of ver_linux:
---8<----
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.58
Kbd                    1.04
Sh-utils               2.0.11
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc
---->8---
(I guess ver_linux needs updating)

/proc/cpuinfo:
---8<----
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.611
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.611
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1402.47


---->8---

/var/log/ksymoops/20010317003908.modules
---8<----
agpgart                14912   0 (unused)
---->8---


Anything else?

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
<sel> need help: my first packet to my provider gets lost :-( <netgod> sel: dont send the first one, start with #2 1 1.bak 24.m3u 2cooltek_order.html 3Daccelx_V2-2.0ALPHA-30.i386.rpm 9skin.zip AYB AYB.tar.gz AYB.tar.gz~ Hobby Mail Media MyPilot Nautilus News PC_Product_Compare.pdf Sent Untitled1.bak XF86Config-4 bday_2001.abw bin chesterfield-lemonology-cdart.zip component.reg conni.zip conni_elektra.zip d3_ref.pdf dmusic-158.rmp drag_and_drop2.jpg easymouse+.exe evolution fba06a.pdf fba09a.pdf fba12g.pdf gears.strace index.html kernelnewbies-fortunes.tar.gz linuxq3a-1.27g-beta1.tar.gz lotr_640_internet.mpg lpg-0.4_IPC.ps lpg-0.4_IPC_even.ps mandy.zip mslugx.zip mudsh nezmouse+.exe openlogo-nd.xcf openlogo.xcf openlogo.xpm openlogo.xpm.bz2 oreilly_linux_poster.pdf output.ps presupuesto.gnumeric programa_test.abw public_html pyre.mpg q3mdl-attorney.zip q3mdl-conni.zip q3mdl-spanky.zip q3mdl-tankgirl.zip q3ta_trailer.mpg so-5_2-ga-bin-windows-en-001.bin src suse12x22.diff tmp xfree86_4.0.2-7.diff.gz xsvc-1.5-8.i386.rpm ymessenger-0.93.0-1.i386.rpm netgod is kidding
