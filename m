Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTGLXp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 19:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270026AbTGLXp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 19:45:28 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:63243
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S263239AbTGLXpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 19:45:16 -0400
Subject: Re: 2.5.75-mm1: lockup when inserting USB storage device
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058050082.4831.70.camel@ixodes.goop.org>
References: <1058050082.4831.70.camel@ixodes.goop.org>
Content-Type: text/plain
Message-Id: <1058054397.2396.7.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Jul 2003 16:59:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 15:48, Jeremy Fitzhardinge wrote:
> I've attached the /proc/bus/usb/devices before and after insertion; my
> .config; the output of lspci and lsusb; my loaded modules and the full
> dmesg output.  "cat /proc/scsi/scsi" hangs forever.

This is the output of dmesg with USB_DEBUG and USB_STORAGE_DEBUG
enabled; I inserted and removed the Zio MemoryStick reader (with no
media) and then the memory key.

0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1
period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
ehci_hcd 0000:00:1d.7: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Intel Corp. 82801DB USB EHCI Con
usb usb1: Manufacturer: Linux 2.5.75-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: individual port over-current protection
hub 1-0:0: Single TT
hub 1-0:0: TT requires at most 8 FS bit times
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 0ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
uhci-hcd 0000:00:1d.0: irq 11, io base 00001800
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:1d.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Intel Corp. 82801DB USB (Hub #1)
usb usb2: Manufacturer: Linux 2.5.75-mm1 uhci-hcd
usb usb2: SerialNumber: 0000:00:1d.0
drivers/usb/core/usb.c: usb_hotplug
usb usb2: usb_new_device - registering interface 2-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:0: usb_device_probe
hub 2-0:0: usb_device_probe - got id
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 2-0:0: standalone hub
hub 2-0:0: ganged power switching
hub 2-0:0: global over-current protection
hub 2-0:0: Port indicators are not supported
hub 2-0:0: power on to power good time: 2ms
hub 2-0:0: hub controller current requirement: 0mA
hub 2-0:0: local power source is good
hub 2-0:0: no over-current condition exists
hub 2-0:0: enabling power on all ports
PCI: Found IRQ 5 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
uhci-hcd 0000:00:1d.1: irq 5, io base 00001820
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:1d.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: Intel Corp. 82801DB USB (Hub #2)
usb usb3: Manufacturer: Linux 2.5.75-mm1 uhci-hcd
usb usb3: SerialNumber: 0000:00:1d.1
drivers/usb/core/usb.c: usb_hotplug
usb usb3: usb_new_device - registering interface 3-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:0: usb_device_probe
hub 3-0:0: usb_device_probe - got id
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
hub 3-0:0: standalone hub
hub 3-0:0: ganged power switching
hub 3-0:0: global over-current protection
hub 3-0:0: Port indicators are not supported
hub 3-0:0: power on to power good time: 2ms
hub 3-0:0: hub controller current requirement: 0mA
hub 3-0:0: local power source is good
hub 3-0:0: no over-current condition exists
hub 3-0:0: enabling power on all ports
PCI: Found IRQ 9 for device 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:02:00.2
PCI: Sharing IRQ 9 with 0000:02:02.0
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
uhci-hcd 0000:00:1d.2: irq 9, io base 00001840
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:1d.2: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Intel Corp. 82801DB USB (Hub #3)
usb usb4: Manufacturer: Linux 2.5.75-mm1 uhci-hcd
usb usb4: SerialNumber: 0000:00:1d.2
drivers/usb/core/usb.c: usb_hotplug
usb usb4: usb_new_device - registering interface 4-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 4-0:0: usb_device_probe
hub 4-0:0: usb_device_probe - got id
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
hub 4-0:0: standalone hub
hub 4-0:0: ganged power switching
hub 4-0:0: global over-current protection
hub 4-0:0: Port indicators are not supported
hub 4-0:0: power on to power good time: 2ms
hub 4-0:0: hub controller current requirement: 0mA
hub 4-0:0: local power source is good
hub 4-0:0: no over-current condition exists
hub 4-0:0: enabling power on all ports
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/host/uhci-hcd.c: 1800: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1840: suspend_hc
EXT3 FS on hda2, internal journal
Adding 1050836k swap on /dev/hda4.  Priority:-1 extents:1
ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 9 for device 0000:02:00.2
PCI: Sharing IRQ 9 with 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:02:02.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[c0205000-c02057ff]  Max
Packet=[2048]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 9b050404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 9b050404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 9b050404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
microcode: CPU0 no microcode found! (sig=695, pflags=32)
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377
0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Probing for MPI350 card
PCI: Found IRQ 9 for device 0000:02:02.0
PCI: Sharing IRQ 9 with 0000:00:1d.2
PCI: Sharing IRQ 9 with 0000:00:1f.1
PCI: Sharing IRQ 9 with 0000:02:00.2
rxfids[0].CardRamOff=e1999800
txfids[0].CardRamOff=e1999808
mpi350: found device
v_info(de978260)->rxfids[0].CardRamOff=e1999800
v_info(de978260)->txfids[0].CardRamOff=e1999808
MPI350 start: MAC  00:02:8a:5c:7f:07
mpi350: stop_venus_card(dev=de978000)
SCSI subsystem initialized
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
PCI: Found IRQ 11 for device 0000:01:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:02:00.0
Cleanup mod 
remove mod called
mpi350: stop_venus_card(dev=de978000)
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j  CSC
CONNECT
hub 1-0:0: port 3, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 1-0:0: port 3 not reset yet, waiting 10ms
hub 1-0:0: port 3 not reset yet, waiting 10ms
hub 1-0:0: port 3 not reset yet, waiting 200ms
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003801 POWER OWNER sig=j 
CONNECT
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
hub 3-0:0: port 1, status 101, change 1, 12 Mb/s
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=5
usb 3-1: Product: eUSB Memory Stick Reader
usb 3-1: Manufacturer: SCM Microsystems Inc.
usb 3-1: SerialNumber: 000000000000
drivers/usb/core/usb.c: usb_hotplug
usb 3-1: usb_new_device - registering interface 3-1:0
drivers/usb/core/usb.c: usb_hotplug
Initializing USB Mass Storage driver...
usb-storage 3-1:0: usb_device_probe
usb-storage 3-1:0: usb_device_probe - got id
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: eUSB      Model: Memory Stick      Rev: 2.15
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub 3-0:0: port 1, status 100, change 3, 12 Mb/s
usb 3-1: USB disconnect, address 2
usb 3-1: unregistering interfaces
drivers/usb/core/usb.c: usb_hotplug
usb 3-1: unregistering device
drivers/usb/core/usb.c: usb_hotplug
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001002 POWER sig=se0  CSC
hub 1-0:0: port 3, status 100, change 1, 12 Mb/s
hub 3-0:0: port 1 enable change, status 100
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j  CSC
CONNECT
hub 1-0:0: port 3, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 1-0:0: port 3 not reset yet, waiting 10ms
hub 1-0:0: port 3 not reset yet, waiting 10ms
hub 1-0:0: port 3 not reset yet, waiting 200ms
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003801 POWER OWNER sig=j 
CONNECT
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
hub 3-0:0: port 1, status 101, change 1, 12 Mb/s
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 3
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1: Product: USB 2.0 Memory Key
usb 3-1: Manufacturer: IBM
usb 3-1: SerialNumber: 021E43012E0058F2
drivers/usb/core/usb.c: usb_hotplug
usb 3-1: usb_new_device - registering interface 3-1:0
drivers/usb/core/usb.c: usb_hotplug
usb-storage 3-1:0: usb_device_probe
usb-storage 3-1:0: usb_device_probe - got id
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: IBM       Model: Memory Key        Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 127840 512-byte hdwr sectors (65 MB)
sda: Write Protect is off
sda: Mode Sense: 00 46 00 00
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status
440000
[de36a240] link (1e36a1e2) element (1e510030)
  0: [de510030] link (1e510060) e0 Stalled CRC/Timeo Length=7 MaxLen=7
DT0 EndPt=0 Dev=3, PID=2d(SETUP) (buf=1e2ca020)
  1: [de510060] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1
EndPt=0 Dev=3, PID=69(IN) (buf=00000000)

drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
intel8x0_measure_ac97_clock: measured 49471 usecs
intel8x0: clocking to 48000
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc
drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
drivers/usb/host/uhci-hcd.c: 1820: wakeup_hc


