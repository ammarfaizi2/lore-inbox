Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTLYQ2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTLYQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 11:28:13 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:31982 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S264359AbTLYQ2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 11:28:02 -0500
Message-ID: <3FEAC8E5.4090002@cfl.rr.com>
Date: Thu, 25 Dec 2003 06:24:21 -0500
From: ";)" <msilaghi@cfl.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug report for kernel 2.6.0
Content-Type: multipart/mixed;
 boundary="------------030201020206080608050104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030201020206080608050104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

with a hotplug agent that
in an infinite loop mounts and unmounts an usb memory stick (flash 
SanDisk mini cruzer)

the error occurs when I unpluged the usb flush memory from USB port

--------------030201020206080608050104
Content-Type: text/plain;
 name="kernelbug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernelbug"

Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: 0781:8181 plugged in
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: A=add DP=/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0 P=781/8181/125 TYPE=usb I=8/6/80 DEV=/proc/bus/usb/001/007
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: DEVNAME=/dev/scsi/sandisk-p1
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: REMOVER=/var/run/usb/%proc%bus%usb%001%007
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: already mounted: /dev/scsi/sandisk-p1 on /mnt/flash type vfat (rw)
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: previous device-name=
Dec 25 10:25:23 rodna kernel: SCSI error : <5 0 0 0> return code = 0x70000
Dec 25 10:25:23 rodna kernel: end_request: I/O error, dev sda, sector 160
Dec 25 10:25:23 rodna kernel: Buffer I/O error on device sda1, logical block 16
Dec 25 10:25:23 rodna /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Dec 25 10:25:23 rodna /sbin/hotplug: no runnable /etc/hotplug/scsi_device.agent is installed
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: FLASH remounted on /dev/scsi/sandisk-p1
Dec 25 10:25:23 rodna /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Dec 25 10:25:23 rodna /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
Dec 25 10:25:23 rodna /sbin/hotplug: no runnable /etc/hotplug/scsi_host.agent is installed
Dec 25 10:25:23 rodna kernel: eeping.
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: 0781:8181 plugged in
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: A=add DP=/devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0 P=781/8181/125 TYPE=usb I=8/6/80 DEV=/proc/bus/usb/001/007
Dec 25 10:25:23 rodna /etc/hotplug/usb/flash: /dev/scsi/sandisk-p1 does not exist
Dec 25 10:25:23 rodna /etc/hotplug/usb.agent: Called /etc/hotplug/usb/flash result 0
Dec 25 10:25:23 rodna kernel: sda : READ CAPACITY failed.
Dec 25 10:25:23 rodna kernel: sda : status=0, message=00, host=7, driver=00 
Dec 25 10:25:23 rodna kernel: sda : sense not available. 
Dec 25 10:25:23 rodna kernel: sda: Write Protect is off
Dec 25 10:25:23 rodna kernel: sda: assuming drive cache: write through
Dec 25 10:25:23 rodna kernel: usb 1-1: USB disconnect, address 7
Dec 25 10:25:23 rodna kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 25 10:25:23 rodna kernel:  printing eip:
Dec 25 10:25:23 rodna kernel: 00000000
Dec 25 10:25:23 rodna kernel: *pde = 00000000
Dec 25 10:25:23 rodna kernel: Oops: 0000 [#1]
Dec 25 10:25:23 rodna kernel: CPU:    0
Dec 25 10:25:23 rodna kernel: EIP:    0060:[<00000000>]    Not tainted
Dec 25 10:25:23 rodna kernel: EFLAGS: 00010046
Dec 25 10:25:23 rodna kernel: EIP is at 0x0
Dec 25 10:25:23 rodna kernel: eax: d3a2cc80   ebx: df5b3400   ecx: c050d190   edx: 00000001
Dec 25 10:25:23 rodna kernel: esi: df5b3504   edi: c04df320   ebp: d3ff5fec   esp: d3ff5f94
Dec 25 10:25:23 rodna kernel: ds: 007b   es: 007b   ss: 0068
Dec 25 10:25:23 rodna kernel: Process usb-storage (pid: 3198, threadinfo=d3ff4000 task=d3e72080)
Dec 25 10:25:23 rodna kernel: Stack: c0333889 d3a2cc80 c04df360 00040000 d3ff4000 d3ff4000 df5b3514 d3e72080 
Dec 25 10:25:23 rodna kernel:        dfc86680 dfdeddc0 c010aec6 dff7e080 c0333710 00000000 df5b3400 00000000 
Dec 25 10:25:23 rodna kernel:        00000000 00000000 00000000 c0333710 00000000 00000000 00000000 c0109005 
Dec 25 10:25:23 rodna kernel: Call Trace:
Dec 25 10:25:23 rodna kernel:  [usb_stor_control_thread+377/880] usb_stor_control_thread+0x179/0x370
Dec 25 10:25:23 rodna kernel:  [<c0333889>] usb_stor_control_thread+0x179/0x370
Dec 25 10:25:23 rodna kernel:  [ret_from_fork+6/32] ret_from_fork+0x6/0x20
Dec 25 10:25:23 rodna kernel:  [<c010aec6>] ret_from_fork+0x6/0x20
Dec 25 10:25:23 rodna kernel:  [usb_stor_control_thread+0/880] usb_stor_control_thread+0x0/0x370
Dec 25 10:25:23 rodna kernel:  [<c0333710>] usb_stor_control_thread+0x0/0x370
Dec 25 10:25:23 rodna kernel:  [usb_stor_control_thread+0/880] usb_stor_control_thread+0x0/0x370
Dec 25 10:25:23 rodna kernel:  [<c0333710>] usb_stor_control_thread+0x0/0x370
Dec 25 10:25:23 rodna kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Dec 25 10:25:23 rodna kernel:  [<c0109005>] kernel_thread_helper+0x5/0x10
Dec 25 10:25:23 rodna kernel: 
Dec 25 10:25:23 rodna kernel: Code:  Bad EIP value.
Dec 25 10:25:23 rodna kernel:  <6>note: usb-storage[3198] exited with preempt_count 1
Dec 25 10:25:23 rodna kernel: scsi5 (0:0): rejecting I/O to dead device
Dec 25 10:25:23 rodna kernel: sda : READ CAPACITY failed.
Dec 25 10:25:23 rodna kernel: sda : status=0, message=00, host=1, driver=00 
Dec 25 10:25:23 rodna kernel: sda : sense not available. 
Dec 25 10:25:23 rodna kernel: scsi5 (0:0): rejecting I/O to dead device
Dec 25 10:25:23 rodna kernel: sda: Write Protect is off
Dec 25 10:25:23 rodna kernel: sda: assuming drive cache: write through
Dec 25 10:25:23 rodna kernel:  sda:<3>scsi5 (0:0): rejecting I/O to dead device
Dec 25 10:25:23 rodna kernel: Buffer I/O error on device sda, logical block 0
Dec 25 10:25:23 rodna kernel: scsi5 (0:0): rejecting I/O to dead device
Dec 25 10:25:23 rodna kernel: Buffer I/O error on device sda, logical block 0
Dec 25 10:25:23 rodna kernel: ldm_validate_partition_table(): Disk read failed.
Dec 25 10:25:23 rodna kernel: scsi5 (0:0): rejecting I/O to dead device
Dec 25 10:25:23 rodna kernel: scsi5 (0:0): rejecting I/O to dead device
Dec 25 10:25:23 rodna kernel: Buffer I/O error on device sda, logical block 0
Dec 25 10:25:23 rodna kernel:  unable to read partition table
Dec 25 10:25:23 rodna kernel:  unable to read partition table
Dec 25 10:25:23 rodna kernel: ------------[ cut here ]------------
Dec 25 10:25:23 rodna kernel: kernel BUG at drivers/usb/storage/usb.c:871!
Dec 25 10:25:23 rodna kernel: invalid operand: 0000 [#2]
Dec 25 10:25:23 rodna kernel: CPU:    0
Dec 25 10:25:23 rodna kernel: EIP:    0060:[usb_stor_release_resources+224/272]    Not tainted
Dec 25 10:25:23 rodna kernel: EIP:    0060:[<c03343e0>]    Not tainted
Dec 25 10:25:23 rodna kernel: EFLAGS: 00010202
Dec 25 10:25:23 rodna kernel: EIP is at usb_stor_release_resources+0xe0/0x110
Dec 25 10:25:23 rodna kernel: eax: c04df8a0   ebx: df5b3400   ecx: c050d190   edx: 00000000
Dec 25 10:25:23 rodna kernel: esi: c055a100   edi: d84f5e00   ebp: dfdeded0   esp: dfdedecc
Dec 25 10:25:23 rodna kernel: ds: 007b   es: 007b   ss: 0068
Dec 25 10:25:23 rodna kernel: Process khubd (pid: 5, threadinfo=dfdec000 task=dff7e080)
Dec 25 10:25:23 rodna kernel: Stack: dfd13e80 dfdedee4 c0319833 df5b3400 dfd13e94 c055a120 dfdedef8 c0270d23 
Dec 25 10:25:23 rodna kernel:        dfd13e94 dfd13e94 d84f5ecc dfdedf0c c0270e34 dfd13e94 dfd13e94 d84f5ecc 
Dec 25 10:25:23 rodna kernel:        dfdedf20 c026fee4 dfd13e94 00000001 d84f5e00 dfdedf34 c031f82e dfd13e94 
Dec 25 10:25:23 rodna kernel: Call Trace:
Dec 25 10:25:23 rodna kernel:  [usb_unbind_interface+99/112] usb_unbind_interface+0x63/0x70
Dec 25 10:25:23 rodna kernel:  [<c0319833>] usb_unbind_interface+0x63/0x70
Dec 25 10:25:23 rodna kernel:  [device_release_driver+83/96] device_release_driver+0x53/0x60
Dec 25 10:25:23 rodna kernel:  [<c0270d23>] device_release_driver+0x53/0x60
Dec 25 10:25:23 rodna kernel:  [bus_remove_device+68/128] bus_remove_device+0x44/0x80
Dec 25 10:25:23 rodna kernel:  [<c0270e34>] bus_remove_device+0x44/0x80
Dec 25 10:25:23 rodna kernel:  [device_del+84/144] device_del+0x54/0x90
Dec 25 10:25:23 rodna kernel:  [<c026fee4>] device_del+0x54/0x90
Dec 25 10:25:23 rodna kernel:  [usb_disable_device+110/176] usb_disable_device+0x6e/0xb0
Dec 25 10:25:23 rodna kernel:  [<c031f82e>] usb_disable_device+0x6e/0xb0
Dec 25 10:25:23 rodna kernel:  [usb_disconnect+133/224] usb_disconnect+0x85/0xe0
Dec 25 10:25:23 rodna kernel:  [<c031a355>] usb_disconnect+0x85/0xe0
Dec 25 10:25:23 rodna kernel:  [hub_port_connect_change+723/736] hub_port_connect_change+0x2d3/0x2e0
Dec 25 10:25:23 rodna kernel:  [<c031c7b3>] hub_port_connect_change+0x2d3/0x2e0
Dec 25 10:25:23 rodna kernel:  [hub_events+753/864] hub_events+0x2f1/0x360
Dec 25 10:25:23 rodna kernel:  [<c031cab1>] hub_events+0x2f1/0x360
Dec 25 10:25:23 rodna kernel:  [hub_thread+43/224] hub_thread+0x2b/0xe0
Dec 25 10:25:23 rodna kernel:  [<c031cb4b>] hub_thread+0x2b/0xe0
Dec 25 10:25:23 rodna kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 25 10:25:23 rodna kernel:  [<c011c720>] default_wake_function+0x0/0x20
Dec 25 10:25:23 rodna kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Dec 25 10:25:23 rodna kernel:  [<c031cb20>] hub_thread+0x0/0xe0
Dec 25 10:25:23 rodna kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Dec 25 10:25:23 rodna kernel:  [<c0109005>] kernel_thread_helper+0x5/0x10
Dec 25 10:25:23 rodna kernel: 
Dec 25 10:25:23 rodna kernel: Code: 0f 0b 67 03 cc 60 4b c0 eb ca 8d b6 00 00 00 00 c7 80 c0 01 

--------------030201020206080608050104
Content-Type: text/plain;
 name="kernelbug-verlinux"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernelbug-verlinux"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux rodna.cs.fit.edu 2.6.0-test11 #7 Sun Dec 7 01:12:21 EST 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
module-init-tools      0.9.14
e2fsprogs              1.34
pcmcia-cs              3.2.0
quota-tools            3.01.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         

--------------030201020206080608050104--

