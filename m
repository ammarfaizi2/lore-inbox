Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290851AbSAaCxm>; Wed, 30 Jan 2002 21:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290856AbSAaCxc>; Wed, 30 Jan 2002 21:53:32 -0500
Received: from tomts14.bellnexxia.net ([209.226.175.35]:37874 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S290852AbSAaCxT>; Wed, 30 Jan 2002 21:53:19 -0500
Subject: Oops in 2.5.1
From: Tim Coleman <tim@timcoleman.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 30 Jan 2002 21:53:13 -0500
Message-Id: <1012445595.7956.4.camel@tux.epenguin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an oops when loading usb with hotplug in kernel 2.5.1
I realize that this isn't the current version but I thought
I would send it in anyway, because I haven't got 2.5.3 yet.

The device is not accessible at all with this kernel, and I notice
that the trace mentions the 8139_too ethernet driver.

Anyway, here you go:

Jan 30 21:41:45 tux kernel: hub.c: 4 ports detected
Jan 30 21:41:45 tux /etc/hotplug/usb.agent: Modprobe and setup usbcore
for USB product 0/0/0
Jan 30 21:41:45 tux /etc/hotplug/usb.agent: Modprobe and setup
usb-storage for USB product 54c/2e/300
Jan 30 21:41:45 tux /etc/hotplug/usb.agent: Modprobe and setup usbcore
for USB product 58f/9254/100 
Jan 30 21:41:45 tux /etc/hotplug/usb.agent: Modprobe and setup usbcore
for USB product 0/0/0
Jan 30 21:41:45 tux /etc/hotplug/usb.agent: Modprobe and setup usbcore
for USB product 0/0/0
Jan 30 21:41:45 tux /etc/hotplug/usb.agent: Modprobe and setup usbcore
for USB product 58f/9254/100 
Jan 30 21:41:45 tux kernel: Initializing USB Mass Storage driver...
Jan 30 21:41:45 tux kernel: usb.c: registered new driver usb-storage
Jan 30 21:41:45 tux kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Jan 30 21:41:45 tux kernel:   Vendor: Sony      Model: Sony DSC         
Rev: 3.00
Jan 30 21:41:45 tux kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Jan 30 21:41:45 tux kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
rnel: hub.c: USB hub found
Jan 30 21:41:45 tux kernel: hub.c: 4 ports detected
Jan 30 21:41:45 tux kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Jan 30 21:41:45 tux kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Jan 30 21:41:45 tux kernel: SCSI device sda: 7904 512-byte hdwr sectors
(4 MB)
Jan 30 21:41:45 tux kernel: sda: Write Protect is off
Jan 30 21:41:45 tux kernel: 
/dev/scsi/host0/bus0/target0/lun0:<4>usb-uhci.c: interrupt, status 28,
frame# 754
Jan 30 21:42:15 tux kernel: usb-uhci.c: interrupt, status 28, frame# 37
Jan 30 21:42:38 tux kernel: usb.c: USB disconnect on device 1
Jan 30 21:42:38 tux kernel: usb.c: USB disconnect on device 2
Jan 30 21:42:38 tux kernel: usb-uhci.c: forced removing of queued URB
cb3b5ac0 due to disconnect
Jan 30 21:42:38 tux kernel:  printing eip:
Jan 30 21:42:38 tux kernel: d085a041
Jan 30 21:42:38 tux kernel: Oops: 0000
Jan 30 21:42:38 tux kernel: CPU:    0
Jan 30 21:42:38 tux kernel: EIP:   
0010:[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-106431/96]    Tainted: P
Jan 30 21:42:38 tux kernel: EFLAGS: 00210206
Jan 30 21:42:38 tux kernel: eax: 00000028   ebx: c6192028   ecx:
01800205   edx: 00000000
Jan 30 21:42:38 tux kernel: EFLAGS: 00210206
Jan 30 21:42:38 tux kernel: eax: 00000028   ebx: c6192028   ecx:
01800205   edx: 00000000
Jan 30 21:42:38 tux kernel: esi: c6192028   edi: cb3b5ac0   ebp:
cf6a47c0   esp: c1625f00
Jan 30 21:42:38 tux kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 21:42:38 tux kernel: Process rmmod (pid: 8774,
stackpage=c1625000)
Jan 30 21:42:38 tux kernel: Stack: cb3b5ac0 c6fa8180 00000003 cf6a47c0
00000000 00200202 c6d2c4c0 cf6a47c0
Jan 30 21:42:38 tux kernel:        c6192060 c6192000 c6fa8180 00000000
d0858aee cf6a47c0 cb3b5ac0 00000002
Jan 30 21:42:38 tux kernel:        cf6a47c0 d085c360 d0857000 bfffec9c
00000000 cf6a47c0 cf6a4898 d085ab12
Jan 30 21:42:38 tux kernel: Call Trace:
[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-111890/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-97440/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-103662/96] [pci_unregister_driver+47/80] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-102390/96]
Jan 30 21:42:38 tux kernel:   
[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-97440/96] [free_module+23/160] [sys_delete_module+247/448] [system_call+51/56]
Jan 30 21:42:38 tux kernel:
Jan 30 21:42:38 tux kernel:   
[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-97440/96] [free_module+23/160] [sys_delete_module+247/448] [system_call+51/56]
Jan 30 21:42:38 tux kernel:
Jan 30 21:42:38 tux kernel: Code: 8b 2c 90 8b 44 24 28 c1 e9 08 83 e1 0f
d3 ed 83 e5 01 c7 44
Jan 30 21:42:45 tux kernel:  <1>Unable to handle kernel paging request
at virtual address 37392d43
Jan 30 21:42:45 tux kernel:  printing eip:
Jan 30 21:42:45 tux kernel: d084b119
Jan 30 21:42:45 tux kernel: Oops: 0000
Jan 30 21:42:45 tux kernel: CPU:    0
Jan 30 21:42:45 tux kernel: EIP:   
0010:[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-167655/96]    Tainted: P
Jan 30 21:42:45 tux kernel: EFLAGS: 00010006
Jan 30 21:42:45 tux kernel: eax: 37392d2b   ebx: c21efe54   ecx:
c21efe58   edx: cfc01740
Jan 30 21:42:45 tux kernel: esi: 00000064   edi: c3baab80   ebp:
c21ee000   esp: c21efe30
Jan 30 21:42:45 tux kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 21:42:45 tux kernel: Process scsi_eh_0 (pid: 8728,
stackpage=c21ef000)
Jan 30 21:42:45 tux kernel: Stack: d084b235 cfc01740 cf2ade00 be343c00
c3baab80 00000000 c01cc7a2 c02e8674
Jan 30 21:42:45 tux kernel: Process scsi_eh_0 (pid: 8728,
stackpage=c21ef000)
Jan 30 21:42:45 tux kernel: Stack: d084b235 cfc01740 cf2ade00 be343c00
c3baab80 00000000 c01cc7a2 c02e8674
Jan 30 21:42:45 tux kernel:        c21efe64 00000000 c21efe6c c21efe6c
00000000 00000000 c21ee000 c21efe58
Jan 30 21:42:45 tux kernel:        c21efe58 d084b3b1 cfc01740 00000064
c21efe94 c3baab80 00000000 00000023
Jan 30 21:42:45 tux kernel: Call Trace:
[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-167371/96] [start_request+306/416] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-166991/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-166837/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-158375/96]
Jan 30 21:42:45 tux kernel:   
[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-156117/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-124412/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-154072/96] [<d08bc2e0>] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-71073/96] [8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-69433/96]
Jan 30 21:42:45 tux kernel:   
[8139too:__insmod_8139too_O/lib/modules/2.5.1/kernel/drivers/net/813+-68242/96] [kernel_thread+40/64]
Jan 30 21:42:45 tux kernel:
Jan 30 21:42:45 tux kernel: Code: 8b 40 18 85 c0 74 10 52 8b 40 0c ff d0
83 c4 04 c3 8d b6 00


-- 
Tim Coleman <tim@timcoleman.com>                       [43.28 N 80.31 W]
BMath, Honours Combinatorics and Optimization, University of Waterloo
 "They that can give up essential liberty to obtain a little temporary
  safety deserve neither liberty nor safety." -- Benjamin Franklin

