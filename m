Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSJZJdH>; Sat, 26 Oct 2002 05:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbSJZJdH>; Sat, 26 Oct 2002 05:33:07 -0400
Received: from stud3.tuwien.ac.at ([193.170.75.13]:16086 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S262023AbSJZJdF>; Sat, 26 Oct 2002 05:33:05 -0400
Date: Sat, 26 Oct 2002 11:39:19 +0200
From: Stefan Schwandter <swan@shockfrosted.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac3 oops (usb related?)
Message-ID: <20021026093919.GA1320@TK150122.tuwien.teleweb.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!


reboot segfaults with 2.5.44-ac3 (and 2.5.44 vanilla). I've appended
ksymoops output (from -ac3).


regards, Stefan

-- 
----> http://www.shockfrosted.org

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.6 on i686 2.5.44-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44-ac3/ (default)
     -m /boot/System.map-2.5.44-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 26 11:10:31 TK150122 kernel: Machine check exception polling timer started.
Oct 26 11:10:31 TK150122 kernel:  WARNING: unexpected IO-APIC, please mail
Oct 26 11:10:31 TK150122 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Oct 26 11:30:26 TK150122 kernel: c0237335
Oct 26 11:30:26 TK150122 kernel: Oops: 0000
Oct 26 11:30:26 TK150122 kernel: CPU:    0
Oct 26 11:30:26 TK150122 kernel: EIP:    0060:[driver_detach+53/80]    Not tainted
Oct 26 11:30:26 TK150122 kernel: EFLAGS: 00010246
Oct 26 11:30:26 TK150122 kernel: eax: 00000000   ebx: c523fcd0   ecx: c0430170   edx: 00000000
Oct 26 11:30:26 TK150122 kernel: esi: 00000000   edi: e08cea40   ebp: e08ba000   esp: de8cdf4c
Oct 26 11:30:26 TK150122 kernel: ds: 0068   es: 0068   ss: 0068
Oct 26 11:30:26 TK150122 kernel: Stack: e08ceaa0 e08cea40 e08ceaa4 c0237558 e08cea40 e08cea40 e08ceaa0 df185000 
Oct 26 11:30:26 TK150122 kernel:        c0237958 e08cea40 e08cea40 e08ba000 c02379fb e08cea40 fffffff0 e08bb453 
Oct 26 11:30:26 TK150122 kernel:        e08cea40 c011a2b7 fffffff0 e08ba000 df185000 bfffeda8 c0119510 e08ba000 
Oct 26 11:30:26 TK150122 kernel: Call Trace:
Oct 26 11:30:26 TK150122 kernel:  [<e08ceaa0>] usb_bus_type+0x0/0x80 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08ceaa4>] usb_bus_type+0x4/0x80 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08ceaa0>] usb_bus_type+0x0/0x80 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08bb453>] usb_exit+0x13/0x30 [usbcore]
Oct 26 11:30:26 TK150122 kernel:  [<e08cea40>] usb_generic_driver+0x0/0x60 [usbcore]
Oct 26 11:30:26 TK150122 kernel: Code: 8b 32 8d 47 28 39 c2 75 d5 5b 5e 5f c3 8d b4 26 00 00 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c523fcd0 <_end+4d80518/203d78a8>
>>ecx; c0430170 <kbd_sysrq_xlate+30/80>
>>edi; e08cea40 <[ehci-hcd].data.end+1/1621>
>>ebp; e08ba000 <[usbcore]usb_create_driverfs_intf_files+30/40>
>>esp; de8cdf4c <_end+1e40e794/203d78a8>

Trace; e08ceaa0 <[ehci-hcd].data.end+61/1621>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>
Trace; e08ceaa4 <[ehci-hcd].data.end+65/1621>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>
Trace; e08ceaa0 <[ehci-hcd].data.end+61/1621>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>
Trace; e08bb453 <[usbcore]proc_bulk+1d3/220>
Trace; e08cea40 <[ehci-hcd].data.end+1/1621>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 32                     mov    (%edx),%esi
Code;  00000002 Before first symbol
   2:   8d 47 28                  lea    0x28(%edi),%eax
Code;  00000005 Before first symbol
   5:   39 c2                     cmp    %eax,%edx
Code;  00000007 Before first symbol
   7:   75 d5                     jne    ffffffde <_EIP+0xffffffde>
Code;  00000009 Before first symbol
   9:   5b                        pop    %ebx
Code;  0000000a Before first symbol
   a:   5e                        pop    %esi
Code;  0000000b Before first symbol
   b:   5f                        pop    %edi
Code;  0000000c Before first symbol
   c:   c3                        ret    
Code;  0000000d Before first symbol
   d:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi

Oct 26 11:32:46 TK150122 kernel: Machine check exception polling timer started.
Oct 26 11:32:46 TK150122 kernel:  WARNING: unexpected IO-APIC, please mail
Oct 26 11:32:46 TK150122 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html

1 warning issued.  Results may not be reliable.

--oyUTqETQ0mS9luUI--
