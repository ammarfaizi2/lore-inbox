Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136552AbREIPn1>; Wed, 9 May 2001 11:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136554AbREIPnR>; Wed, 9 May 2001 11:43:17 -0400
Received: from mail.family-net.net ([209.144.36.4]:44438 "EHLO
	mail.family-net.net") by vger.kernel.org with ESMTP
	id <S136552AbREIPnK>; Wed, 9 May 2001 11:43:10 -0400
Message-ID: <3AF96624.A159FA5B@clinton-famnet.com>
Date: Wed, 09 May 2001 10:45:40 -0500
From: Terry Shull <tshull@clinton-famnet.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops 2.4.4-ac5/ac6 2.4.5-pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following oops seems to have started with the addition of the
SanDisk module.



May  9 10:05:11 localhost kernel: hub.c: USB hub found
May  9 10:05:11 localhost kernel: hub.c: 2 ports detected
May  9 10:05:11 localhost kernel: usb.c: USB disconnect on device 1
May  9 10:05:11 localhost kernel: usb.c: USB disconnect on device 0
May  9 10:05:11 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000c
May  9 10:05:11 localhost kernel:  printing eip:
May  9 10:05:11 localhost kernel: c01f291b
May  9 10:05:11 localhost kernel: pgd entry df10c000: 0000000000000000
May  9 10:05:11 localhost kernel: pmd entry df10c000: 0000000000000000
May  9 10:05:11 localhost kernel: ... pmd not present!
May  9 10:05:11 localhost kernel: Oops: 0000
May  9 10:05:11 localhost kernel: CPU:    0
May  9 10:05:11 localhost kernel: EIP:    0010:[call_policy+427/608]
May  9 10:05:11 localhost kernel: EIP:    0010:[<c01f291b>]
May  9 10:05:11 localhost kernel: EFLAGS: 00010246
May  9 10:05:11 localhost kernel: eax: 00000000   ebx: df97eae4   ecx:
c0273f1d   edx: c0273f1c
May  9 10:05:11 localhost kernel: esi: dfffaa60   edi: df094e00   ebp:
df97eaa0   esp: df0dbef4
May  9 10:05:11 localhost kernel: ds: 0018   es: 0018   ss: 0018
May  9 10:05:11 localhost kernel: Process modprobe (pid: 223,
stackpage=df0db000)
May  9 10:05:11 localhost kernel: Stack: 00000008 c0292b20 c0273e6a
00000000 df094e00 df094e40 df094f2c 00000000 
May  9 10:05:11 localhost kernel:        df094e00 c01f3b8c c02744c7
df094e00 c01f5b6c ffffffff df8c4c04 df8c4cf0 
May  9 10:05:11 localhost kernel:        df93d760 df8c4c00 c01f3b70
df8c4cf0 00000018 0000000e df97eba0 e1081240 
May  9 10:05:11 localhost kernel: Call Trace: [usb_disconnect+252/304]
[hub_disconnect+28/128] [usb_disconnect+224/304] [<e1081240>]
[<e107fdfa>] 
May  9 10:05:11 localhost kernel: Call Trace: [<c01f3b8c>] [<c01f5b6c>]
[<c01f3b70>] [<e1081240>] [<e107fdfa>] 
May  9 10:05:11 localhost kernel:    [pci_unregister_driver+47/80]
[<e107c000>] [<e108032a>] [<e1081240>] [free_module+30/208] [<e107c000>] 
May  9 10:05:11 localhost kernel:    [<c01d973f>] [<e107c000>]
[<e108032a>] [<e1081240>] [<c0118dbe>] [<e107c000>] 
May  9 10:05:11 localhost kernel:    [sys_delete_module+306/608]
[<e107c000>] [system_call+51/56] 
May  9 10:05:11 localhost kernel:    [<c01181d2>] [<e107c000>]
[<c0106e0b>] 
May  9 10:05:11 localhost kernel: 
May  9 10:05:11 localhost kernel: Code: 8b 40 0c 8b 50 04 89 5e 20 c7 04
24 09 00 00 00 8b 87 c4 00 
May  9 10:05:11 localhost kernel:  <3>hub.c: get_port_status(2) failed
(err = -19)
May  9 10:05:11 localhost kernel: hub.c: get_port_status(2) failed (err
= -19)
May  9 10:05:11 localhost last message repeated 3 times
May  9 10:05:11 localhost kernel: hub.c: Cannot enable port 2 of hub 1,
disabling port.
May  9 10:05:11 localhost kernel: hub.c: Maybe the USB cable is bad?
May  9 10:05:11 localhost kernel: hub.c: cannot disable port 2 of hub 1
(err = -19)
May  9 10:05:11 localhost kernel: hub.c: get_hub_status failed


I have tested several cables, and also used the SanDisk in Windows and
it works fine.
