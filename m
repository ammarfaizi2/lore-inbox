Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTIBSLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTIBSJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:09:01 -0400
Received: from molly.vabo.cz ([160.216.153.99]:44816 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S263848AbTIBSHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:07:04 -0400
Date: Tue, 2 Sep 2003 20:07:09 +0200 (CEST)
From: Tomas Konir <moje@vabo.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@vger.kernel.org
Subject: 2.4.22 + XFS oops with palm usb sync
Message-ID: <Pine.LNX.4.53.0309022000260.7734@moje.vabo.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
2.4.22 periodically oops after synchronization my palm (Tungsten T).
Only XFS patches in kernel and no other. On usb was palm and Microsoft 
mouse. (sometimes with previous kernels the mouse was disconnected after 
synchronization). 


Unable to handle kernel NULL pointer dereference at virtual address 
00000998
e0a7b66a
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<e0a7b66a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: 00000000   ebx: d3945400   ecx: df272000   edx: de991f7c
esi: d394541c   edi: 00000000   ebp: d3945400   esp: df273f20
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 152, stackpage=df273000)
Stack: d394541c 00000000 00000010 e0a7cca0 00000000 e0a7cc80 d2e9d180 
e081d198
       dde72600 d3945400 dde72604 00000003 00000000 dde72600 00000100 
dfe5d800
       00000001 0000000a e081ff52 dfe5d910 00000002 00000010 d2e9d580 
e081fbac
Call Trace:    [<e0a7cca0>] [<e0a7cc80>] [<e081d198>] [<e081ff52>] 
[<e081fbac>]
  [<e08203b2>] [<e08204ac>] [<c010580b>] [<e0820470>]
Code: c7 80 98 09 00 00 00 00 00 00 8d 4e 58 ff 43 74 0f 8e c8 05


>>EIP; e0a7b66a <[usbserial]usb_serial_disconnect+6a/270>   <=====

>>ebx; d3945400 <_end+135a73c8/2047a028>
>>ecx; df272000 <_end+1eed3fc8/2047a028>
>>edx; de991f7c <_end+1e5f3f44/2047a028>
>>esi; d394541c <_end+135a73e4/2047a028>
>>ebp; d3945400 <_end+135a73c8/2047a028>
>>esp; df273f20 <_end+1eed5ee8/2047a028>

Trace; e0a7cca0 <[usbserial]__module_parm_debug+d/11>
Trace; e0a7cc80 <[usbserial]usb_serial_driver+0/7>
Trace; e081d198 <[usbcore]usb_disconnect+b8/160>
Trace; e081ff52 <[usbcore]usb_hub_port_connect_change+82/2b0>
Trace; e081fbac <[usbcore]usb_hub_port_status+6c/a0>
Trace; e08203b2 <[usbcore]usb_hub_events+232/2f0>
Trace; e08204ac <[usbcore]usb_hub_thread+3c/c0>
Trace; c010580b <arch_kernel_thread+2b/40>
Trace; e0820470 <[usbcore]usb_hub_thread+0/c0>

Code;  e0a7b66a <[usbserial]usb_serial_disconnect+6a/270>
00000000 <_EIP>:
Code;  e0a7b66a <[usbserial]usb_serial_disconnect+6a/270>   <=====
   0:   c7 80 98 09 00 00 00      movl   $0x0,0x998(%eax)   <=====
Code;  e0a7b671 <[usbserial]usb_serial_disconnect+71/270>
   7:   00 00 00
Code;  e0a7b674 <[usbserial]usb_serial_disconnect+74/270>
   a:   8d 4e 58                  lea    0x58(%esi),%ecx
Code;  e0a7b677 <[usbserial]usb_serial_disconnect+77/270>
   d:   ff 43 74                  incl   0x74(%ebx)
Code;  e0a7b67a <[usbserial]usb_serial_disconnect+7a/270>
  10:   0f 8e c8 05 00 00         jle    5de <_EIP+0x5de>


-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

Hi
2.4.22 periodically oops after synchronization my palm (Tungsten T).
Only XFS patches in kernel and no other. On usb was palm and Microsoft 
mouse. (sometimes with previous kernels the mouse was disconnected after 
synchronization). 


Unable to handle kernel NULL pointer dereference at virtual address 
00000998
e0a7b66a
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<e0a7b66a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: 00000000   ebx: d3945400   ecx: df272000   edx: de991f7c
esi: d394541c   edi: 00000000   ebp: d3945400   esp: df273f20
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 152, stackpage=df273000)
Stack: d394541c 00000000 00000010 e0a7cca0 00000000 e0a7cc80 d2e9d180 
e081d198
       dde72600 d3945400 dde72604 00000003 00000000 dde72600 00000100 
dfe5d800
       00000001 0000000a e081ff52 dfe5d910 00000002 00000010 d2e9d580 
e081fbac
Call Trace:    [<e0a7cca0>] [<e0a7cc80>] [<e081d198>] [<e081ff52>] 
[<e081fbac>]
  [<e08203b2>] [<e08204ac>] [<c010580b>] [<e0820470>]
Code: c7 80 98 09 00 00 00 00 00 00 8d 4e 58 ff 43 74 0f 8e c8 05


>>EIP; e0a7b66a <[usbserial]usb_serial_disconnect+6a/270>   <=====

>>ebx; d3945400 <_end+135a73c8/2047a028>
>>ecx; df272000 <_end+1eed3fc8/2047a028>
>>edx; de991f7c <_end+1e5f3f44/2047a028>
>>esi; d394541c <_end+135a73e4/2047a028>
>>ebp; d3945400 <_end+135a73c8/2047a028>
>>esp; df273f20 <_end+1eed5ee8/2047a028>

Trace; e0a7cca0 <[usbserial]__module_parm_debug+d/11>
Trace; e0a7cc80 <[usbserial]usb_serial_driver+0/7>
Trace; e081d198 <[usbcore]usb_disconnect+b8/160>
Trace; e081ff52 <[usbcore]usb_hub_port_connect_change+82/2b0>
Trace; e081fbac <[usbcore]usb_hub_port_status+6c/a0>
Trace; e08203b2 <[usbcore]usb_hub_events+232/2f0>
Trace; e08204ac <[usbcore]usb_hub_thread+3c/c0>
Trace; c010580b <arch_kernel_thread+2b/40>
Trace; e0820470 <[usbcore]usb_hub_thread+0/c0>

Code;  e0a7b66a <[usbserial]usb_serial_disconnect+6a/270>
00000000 <_EIP>:
Code;  e0a7b66a <[usbserial]usb_serial_disconnect+6a/270>   <=====
   0:   c7 80 98 09 00 00 00      movl   $0x0,0x998(%eax)   <=====
Code;  e0a7b671 <[usbserial]usb_serial_disconnect+71/270>
   7:   00 00 00
Code;  e0a7b674 <[usbserial]usb_serial_disconnect+74/270>
   a:   8d 4e 58                  lea    0x58(%esi),%ecx
Code;  e0a7b677 <[usbserial]usb_serial_disconnect+77/270>
   d:   ff 43 74                  incl   0x74(%ebx)
Code;  e0a7b67a <[usbserial]usb_serial_disconnect+7a/270>
  10:   0f 8e c8 05 00 00         jle    5de <_EIP+0x5de>


-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

