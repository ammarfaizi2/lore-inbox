Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132759AbRC2QNx>; Thu, 29 Mar 2001 11:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRC2QNn>; Thu, 29 Mar 2001 11:13:43 -0500
Received: from admin.csn.ul.ie ([136.201.105.1]:45576 "HELO admin.csn.ul.ie")
	by vger.kernel.org with SMTP id <S132759AbRC2QNc>;
	Thu, 29 Mar 2001 11:13:32 -0500
Date: Thu, 29 Mar 2001 17:12:39 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.2.19 USB and Digianswer/Tektronix sniffer 
Message-ID: <Pine.LNX.4.32.0103291710540.29897-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when boot Linux 2.2.19 with a Digianswer Bluetooth Sniffer plugged into
the USB I get the following oops ... I know the device isn't supported but
I'd like to be able to leave it plugged in without oopsen between
Linux/Windows..

Regards,
	Dave.

ksymoops 0.7c on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0120825>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000039   ebx: c40fc080   ecx: c01a2c68   edx: cf422000
esi: c1f69120   edi: 00000202   ebp: 00000000   esp: c6f95f1c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 1646, process nr: 100, stackpage=c6f95000)
Stack: 00000000 00000000 c1f6915c c01bed26 d09695ea c1f69120 ce79c600 00000010
       00000000 00000000 cf73d25c d0976b8d 00000000 ce79c600 d0968ad0 ce79c600
       ce79c600 00000000 d096993e ce79c600 ce79c600 00000000 00000000 00000001
Call Trace: [<d09695ea>] [<d0976b8d>] [<d0968ad0>] [<d096993e>] [<d096b659>] [<d096b719>] [<d09710e7>]
       [<d0970001>] [<d097253c>] [<d096b8bd>] [<d0968050>] [<c0107b8b>] [<d0968000>]
Code: c7 05 00 00 00 00 00 00 00 00 eb 1b 8d 76 00 56 68 22 b0 18

>>EIP; c0120825 <kfree+179/1a8>   <=====
Trace; d09695ea <[usbcore]usb_destroy_configuration+66/1a8>
Trace; d0976b8d <[usb-uhci]uhci_free_dev+29/30>
Trace; d0968ad0 <[usbcore]usb_free_dev+24/30>
Trace; d096993e <[usbcore]usb_disconnect+ea/f4>
Trace; d096b659 <[usbcore]usb_hub_port_connect_change+2f9/324>
Trace; d096b719 <[usbcore]usb_hub_events+95/1f0>
Trace; d09710e7 <[usbcore]usb_bandwidth_option+18a7/20b4>
Trace; d0970001 <[usbcore]usb_bandwidth_option+7c1/20b4>
Trace; d097253c <[usbcore]__ksymtab_usb_inc_dev_use+4/8>
Trace; d096b8bd <[usbcore]usb_hub_thread+49/6c>
Trace; d0968050 <[usbcore].text.start+4/8c>
Trace; c0107b8b <kernel_thread+23/30>
Trace; d0968000 <[serial].bss.end+778d/77d9>
Code;  c0120825 <kfree+179/1a8>
00000000 <_EIP>:
Code;  c0120825 <kfree+179/1a8>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c012082c <kfree+180/1a8>
   7:   00 00 00
Code;  c012082f <kfree+183/1a8>
   a:   eb 1b                     jmp    27 <_EIP+0x27> c012084c <kfree+1a0/1a8>
Code;  c0120831 <kfree+185/1a8>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0120834 <kfree+188/1a8>
   f:   56                        push   %esi
Code;  c0120835 <kfree+189/1a8>
  10:   68 22 b0 18 00            push   $0x18b022


1 warning issued.  Results may not be reliable.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


