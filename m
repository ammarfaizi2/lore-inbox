Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTIPEcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 00:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTIPEcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 00:32:10 -0400
Received: from smtp.easystreet.com ([206.26.36.40]:33000 "EHLO
	easystreet01.easystreet.com") by vger.kernel.org with ESMTP
	id S261784AbTIPEb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 00:31:58 -0400
Message-Id: <200309160431.h8G4VqT5029858@oldred.easystreet.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: 2.6.0-test5-mm1 - usbserial oops - debug
Date: Mon, 15 Sep 2003 21:31:52 -0700
From: cliffw@easystreet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is with debug=1 for the modules, and 
DEBUG for kobject.c

----------------------------
cliffw

drivers/usb/serial/usb-serial.c: serial_open
drivers/usb/serial/usb-serial.c: serial_open
drivers/usb/serial/usb-serial.c: serial_open
ehci_hcd 0000:00:10.3: GetStatus port 4 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:0: port 4, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 4: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:10.3: port 4 full speed --> companion
ehci_hcd 0000:00:10.3: GetStatus port 4 status 003801 POWER OWNER sig=j  CONNECT
kobject <NULL>: cleaning up
drivers/usb/host/uhci-hcd.c: d800: wakeup_hc
drivers/usb/serial/usb-serial.c: serial_open
hub 3-0:0: port 2, status 101, change 1, 12 Mb/s
hub 3-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 2, assigned address 3
usb 3-2: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 3 default language ID 0x409
usb 3-2: Product: Palm Handheld
usb 3-2: Manufacturer: Palm, Inc.
kobject 3-2: registering. parent: usb3, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
drivers/usb/core/usb.c: usb_hotplug
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=143
usb 3-2: usb_new_device - registering interface 3-2:0
kobject 3-2:0: registering. parent: 3-2, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:0'
drivers/usb/core/usb.c: usb_hotplug
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=144
usbserial 3-2:0: usb_probe_interface
usbserial 3-2:0: usb_probe_interface - got id
drivers/usb/serial/usb-serial.c: descriptor matches
drivers/usb/serial/visor.c: visor_probe
drivers/usb/serial/visor.c: visor_probe - reset config
drivers/usb/serial/visor.c: palm_os_4_probe
usb 3-2: palm_os_4_probe - error -32 getting connection info
drivers/usb/serial/usb-serial.c: found bulk in
drivers/usb/serial/usb-serial.c: found bulk out
drivers/usb/serial/usb-serial.c: found bulk in
drivers/usb/serial/usb-serial.c: found bulk out
usbserial 3-2:0: Handspring Visor / Palm OS converter detected
drivers/usb/serial/usb-serial.c: get_free_serial 2
drivers/usb/serial/usb-serial.c: get_free_serial - minor base = 0
drivers/usb/serial/usb-serial.c: usb_serial_probe - setting up 2 port structures for this device
drivers/usb/serial/usb-serial.c: usb_serial_probe - registering ttyUSB0
kobject ttyUSB0: registering. parent: 3-2, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/ttyUSB0'
kset_hotplug: /sbin/hotplug usb-serial HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=145
kobject ttyUSB0: registering. parent: tty, set: class_obj
kset_hotplug
fill_kobj_path: path = '/class/tty/ttyUSB0'
kset_hotplug: /sbin/hotplug tty HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=146
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
drivers/usb/serial/usb-serial.c: usb_serial_probe - registering ttyUSB1
kobject ttyUSB1: registering. parent: 3-2, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/ttyUSB1'
kset_hotplug: /sbin/hotplug usb-serial HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=147
kobject ttyUSB1: registering. parent: tty, set: class_obj
kset_hotplug
fill_kobj_path: path = '/class/tty/ttyUSB1'
kset_hotplug: /sbin/hotplug tty HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=148
usb 3-2: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
drivers/usb/serial/usb-serial.c: serial_open
drivers/usb/serial/visor.c: visor_open - port 1
drivers/usb/serial/usb-serial.c: serial_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/usb-serial.c: serial_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/usb-serial.c: serial_ioctl - port 1, cmd 0x5402
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5402
drivers/usb/serial/usb-serial.c: serial_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - data bits = 8
drivers/usb/serial/visor.c: visor_set_termios - parity = none
drivers/usb/serial/visor.c: visor_set_termios - stop bits = 1
drivers/usb/serial/visor.c: visor_set_termios - RTS/CTS is disabled
drivers/usb/serial/visor.c: visor_set_termios - XON/XOFF is disabled
drivers/usb/serial/visor.c: visor_set_termios - baud rate = 9600
drivers/usb/serial/usb-serial.c: serial_ioctl - port 1, cmd 0x5401
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5401
drivers/usb/serial/usb-serial.c: serial_ioctl - port 1, cmd 0x5403
drivers/usb/serial/visor.c: visor_ioctl - port 1, cmd 0x5403
drivers/usb/serial/usb-serial.c: serial_chars_in_buffer = port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/usb-serial.c: serial_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - port 1
drivers/usb/serial/visor.c: visor_set_termios - nothing to change...
drivers/usb/serial/usb-serial.c: serial_chars_in_buffer = port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/usb-serial.c: serial_write_room - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - port 1
drivers/usb/serial/visor.c: visor_read_bulk_callback - nonzero read bulk status received: -84
ehci_hcd 0000:00:10.3: GetStatus port 4 status 001002 POWER sig=se0  CSC
hub 1-0:0: port 4, status 100, change 1, 12 Mb/s
hub 3-0:0: port 2, status 100, change 3, 12 Mb/s
usb 3-2: USB disconnect, address 3
drivers/usb/core/message.c: nuking URBs for device 3-2
usb 3-2: unregistering interfaces
drivers/usb/serial/usb-serial.c: usb_serial_disconnect
usbserial 3-2:0: device disconnected
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:0'
drivers/usb/core/usb.c: usb_hotplug
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove SEQNUM=149
usb 3-2: unregistering device
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2'
drivers/usb/core/usb.c: usb_hotplug
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove SEQNUM=150
hub 3-0:0: port 2 enable change, status 100
drivers/usb/host/uhci-hcd.c: d800: suspend_hc
drivers/usb/serial/usb-serial.c: serial_chars_in_buffer = port 1
drivers/usb/serial/visor.c: visor_chars_in_buffer - port 1
drivers/usb/serial/usb-serial.c: serial_write_room - port 1
drivers/usb/serial/visor.c: visor_write_room - port 1
drivers/usb/serial/usb-serial.c: serial_close - port 1
drivers/usb/serial/visor.c: visor_close - port 1
kobject <NULL>: cleaning up
drivers/usb/serial/usb-serial.c: destroy_serial - 
drivers/usb/serial/usb-serial.c: serial_shutdown
drivers/usb/serial/visor.c: visor_shutdown
drivers/usb/serial/usb-serial.c: return_serial
kset_hotplug
fill_kobj_path: path = '/class/tty/ttyUSB0'
kset_hotplug: /sbin/hotplug tty HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove SEQNUM=151
kobject ttyUSB0: cleaning up
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:10.1/usb3/3-2/ttyUSB0'
kset_hotplug: /sbin/hotplug usb-serial HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove SEQNUM=152
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c016d0dd
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c016d0dd>]    Not tainted VLI
EFLAGS: 00010202
EIP is at simple_rmdir+0x1d/0x40
eax: 00000000   ebx: c6d5d280   ecx: 05fe7cc8   edx: ffffffd9
esi: c945d080   edi: ca296000   ebp: c6d5d29c   esp: ca297d58
ds: 007b   es: 007b   ss: 0068
Process jpilot (pid: 1322, threadinfo=ca296000 task=c79206b0)
Stack: c9afeb80 c6d5d280 c018122c c945d080 c6d5d280 c6d14380 c6d5d080 c6d5d280 
       c018130a c6d5d280 c951c69c caafdecc cd4caf80 00000001 c01edec1 c951c69c 
       c951c678 c0227b71 c951c69c c951c678 ce934c94 c951c678 00000000 c0227bbb 
Call Trace:
 [<c018122c>] remove_dir+0x3c/0x60
 [<c018130a>] sysfs_remove_dir+0xaa/0x100
 [<c01edec1>] kobject_del+0x41/0x70
 [<c0227b71>] device_del+0x61/0xa0
 [<c0227bbb>] device_unregister+0xb/0x20
 [<ce930262>] destroy_serial+0x182/0x1c0 [usbserial]
 [<c01edfd3>] kobject_cleanup+0x73/0x80
 [<ce92f441>] serial_close+0x61/0x90 [usbserial]
 [<c0203ab8>] release_dev+0x5d8/0x620
 [<c01b98b4>] nfs_flush_file+0x34/0x90
 [<c0203ec2>] tty_release+0x22/0x60
 [<c014fff4>] __fput+0x104/0x120
 [<c014e843>] filp_close+0x43/0x70
 [<c011d7a7>] put_files_struct+0x67/0xc0
 [<c011e384>] do_exit+0x154/0x3d0
 [<c011e68f>] do_group_exit+0x2f/0xa0
 [<c0126e44>] get_signal_to_deliver+0x254/0x350
 [<c010aee4>] do_signal+0x54/0xe0
 [<c0160870>] __pollwait+0x0/0xa0
 [<c0160f7f>] sys_select+0x24f/0x500
 [<c010afa7>] do_notify_resume+0x37/0x40
 [<c033bace>] work_notifysig+0x13/0x15

Code: c0 c3 8d b6 00 00 00 00 8d bf 00 00 00 00 56 53 8b 5c 24 10 8b 74 24 0c 53 e8 40 ff ff ff 85 c0 5a ba d9 ff ff ff 74 14 8b 43 08 <ff> 48 24 53 56 e8 b9 ff ff ff ff 4e 24 58 31 d2 59 5b 89 d0 5e 
 
