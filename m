Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbSKKMJf>; Mon, 11 Nov 2002 07:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266543AbSKKMJf>; Mon, 11 Nov 2002 07:09:35 -0500
Received: from mail.scram.de ([195.226.127.117]:25051 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S266431AbSKKMJa>;
	Mon, 11 Nov 2002 07:09:30 -0500
Date: Mon, 11 Nov 2002 13:15:28 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@ayse
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.47 Oops on hub disconnect
Message-ID: <Pine.LNX.4.44.0211111311080.1284-100000@ayse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

connecting an USB hub caused a message about one device not accepting its
address. Unplugging the hub again caused the following oops then.

--jochen

drivers/usb/host/ohci-hub.c: 01:0a.0: GetStatus roothub.portstatus [1] = 0x00100103 PRSC PPS PES CCS
drivers/usb/core/hub.c: port 1, portstatus 103, change 10, 12 Mb/s
drivers/usb/core/hub.c: new USB device 01:0a.0-1, assigned address 2
drivers/usb/core/usb.c: new device strings: Mfr=0, Product=2, SerialNumber=0
Product: Standard USB Hub
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: usb_new_device_R569312be - registering 1-1:0
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/hub.c: USB hub found at 1
drivers/usb/core/hub.c: 4 ports detected
drivers/usb/core/hub.c: standalone hub
drivers/usb/core/hub.c: ganged power switching
drivers/usb/core/hub.c: global over-current protection
drivers/usb/core/hub.c: Port indicators are not supported
drivers/usb/core/hub.c: power on to power good time: 100ms
drivers/usb/core/hub.c: hub controller current requirement: 64mA
drivers/usb/core/hub.c: local power source is lost (inactive)
drivers/usb/core/hub.c: no over-current condition exists
drivers/usb/host/ohci-q.c: 01:0a.0: link ed fffffc002679c050 branch 0 [11us.], interval 32
drivers/usb/core/hub.c: enabling power on all ports
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/hub.c: port 1, portstatus 100, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 101, change 1, 12 Mb/s
drivers/usb/core/hub.c: hub 1 port 2 connection change
drivers/usb/core/hub.c: hub 1 port 2, portstatus 101, change 1, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 111, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2 of hub 1 not reset yet, waiting 10ms
drivers/usb/core/hub.c: port 2, portstatus 103, change 10, 12 Mb/s
drivers/usb/core/hub.c: new USB device 01:0a.0-1.2, assigned address 3
drivers/usb/core/usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Product: eUSB SmartMedia Adapter
Manufacturer: SCM Microsystems Inc.
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: usb_new_device_R569312be - registering 1-1.2:0
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/hub.c: port 3, portstatus 101, change 1, 12 Mb/s
drivers/usb/core/hub.c: hub 1 port 3 connection change
drivers/usb/core/hub.c: hub 1 port 3, portstatus 101, change 1, 12 Mb/s
drivers/usb/core/hub.c: port 3, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 3, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 3, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 3, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 3, portstatus 111, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 3 of hub 1 not reset yet, waiting 10ms
drivers/usb/core/hub.c: port 3, portstatus 103, change 10, 12 Mb/s
drivers/usb/core/hub.c: new USB device 01:0a.0-1.3, assigned address 4
drivers/usb/core/usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: usb_new_device_R569312be - registering 1-1.3:0
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/hub.c: port 4, portstatus 101, change 1, 12 Mb/s
drivers/usb/core/hub.c: hub 1 port 4 connection change
drivers/usb/core/hub.c: hub 1 port 4, portstatus 101, change 1, 12 Mb/s
drivers/usb/core/hub.c: port 4, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 4, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 4, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 4, portstatus 101, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 4, portstatus 111, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 4 of hub 1 not reset yet, waiting 10ms
drivers/usb/core/hub.c: port 4, portstatus 103, change 10, 12 Mb/s
drivers/usb/core/hub.c: new USB device 01:0a.0-1.4, assigned address 5
drivers/usb/host/ohci-q.c: urb fffffc0027d06700 usb-01:0a.0-1.4 ep-0-OUT cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06700 status -60 len 0
drivers/usb/host/ohci-q.c: urb fffffc0027d06700 usb-01:0a.0-1.4 ep-0-OUT cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06700 status -60 len 0
drivers/usb/core/usb.c: USB device not accepting new address=5 (error=-60)
drivers/usb/core/hub.c: port 4, portstatus 103, change 10, 12 Mb/s
drivers/usb/core/hub.c: new USB device 01:0a.0-1.4, assigned address 6
drivers/usb/core/usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Product:  IrDA/USB Bridge
Manufacturer:  Sigmatel Inc
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: usb_new_device_R569312be - registering 1-1.4:0
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f
drivers/usb/core/usb.c: usb_device_probe_Rfe9be36f - got id
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/hub.c: hub 1 power change
drivers/usb/core/hub.c: port 1, portstatus 100, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 2, portstatus 103, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 3, portstatus 103, change 0, 12 Mb/s
drivers/usb/core/hub.c: port 4, portstatus 103, change 0, 12 Mb/s
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-hub.c: 01:0a.0: GetStatus roothub.portstatus [1] = 0x00030100 PESC CSC PPS
drivers/usb/core/hub.c: port 1, portstatus 100, change 3, 12 Mb/s
drivers/usb/core/hub.c: hub 0 port 1 connection change
drivers/usb/core/hub.c: hub 0 port 1, portstatus 100, change 3, 12 Mb/s
drivers/usb/core/usb.c: USB disconnect on device 2
drivers/usb/core/usb.c: USB disconnect on device 3
drivers/usb/core/usb.c: unregistering interfaces on device 3
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: unregistering the device 3
drivers/usb/core/usb.c: USB disconnect on device 4
drivers/usb/core/usb.c: unregistering interfaces on device 4
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: unregistering the device 4
Unable to handle kernel paging request at virtual address 00f37998fceaa010
khubd(91): Oops 0
pc = [<fffffc000035a7e0>]  ra = [<fffffffc00206e8c>]  ps = 0007    Not tainted
v0 = 0000000000000000  t0 = 00f37998fceaa000  t1 = fffffc0000633450
t2 = fffffc00006aa000  t3 = 0000000000000001  t4 = fffffc002803e2c0
t5 = ffffffff00000000  t6 = 0000000000000001  t7 = fffffc0029ae8000
s0 = fffffc002a0363e8  s1 = 61656c6500000001  s2 = 0000000000000000
s3 = 0000000000000002  s4 = fffffc0027d056c0  s5 = fffffc0027f37800
s6 = 0000000000000001
a0 = 0000000000000007  a1 = 00000000a679c0f0  a2 = 00000000a679c0f0
a3 = 0000000000000000  a4 = fffffffffffffffb  a5 = 0000000000000200
t8 = 000000000000001f  t9 = fffffc00003fb9e4  t10= 00000000000000f0
t11= 0000000000000050  pv = fffffc000035a780  at = 0000000000000001
gp = fffffc000062c5c8  sp = fffffc0029aebbe8
Trace:fffffc0000330b80 fffffc0000330b80 fffffc0000313668 fffffc0000330b80
Code: 4821b681  47ff041f  a4620000  40210441  48209721  40230401 <a6010010> a5300000
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-q.c: urb fffffc0027d07480 usb-01:0a.0-1.4 ep-0-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d07480 status -60 len 0
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer
usbfs: USBDEVFS_CONTROL failed dev 6 rqt 128 rq 6 len 18 ret -60
drivers/usb/host/ohci-q.c: urb fffffc0027d07480 usb-01:0a.0-1.4 ep-0-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d07480 status -60 len 0
drivers/usb/host/ohci-q.c: urb fffffc0027d06880 usb-01:0a.0-1 ep-1-IN cc 5 --> status -60
drivers/usb/core/hcd.c: giveback urb fffffc0027d06880 status -60 len 0
drivers/usb/core/hub.c: hub '1' status -60 for interrupt transfer

ksymoops 2.4.6 on alpha 2.5.47.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47/ (default)
     -m /boot/System.map-2.5.47 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.5.47 failed
Warning (compare_maps): mismatch on symbol video_proc_entry  , videodev says fffffffc002dbcb0, /lib/modules/2.5.47/kernel/drivers/media/video/videodev.o says fffffffc002da008.  Ignoring /lib/modules/2.5.47/kernel/drivers/media/video/videodev.o entry
Warning (compare_maps): mismatch on symbol snd_cards_count  , snd says fffffffc002941d8, /lib/modules/2.5.47/kernel/sound/core/snd.o says fffffffc0028a028.  Ignoring /lib/modules/2.5.47/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_ecards_limit  , snd says fffffffc002941d0, /lib/modules/2.5.47/kernel/sound/core/snd.o says fffffffc0028a020.  Ignoring /lib/modules/2.5.47/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_mixer_oss_notify_callback  , snd says fffffffc002941f0, /lib/modules/2.5.47/kernel/sound/core/snd.o says fffffffc0028a040.  Ignoring /lib/modules/2.5.47/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol snd_seq_root  , snd says fffffffc00294208, /lib/modules/2.5.47/kernel/sound/core/snd.o says fffffffc0028a058.  Ignoring /lib/modules/2.5.47/kernel/sound/core/snd.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says fffffffc00216190, /lib/modules/2.5.47/kernel/drivers/usb/core/usbcore.o says fffffffc001fc028.  Ignoring /lib/modules/2.5.47/kernel/drivers/usb/core/usbcore.o entry
modprobe(502): unaligned trap at 0000000120011750: 0000000120087094 29 1
modprobe(502): unaligned trap at 0000000120011758: 0000000120087094 2d 1
Unable to handle kernel paging request at virtual address 00f37998fceaa010
khubd(91): Oops 0
pc = [<fffffc000035a7e0>]  ra = [<fffffffc00206e8c>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 00f37998fceaa000  t1 = fffffc0000633450
t2 = fffffc00006aa000  t3 = 0000000000000001  t4 = fffffc002803e2c0
t5 = ffffffff00000000  t6 = 0000000000000001  t7 = fffffc0029ae8000
s0 = fffffc002a0363e8  s1 = 61656c6500000001  s2 = 0000000000000000
s3 = 0000000000000002  s4 = fffffc0027d056c0  s5 = fffffc0027f37800
s6 = 0000000000000001
a0 = 0000000000000007  a1 = 00000000a679c0f0  a2 = 00000000a679c0f0
a3 = 0000000000000000  a4 = fffffffffffffffb  a5 = 0000000000000200
t8 = 000000000000001f  t9 = fffffc00003fb9e4  t10= 00000000000000f0
t11= 0000000000000050  pv = fffffc000035a780  at = 0000000000000001
gp = fffffc000062c5c8  sp = fffffc0029aebbe8
Trace:fffffc0000330b80 fffffc0000330b80 fffffc0000313668 fffffc0000330b80
Code: 4821b681  47ff041f  a4620000  40210441  48209721  40230401 <a6010010> a5300000


>>RA;  fffffffc00206e8c <[usbcore]usb_destroy_configuration+16c/280>

>>PC;  fffffc000035a7e0 <kfree+60/100>   <=====

Trace; fffffc0000330b80 <default_wake_function+0/120>
Trace; fffffc0000330b80 <default_wake_function+0/120>
Trace; fffffc0000313668 <kernel_thread+28/90>
Trace; fffffc0000330b80 <default_wake_function+0/120>

Code;  fffffc000035a7c8 <kfree+48/100>
0000000000000000 <_PC>:
Code;  fffffc000035a7c8 <kfree+48/100>
   0:   81 b6 21 48       srl  t0,0xd,t0
Code;  fffffc000035a7cc <kfree+4c/100>
   4:   1f 04 ff 47       nop
Code;  fffffc000035a7d0 <kfree+50/100>
   8:   00 00 62 a4       ldq  t2,0(t1)
Code;  fffffc000035a7d4 <kfree+54/100>
   c:   41 04 21 40       s4addq       t0,t0,t0
Code;  fffffc000035a7d8 <kfree+58/100>
  10:   21 97 20 48       sll  t0,0x4,t0
Code;  fffffc000035a7dc <kfree+5c/100>
  14:   01 04 23 40       addq t0,t2,t0
Code;  fffffc000035a7e0 <kfree+60/100>   <=====
  18:   10 00 01 a6       ldq  a0,16(t0)   <=====
Code;  fffffc000035a7e4 <kfree+64/100>
  1c:   00 00 30 a5       ldq  s0,0(a0)


7 warnings and 1 error issued.  Results may not be reliable.

