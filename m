Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSDOHpU>; Mon, 15 Apr 2002 03:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313047AbSDOHpS>; Mon, 15 Apr 2002 03:45:18 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:42189 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S311587AbSDOHpS>; Mon, 15 Apr 2002 03:45:18 -0400
Message-ID: <3CBA8506.AE090B97@delusion.de>
Date: Mon, 15 Apr 2002 09:45:10 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Greg Kroah-Hartman <greg@kroah.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: OOPS: USB disconnect
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

I got the following oops with 2.5.8. Everything worked fine under 2.5.7.

-Udo.

ksymoops 2.4.4 on i686 2.5.8.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.8/ (default)
     -m /boot/System.map-2.5.8 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 71596198
c0249608
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0249608>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 71596180   ebx: c1318000   ecx: c03457e0   edx: 71596180
esi: cfd2dac0   edi: c03457e0   ebp: 00000000   esp: cff3df24
ds: 0018   es: 0018   ss: 0018
Stack: c02592dd 71596180 cf89fb40 c03457c0 c024a451 cfce1600 c1318000 cfce15b8 
       cfd2d9c0 c03452c0 0000000f 00000000 cfce1600 c024a4c3 cfce15b8 00000100 
       00000004 00000002 c1369c00 000000c4 cfce1400 c024c76e c1369dbc 00000001 
Call Trace: [<c02592dd>] [<c024a451>] [<c024a4c3>] [<c024c76e>] [<c024c44d>] 
   [<c024caf9>] [<c024ccb7>] [<c0105668>] 
Code: 8b 42 18 85 c0 74 21 8b 80 cc 00 00 00 85 c0 74 17 8b 40 18 

>>EIP; c0249608 <usb_unlink_urb+8/40>   <=====
Trace; c02592dd <hid_disconnect+1d/90>
Trace; c024a451 <usb_disconnect+91/160>
Trace; c024a4c3 <usb_disconnect+103/160>
Trace; c024c76e <usb_hub_port_connect_change+4e/2c0>
Trace; c024c44d <usb_hub_port_status+6d/80>
Trace; c024caf9 <usb_hub_events+119/2a0>
Trace; c024ccb7 <usb_hub_thread+37/90>
Trace; c0105668 <kernel_thread+28/40>
Code;  c0249608 <usb_unlink_urb+8/40>
00000000 <_EIP>:
Code;  c0249608 <usb_unlink_urb+8/40>   <=====
   0:   8b 42 18                  mov    0x18(%edx),%eax   <=====
Code;  c024960b <usb_unlink_urb+b/40>
   3:   85 c0                     test   %eax,%eax
Code;  c024960d <usb_unlink_urb+d/40>
   5:   74 21                     je     28 <_EIP+0x28> c0249630 <usb_unlink_urb+30/40>
Code;  c024960f <usb_unlink_urb+f/40>
   7:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax
Code;  c0249615 <usb_unlink_urb+15/40>
   d:   85 c0                     test   %eax,%eax
Code;  c0249617 <usb_unlink_urb+17/40>
   f:   74 17                     je     28 <_EIP+0x28> c0249630 <usb_unlink_urb+30/40>
Code;  c0249619 <usb_unlink_urb+19/40>
  11:   8b 40 18                  mov    0x18(%eax),%eax
