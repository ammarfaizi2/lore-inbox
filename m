Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131591AbRCOA5y>; Wed, 14 Mar 2001 19:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131594AbRCOA5o>; Wed, 14 Mar 2001 19:57:44 -0500
Received: from ohiper0-157.apex.net ([209.250.50.157]:27398 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131591AbRCOA5d>; Wed, 14 Mar 2001 19:57:33 -0500
Date: Wed, 14 Mar 2001 19:00:34 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] in usbcore, 2.4.2-ac17
Message-ID: <20010314190034.A5094@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 6:56pm  up 1 day, 21:14,  1 user,  load average: 0.72, 0.41, 0.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the following oops while starting quake2 (one time) and running
mpg123 (another time).  It seems pretty reproduceable.  Kernel version
2.4.2-ac17, motherboard is a i810 chipset eMachines

Caveat emptor, this was typed by hand, but the two oopsen, after being
entered, where identical, so unless I made the same typo twice (or
miscopied twice)...

CPU:    0
EIP:    0010:[<c4858364>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000 ebx: 00001850 ecx: c1127e8c edx: 00000000
esi: 04000001 edi: 0000000a ebp: c1127e64 esp: c021bf0c
ds: 0018 es: 0018 ss: 0018
Stack: c117cce0 04000001 0000000a c021bfa0 00000001 c021bf98 c0168946 00008140
       00000001 c011bcd4 00000001 c485b127 c1127e64 00000000 c021bf98 c026352c
       c011b7e6 c020a3c0 c011940f c0109f2d 0000000a c116a6e4 c021bfa0 00000140
Call Trace: [<c0168946>][<c011bcd4>][<c485b127>][<c011b7e6>][<c011940f>][<c0109f2d>][<c010a08e>]
            [<c0108db0>][<c01a6bcd>][<c01a697c>][<c0107120>][<c01071a9>][<c0105000>][<c0100191>]
Code: f7 71 14 89 51 20 8b 41 28 40 83 e0 1f 89 41 28 8a 41 28 8d

>>EIP; c4858364 <[usbcore]usb_drivers_purge+240/288>   <=====
Trace; c0168946 <batch_entropy_process+aa/b0>
Trace; c011bcd4 <timer_bh+24/25c>
Trace; c485b127 <[usbcore]usb_get_port_status+f/38>
Trace; c011b7e6 <tqueue_bh+16/1c>
Trace; c011940f <bh_action+1b/60>
Trace; c0109f2d <handle_IRQ_event+31/5c>
Trace; c010a08e <do_IRQ+6e/b0>
Trace; c0108db0 <ret_from_intr+0/20>
Trace; c01a6bcd <acpi_idle+251/27c>
Trace; c01a697c <acpi_idle+0/27c>
Trace; c0107120 <default_idle+0/28>
Trace; c01071a9 <cpu_idle+41/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c4858364 <[usbcore]usb_drivers_purge+240/288>
00000000 <_EIP>:
Code;  c4858364 <[usbcore]usb_drivers_purge+240/288>   <=====
   0:   f7 71 14                  div    0x14(%ecx),%eax   <=====
Code;  c4858367 <[usbcore]usb_drivers_purge+243/288>
   3:   89 51 20                  mov    %edx,0x20(%ecx)
Code;  c485836a <[usbcore]usb_drivers_purge+246/288>
   6:   8b 41 28                  mov    0x28(%ecx),%eax
Code;  c485836d <[usbcore]usb_drivers_purge+249/288>
   9:   40                        inc    %eax
Code;  c485836e <[usbcore]usb_drivers_purge+24a/288>
   a:   83 e0 1f                  and    $0x1f,%eax
Code;  c4858371 <[usbcore]usb_drivers_purge+24d/288>
   d:   89 41 28                  mov    %eax,0x28(%ecx)
Code;  c4858374 <[usbcore]usb_drivers_purge+250/288>
  10:   8a 41 28                  mov    0x28(%ecx),%al
Code;  c4858377 <[usbcore]usb_drivers_purge+253/288>
  13:   8d 00                     lea    (%eax),%eax
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
