Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTLKPMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTLKPMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:12:43 -0500
Received: from creedmoore.nordiq.net ([212.217.248.3]:50366 "EHLO
	beeblebrox.norr.worldnet.se") by vger.kernel.org with ESMTP
	id S265085AbTLKPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:11:21 -0500
Subject: Problem: USB Mass Storage, cannot mount Flash drives
From: Matti =?ISO-8859-1?Q?L=E5ngvall?= <matti@ovikonline.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Dec 2003 16:11:12 +0100
Message-Id: <1071155473.1666.4.camel@deathstar>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I have for quite some time been unable to mount flash drives, it works
in  2.4.x
but not in 2.6.0 testX.

Some details that needs to be completed with ?


Please cc: me, I'm not subscribing to the list.

Thanks
Matti L

[1.] One (multi-)line summary of the problem:
-------------------------------------

I cannot mount any USB mass storage drive when using kernel 2.6.0-test11
(and -bk3, -bk8).
Tested both USB 1.1 and 2.0 devices.

Plugging in a CF card in the card reader (built in reader) does not work
either, the kernel 
does not detect the insertion (no message in syslog).

[2.] Full description of the problem/report:
--------------------------------------------

Cuts from /var/log/syslog

Dec 11 14:41:34 deathstar kernel: ehci_hcd: block sizes: qh 128 qtd 96
itd 128 sitd 64
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: EHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: reset
hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: reset
hcc_params 6871 thresh 7 uframes 1024 64 bit addr
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: capability
10001 at 68
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: BIOS handoff
succeeded
Dec 11 14:41:34 deathstar kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem
f880ec00
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: new USB bus
registered, assigned bus number 1
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: reset command
080012 (park)=0 ithresh=8 Periodic period=1024 Reset HALT
Dec 11 14:41:34 deathstar kernel: PCI: cache line size of 128 is not
supported by device 0000:00:1d.7
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: init command
010001 (park)=0 ithresh=1 period=1024 RUN
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: USB 2.0
enabled, EHCI 1.00, driver 2003-Jun-13
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: root hub device
address 1
Dec 11 14:41:34 deathstar kernel: usb usb1: new device strings: Mfr=3,
Product=2, SerialNumber=1
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/message.c: USB device
number 1 default language ID 0x409
Dec 11 14:41:34 deathstar kernel: usb usb1: Product: EHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: usb usb1: Manufacturer: Linux
2.6.0-test11-bk8 ehci_hcd
Dec 11 14:41:34 deathstar kernel: usb usb1: SerialNumber: 0000:00:1d.7
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb usb1: registering 1-0:1.0 (config
#1, interface 0)
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: usb_probe_interface
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: usb_probe_interface - got
id
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: USB hub found
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: 8 ports detected
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: standalone hub
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: ganged power switching
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: individual port
over-current protection
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: Single TT
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: TT requires at most 8 FS
bit times
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: Port indicators are not
supported
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: power on to power good
time: 0ms
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: hub controller current
requirement: 0mA
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: local power source is
good
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: no over-current condition
exists
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: enabling power on all
ports
Dec 11 14:41:34 deathstar kernel: drivers/usb/host/uhci-hcd.c: USB
Universal Host Controller Interface driver v2.1
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.0: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.0: irq 16, io base
0000e000
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 2
Dec 11 14:41:34 deathstar kernel: drivers/usb/host/uhci-hcd.c: detected
2 ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.0: root hub device
address 1
Dec 11 14:41:34 deathstar kernel: usb usb2: new device strings: Mfr=3,
Product=2, SerialNumber=1
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/message.c: USB device
number 1 default language ID 0x409
Dec 11 14:41:34 deathstar kernel: usb usb2: Product: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: usb usb2: Manufacturer: Linux
2.6.0-test11-bk8 uhci_hcd
Dec 11 14:41:34 deathstar kernel: usb usb2: SerialNumber: 0000:00:1d.0
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb usb2: registering 2-0:1.0 (config
#1, interface 0)
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: usb_probe_interface
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: usb_probe_interface - got
id
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: USB hub found
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: 2 ports detected
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: standalone hub
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: ganged power switching
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: global over-current
protection
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: Port indicators are not
supported
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: power on to power good
time: 2ms
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: hub controller current
requirement: 0mA
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: local power source is
good
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: no over-current condition
exists
Dec 11 14:41:34 deathstar kernel: hub 2-0:1.0: enabling power on all
ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.1: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.1: irq 19, io base
0000e400
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 3
Dec 11 14:41:34 deathstar kernel: drivers/usb/host/uhci-hcd.c: detected
2 ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.1: root hub device
address 1
Dec 11 14:41:34 deathstar kernel: usb usb3: new device strings: Mfr=3,
Product=2, SerialNumber=1
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/message.c: USB device
number 1 default language ID 0x409
Dec 11 14:41:34 deathstar kernel: usb usb3: Product: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: usb usb3: Manufacturer: Linux
2.6.0-test11-bk8 uhci_hcd
Dec 11 14:41:34 deathstar kernel: usb usb3: SerialNumber: 0000:00:1d.1
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb usb3: registering 3-0:1.0 (config
#1, interface 0)
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: usb_probe_interface
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: usb_probe_interface - got
id
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: USB hub found
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: 2 ports detected
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: standalone hub
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: ganged power switching
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: global over-current
protection
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: Port indicators are not
supported
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: power on to power good
time: 2ms
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: hub controller current
requirement: 0mA
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: local power source is
good
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: no over-current condition
exists
Dec 11 14:41:34 deathstar kernel: hub 3-0:1.0: enabling power on all
ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.2: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.2: irq 18, io base
0000e800
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 4
Dec 11 14:41:34 deathstar kernel: drivers/usb/host/uhci-hcd.c: detected
2 ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.2: root hub device
address 1
Dec 11 14:41:34 deathstar kernel: usb usb4: new device strings: Mfr=3,
Product=2, SerialNumber=1
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/message.c: USB device
number 1 default language ID 0x409
Dec 11 14:41:34 deathstar kernel: usb usb4: Product: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: usb usb4: Manufacturer: Linux
2.6.0-test11-bk8 uhci_hcd
Dec 11 14:41:34 deathstar kernel: usb usb4: SerialNumber: 0000:00:1d.2
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb usb4: registering 4-0:1.0 (config
#1, interface 0)
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: usb_probe_interface
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: usb_probe_interface - got
id
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: USB hub found
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: 2 ports detected
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: standalone hub
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: ganged power switching
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: global over-current
protection
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: Port indicators are not
supported
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: power on to power good
time: 2ms
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: hub controller current
requirement: 0mA
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: local power source is
good
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: no over-current condition
exists
Dec 11 14:41:34 deathstar kernel: hub 4-0:1.0: enabling power on all
ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.3: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
7 status 001803 POWER sig=j  CSC CONNECT
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: port 7, status 501,
change 1, 480 Mb/s
Dec 11 14:41:34 deathstar kernel: PCI: Setting latency timer of device
0000:00:1d.3 to 64
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.3: irq 16, io base
0000ec00
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.3: new USB bus
registered, assigned bus number 5
Dec 11 14:41:34 deathstar kernel: drivers/usb/host/uhci-hcd.c: detected
2 ports
Dec 11 14:41:34 deathstar kernel: uhci_hcd 0000:00:1d.3: root hub device
address 1
Dec 11 14:41:34 deathstar kernel: usb usb5: new device strings: Mfr=3,
Product=2, SerialNumber=1
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/message.c: USB device
number 1 default language ID 0x409
Dec 11 14:41:34 deathstar kernel: usb usb5: Product: UHCI Host
Controller
Dec 11 14:41:34 deathstar kernel: usb usb5: Manufacturer: Linux
2.6.0-test11-bk8 uhci_hcd
Dec 11 14:41:34 deathstar kernel: usb usb5: SerialNumber: 0000:00:1d.3
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb usb5: registering 5-0:1.0 (config
#1, interface 0)
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: usb_probe_interface
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: usb_probe_interface - got
id
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: USB hub found
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: 2 ports detected
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: standalone hub
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: ganged power switching
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: global over-current
protection
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: Port indicators are not
supported
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: power on to power good
time: 2ms
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: hub controller current
requirement: 0mA
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: local power source is
good
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: no over-current condition
exists
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: enabling power on all
ports
Dec 11 14:41:34 deathstar kernel: Initializing USB Mass Storage
driver...
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: registered new
driver usb-storage
Dec 11 14:41:34 deathstar kernel: USB Mass Storage support registered.
Dec 11 14:41:34 deathstar kernel: mice: PS/2 mouse device common for all
mice
Dec 11 14:41:34 deathstar kernel: hub 1-0:1.0: debounce: port 7: delay
100ms stable 4 status 0x501
Dec 11 14:41:34 deathstar kernel: input: ImPS/2 Generic Wheel Mouse on
isa0060/serio1
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: port 7 full
speed --> companion
Dec 11 14:41:34 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
7 status 003801 POWER OWNER sig=j  CONNECT


Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: port 1, status 101,
change 1, 12 Mb/s
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: debounce: port 1: delay
100ms stable 4 status 0x101
Dec 11 14:41:34 deathstar kernel: hub 5-0:1.0: new USB device on port 1,
assigned address 2
Dec 11 14:41:34 deathstar kernel: usb 5-1: new device strings: Mfr=1,
Product=2, SerialNumber=3
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/message.c: USB device
number 2 default language ID 0x409
Dec 11 14:41:34 deathstar kernel: usb 5-1: Product: USB Reader
Dec 11 14:41:34 deathstar kernel: usb 5-1: Manufacturer:
Dec 11 14:41:34 deathstar kernel: usb 5-1: SerialNumber: 9206051
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb 5-1: registering 5-1:1.0 (config
#1, interface 0)
Dec 11 14:41:34 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:41:34 deathstar kernel: usb-storage 5-1:1.0:
usb_probe_interface
Dec 11 14:41:34 deathstar kernel: usb-storage 5-1:1.0:
usb_probe_interface - got id
Dec 11 14:41:34 deathstar kernel: usb-storage: USB Mass Storage device
detected
Dec 11 14:41:34 deathstar kernel: usb-storage: act_altsetting is 0,
id_index is 103
Dec 11 14:41:34 deathstar kernel: usb-storage: -- associate_dev
Dec 11 14:41:34 deathstar kernel: usb-storage: Transport: Bulk
Dec 11 14:41:34 deathstar kernel: usb-storage: Protocol: Transparent
SCSI
Dec 11 14:41:34 deathstar kernel: usb-storage: Endpoints: In: 0xf7cf7454
Out: 0xf7cf7440 Int: 0x00000000 (Period 0)
Dec 11 14:41:34 deathstar kernel: usb-storage: usb_stor_control_msg:
rq=fe rqtype=a1 value=0000 index=00 len=1
Dec 11 14:41:34 deathstar kernel: usb-storage: GetMaxLUN command result
is 1, data is 3
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: scsi0 : SCSI emulation for USB Mass
Storage devices
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 14:41:34 deathstar kernel: usb-storage:  12 00 00 00 24 00
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0x1 R 0 Stat 0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Fixing INQUIRY data to
show SCSI rev 2 - was 0
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel:   Vendor: Generic   Model: USB SD
Reader     Rev: 1.00
Dec 11 14:41:34 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 14:41:34 deathstar kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 0, lun 0,  type 0
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 14:41:34 deathstar kernel: usb-storage:  12 20 00 00 24 00
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0x2 L 36 F 128 Trg 0 LUN 1 CL 6
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0x2 R 0 Stat 0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Fixing INQUIRY data to
show SCSI rev 2 - was 0
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel:   Vendor: Generic   Model: USB CF
Reader     Rev: 1.01
Dec 11 14:41:34 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 14:41:34 deathstar kernel: Attached scsi generic sg1 at scsi0,
channel 0, id 0, lun 1,  type 0
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 14:41:34 deathstar kernel: usb-storage:  12 40 00 00 24 00
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0x3 L 36 F 128 Trg 0 LUN 2 CL 6
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0x3 R 0 Stat 0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Fixing INQUIRY data to
show SCSI rev 2 - was 0
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel:   Vendor: Generic   Model: USB SM
Reader     Rev: 1.02
Dec 11 14:41:34 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 14:41:34 deathstar kernel: Attached scsi generic sg2 at scsi0,
channel 0, id 0, lun 2,  type 0
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 14:41:34 deathstar kernel: usb-storage:  12 60 00 00 24 00
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0x4 L 36 F 128 Trg 0 LUN 3 CL 6
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 14:41:34 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 14:41:34 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 14:41:34 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 14:41:34 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0x4 R 0 Stat 0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: Fixing INQUIRY data to
show SCSI rev 2 - was 0
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel:   Vendor: Generic   Model: USB MS
Reader     Rev: 1.03
Dec 11 14:41:34 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 14:41:34 deathstar kernel: Attached scsi generic sg3 at scsi0,
channel 0, id 0, lun 3,  type 0
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad LUN (0:4)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (1:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (2:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (3:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (4:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (5:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (6:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:41:34 deathstar kernel: usb-storage: Bad target number (7:0)
Dec 11 14:41:34 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:41:34 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:41:34 deathstar kernel: WARNING: USB Mass Storage data
integrity not assured
Dec 11 14:41:34 deathstar kernel: USB Mass Storage device found at 2


Connecting USB 1.1 flash drive (V-Drive 64MB):

Dec 11 14:52:39 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
6 status 001803 POWER sig=j  CSC CONNECT
Dec 11 14:52:39 deathstar kernel: hub 1-0:1.0: port 6, status 501,
change 1, 480 Mb/s
Dec 11 14:52:39 deathstar kernel: hub 1-0:1.0: debounce: port 6: delay
100ms stable 4 status 0x501
Dec 11 14:52:39 deathstar kernel: ehci_hcd 0000:00:1d.7: port 6 full
speed --> companion
Dec 11 14:52:39 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
6 status 003801 POWER OWNER sig=j  CONNECT
Dec 11 14:52:39 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
7 status 003002 POWER OWNER sig=se0  CSC
Dec 11 14:52:39 deathstar kernel: hub 1-0:1.0: port 7, status 0, change
1, 12 Mb/s
Dec 11 14:52:39 deathstar kernel: drivers/usb/host/uhci-hcd.c: e800:
wakeup_hc
Dec 11 14:52:39 deathstar kernel: hub 4-0:1.0: port 2, status 101,
change 1, 12 Mb/s
Dec 11 14:52:39 deathstar kernel: hub 4-0:1.0: debounce: port 2: delay
100ms stable 4 status 0x101
Dec 11 14:52:39 deathstar kernel: hub 4-0:1.0: new USB device on port 2,
assigned address 2
Dec 11 14:52:39 deathstar kernel: usb 4-2: new device strings: Mfr=0,
Product=0, SerialNumber=0
Dec 11 14:52:39 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:52:39 deathstar kernel: usb 4-2: registering 4-2:1.0 (config
#1, interface 0)
Dec 11 14:52:39 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 14:52:39 deathstar kernel: usb-storage 4-2:1.0:
usb_probe_interface
Dec 11 14:52:39 deathstar kernel: usb-storage 4-2:1.0:
usb_probe_interface - got id
Dec 11 14:52:39 deathstar kernel: usb-storage: USB Mass Storage device
detected
Dec 11 14:52:39 deathstar kernel: usb-storage: act_altsetting is 0,
id_index is 103
Dec 11 14:52:39 deathstar kernel: usb-storage: -- associate_dev
Dec 11 14:52:39 deathstar kernel: usb-storage: Transport: Bulk
Dec 11 14:52:39 deathstar kernel: usb-storage: Protocol: Transparent
SCSI
Dec 11 14:52:39 deathstar kernel: usb-storage: Endpoints: In: 0xf6baec80
Out: 0xf6baec94 Int: 0xf6baeca8 (Period 255)
Dec 11 14:52:39 deathstar kernel: usb-storage: usb_stor_control_msg:
rq=fe rqtype=a1 value=0000 index=00 len=1
Dec 11 14:52:39 deathstar usb.agent[1125]: ... no modules for USB
product c76/5/100
Dec 11 14:52:39 deathstar kernel: usb-storage: GetMaxLUN command result
is 1, data is 0
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: scsi1 : SCSI emulation for USB Mass
Storage devices
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 14:52:39 deathstar kernel: usb-storage:  12 00 00 00 24 00
Dec 11 14:52:39 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0xd L 36 F 128 Trg 0 LUN 0 CL 6
Dec 11 14:52:39 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 14:52:39 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 14:52:39 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:52:39 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 14:52:39 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 14:52:39 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 14:52:39 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:52:39 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 14:52:39 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 14:52:39 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 14:52:39 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 14:52:39 deathstar kernel: usb-storage: -- transfer complete
Dec 11 14:52:39 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 14:52:39 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0xd R 0 Stat 0x0
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel:   Vendor:          
Model:                   Rev:
Dec 11 14:52:39 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 14:52:39 deathstar scsi.agent[1150]: bogus sysfs
DEVPATH=/devices/pci0000:00/0000:00:1d.2/usb4/4-2/4-2:1.0/host1/1:0:0:0
Dec 11 14:52:39 deathstar kernel: Attached scsi generic sg4 at scsi1,
channel 0, id 0, lun 0,  type 0
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad LUN (0:1)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (1:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (2:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (3:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (4:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (5:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (6:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: usb-storage: queuecommand called
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 14:52:39 deathstar kernel: usb-storage: Bad target number (7:0)
Dec 11 14:52:39 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 14:52:39 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 14:52:39 deathstar kernel: WARNING: USB Mass Storage data
integrity not assured
Dec 11 14:52:39 deathstar kernel: USB Mass Storage device found at 2
Dec 11 14:53:01 deathstar /USR/SBIN/CRON[1165]: (mail) CMD (  if [ -x
/usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; then
/usr/lib/exim/exim3 -q ; fi)



Disconnect USB 1.1 flash drive (V-Drive 64MB)

Dec 11 15:08:33 deathstar kernel: hub 4-0:1.0: port 2, status 100,
change 3, 12 Mb/s
Dec 11 15:08:33 deathstar kernel: usb 4-2: USB disconnect, address 2
Dec 11 15:08:33 deathstar kernel: usb 4-2: usb_disable_device nuking all
URBs
Dec 11 15:08:33 deathstar kernel: usb 4-2: unregistering interface
4-2:1.0
Dec 11 15:08:33 deathstar kernel: usb-storage: storage_disconnect()
called
Dec 11 15:08:33 deathstar kernel: usb-storage: usb_stor_stop_transport
called
Dec 11 15:08:33 deathstar kernel: usb-storage: -- dissociate_dev
Dec 11 15:08:33 deathstar kernel: usb-storage: -- sending exit command
to thread
Dec 11 15:08:33 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:33 deathstar kernel: usb-storage: -- exit command received
Dec 11 15:08:33 deathstar kernel: usb-storage: --
usb_stor_release_resources finished
Dec 11 15:08:33 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 15:08:33 deathstar kernel: usb 4-2: unregistering device
Dec 11 15:08:33 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 15:08:33 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
6 status 001002 POWER sig=se0  CSC
Dec 11 15:08:33 deathstar kernel: hub 1-0:1.0: port 6, status 100,
change 1, 12 Mb/s
Dec 11 15:08:33 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
7 status 003002 POWER OWNER sig=se0  CSC
Dec 11 15:08:33 deathstar kernel: hub 1-0:1.0: port 7, status 0, change
1, 12 Mb/s
Dec 11 15:08:33 deathstar kernel: hub 4-0:1.0: port 2 enable change,
status 100
Dec 11 15:08:34 deathstar kernel: drivers/usb/host/uhci-hcd.c: e800:
suspend_hc



Connect USB 2.0 flash drive (Pen Drive 512MB)

Dec 11 15:08:44 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
5 status 001803 POWER sig=j  CSC CONNECT
Dec 11 15:08:44 deathstar kernel: hub 1-0:1.0: port 5, status 501,
change 1, 480 Mb/s
Dec 11 15:08:45 deathstar kernel: hub 1-0:1.0: debounce: port 5: delay
100ms stable 4 status 0x501
Dec 11 15:08:45 deathstar kernel: ehci_hcd 0000:00:1d.7: port 5 high
speed
Dec 11 15:08:45 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
5 status 001005 POWER sig=se0  PE CONNECT
Dec 11 15:08:45 deathstar kernel: hub 1-0:1.0: new USB device on port 5,
assigned address 2
Dec 11 15:08:45 deathstar kernel: usb 1-5: new device strings: Mfr=1,
Product=2, SerialNumber=3
Dec 11 15:08:45 deathstar kernel: drivers/usb/core/message.c: USB device
number 2 default language ID 0x409
Dec 11 15:08:45 deathstar kernel: usb 1-5: Product: USB DISK Pro
Dec 11 15:08:45 deathstar kernel: usb 1-5: SerialNumber: 07361A051919
Dec 11 15:08:45 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 15:08:45 deathstar kernel: usb 1-5: registering 1-5:1.0 (config
#1, interface 0)
Dec 11 15:08:45 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 15:08:45 deathstar kernel: usb-storage 1-5:1.0:
usb_probe_interface
Dec 11 15:08:45 deathstar kernel: usb-storage 1-5:1.0:
usb_probe_interface - got id
Dec 11 15:08:45 deathstar kernel: usb-storage: USB Mass Storage device
detected
Dec 11 15:08:45 deathstar kernel: usb-storage: act_altsetting is 0,
id_index is 103
Dec 11 15:08:45 deathstar kernel: usb-storage: -- associate_dev
Dec 11 15:08:45 deathstar kernel: usb-storage: Transport: Bulk
Dec 11 15:08:45 deathstar kernel: usb-storage: Protocol: Transparent
SCSI
Dec 11 15:08:45 deathstar kernel: usb-storage: Endpoints: In: 0xf6772d40
Out: 0xf6772d54 Int: 0x00000000 (Period 0)
Dec 11 15:08:45 deathstar kernel: usb-storage: usb_stor_control_msg:
rq=fe rqtype=a1 value=0000 index=00 len=1
Dec 11 15:08:45 deathstar usb.agent[1218]: ... no modules for USB
product d7d/1320/50
Dec 11 15:08:45 deathstar kernel: usb-storage: GetMaxLUN command result
is 1, data is 1
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: scsi2 : SCSI emulation for USB Mass
Storage devices
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 15:08:45 deathstar kernel: usb-storage:  12 00 00 00 24 00
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0x16 L 36 F 128 Trg 0 LUN 0 CL 6
Dec 11 15:08:45 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 15:08:45 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 15:08:45 deathstar kernel: usb-storage: -- transfer complete
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 15:08:45 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 15:08:45 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 15:08:45 deathstar kernel: usb-storage: -- transfer complete
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 15:08:45 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 15:08:45 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 15:08:45 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 15:08:45 deathstar kernel: usb-storage: -- transfer complete
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0x16 R 0 Stat 0x0
Dec 11 15:08:45 deathstar kernel: usb-storage: Fixing INQUIRY data to
show SCSI rev 2 - was 0
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel:   Vendor:           Model: USB DISK
Pro      Rev: 1.0E
Dec 11 15:08:45 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 15:08:45 deathstar scsi.agent[1244]: bogus sysfs
DEVPATH=/devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1.0/host2/2:0:0:0
Dec 11 15:08:45 deathstar kernel: Attached scsi generic sg4 at scsi2,
channel 0, id 0, lun 0,  type 0
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Command INQUIRY (6 bytes)
Dec 11 15:08:45 deathstar kernel: usb-storage:  12 20 00 00 24 00
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk Command S 0x43425355
T 0x17 L 36 F 128 Trg 0 LUN 1 CL 6
Dec 11 15:08:45 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 31 bytes
Dec 11 15:08:45 deathstar kernel: usb-storage: Status code 0;
transferred 31/31
Dec 11 15:08:45 deathstar kernel: usb-storage: -- transfer complete
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk command transfer
result=0
Dec 11 15:08:45 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 36 bytes
Dec 11 15:08:45 deathstar kernel: usb-storage: Status code 0;
transferred 36/36
Dec 11 15:08:45 deathstar kernel: usb-storage: -- transfer complete
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk data transfer result
0x0
Dec 11 15:08:45 deathstar kernel: usb-storage: Attempting to get CSW...
Dec 11 15:08:45 deathstar kernel: usb-storage:
usb_stor_bulk_transfer_buf: xfer 13 bytes
Dec 11 15:08:45 deathstar kernel: usb-storage: Status code 0;
transferred 13/13
Dec 11 15:08:45 deathstar kernel: usb-storage: -- transfer complete
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk status result = 0
Dec 11 15:08:45 deathstar kernel: usb-storage: Bulk Status S 0x53425355
T 0x17 R 0 Stat 0x0
Dec 11 15:08:45 deathstar kernel: usb-storage: Fixing INQUIRY data to
show SCSI rev 2 - was 0
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done, result=0x0
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel:   Vendor:           Model: USB DISK
Pro      Rev: 1.0E
Dec 11 15:08:45 deathstar kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
Dec 11 15:08:45 deathstar scsi.agent[1257]: bogus sysfs
DEVPATH=/devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1.0/host2/2:0:0:1
Dec 11 15:08:45 deathstar kernel: Attached scsi generic sg5 at scsi2,
channel 0, id 0, lun 1,  type 0
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad LUN (0:2)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (1:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (2:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (3:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (4:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (5:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (6:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: usb-storage: queuecommand called
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:08:45 deathstar kernel: usb-storage: Bad target number (7:0)
Dec 11 15:08:45 deathstar kernel: usb-storage: scsi cmd done,
result=0x40000
Dec 11 15:08:45 deathstar kernel: usb-storage: *** thread sleeping.
Dec 11 15:08:45 deathstar kernel: WARNING: USB Mass Storage data
integrity not assured
Dec 11 15:08:45 deathstar kernel: USB Mass Storage device found at 2
Dec 11 15:08:45 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
7 status 003002 POWER OWNER sig=se0  CSC
Dec 11 15:08:45 deathstar kernel: hub 1-0:1.0: port 7, status 0, change
1, 12 Mb/s

Disconnecting USB 2.0 flash drive (Pen Drive 512MB)

Dec 11 15:49:23 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
5 status 001002 POWER sig=se0  CSC
Dec 11 15:49:23 deathstar kernel: hub 1-0:1.0: port 5, status 100,
change 1, 12 Mb/s
Dec 11 15:49:23 deathstar kernel: usb 1-5: USB disconnect, address 2
Dec 11 15:49:23 deathstar kernel: usb 1-5: usb_disable_device nuking all
URBs
Dec 11 15:49:23 deathstar kernel: usb 1-5: unregistering interface
1-5:1.0
Dec 11 15:49:23 deathstar kernel: usb-storage: storage_disconnect()
called
Dec 11 15:49:23 deathstar kernel: usb-storage: usb_stor_stop_transport
called
Dec 11 15:49:23 deathstar kernel: usb-storage: -- dissociate_dev
Dec 11 15:49:23 deathstar kernel: usb-storage: -- sending exit command
to thread
Dec 11 15:49:23 deathstar kernel: usb-storage: *** thread awakened.
Dec 11 15:49:23 deathstar kernel: usb-storage: -- exit command received
Dec 11 15:49:23 deathstar kernel: usb-storage: --
usb_stor_release_resources finished
Dec 11 15:49:23 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 15:49:23 deathstar kernel: usb 1-5: unregistering device
Dec 11 15:49:23 deathstar kernel: drivers/usb/core/usb.c: usb_hotplug
Dec 11 15:49:23 deathstar kernel: ehci_hcd 0000:00:1d.7: GetStatus port
7 status 003002 POWER OWNER sig=se0  CSC
Dec 11 15:49:23 deathstar kernel: hub 1-0:1.0: port 7, status 0, change
1, 12 Mb/s
 
[3.] Keywords (i.e., modules, networking, kernel):
--------------------------------------------------

USB Mass Storage, kernel 2.6.0-test11, mount

[4.] Kernel version (from /proc/version):
-----------------------------------------

Linux version 2.6.0-test11-bk8 (root@deathstar) (gcc version 3.3.2
(Debian)) #2 SMP Thu Dec 11 14:17:26 CET 2003
 
[5.] Output of Oops.. message (if applicable) with symbolic information 
resolved (see Documentation/oops-tracing.txt)
-----------------------------------------------------------------------

No Oops.. message generated

[6.] A small shell script or example program which triggers the
problem (if possible)
---------------------------------------------------------------

Just plug in a flash drive..

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
-----------------------------------------------------------------

Linux deathstar 2.6.0-test11-bk8 #2 SMP Thu Dec 11 14:17:26 CET 2003
i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre2
e2fsprogs              1.34-WIP
PPP                    2.4.2b3
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         nvidia

[7.2.] Processor information (from /proc/cpuinfo):
-----------------------------------------------------------------
/proc/cpuinfo (HT CPU)

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3200.203
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6324.22

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3200.203
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6389.76

[7.3.] Module information (from /proc/modules):
-----------------------------------------------------------------

No modules, all static in kernel.

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
-----------------------------------------------------------------
/proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-040f : i801-smbus
0cf8-0cff : PCI conf1
b400-b4ff : 0000:02:0f.0
  b400-b4ff : 8139too
b800-b83f : 0000:02:0b.0
  b800-b81f : EMU10K1
bc00-bc07 : 0000:02:03.0
e000-e01f : 0000:00:1d.0
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:1d.1
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:1d.2
  e800-e81f : uhci_hcd
ec00-ec1f : 0000:00:1d.3
  ec00-ec1f : uhci_hcd
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffcffff : System RAM
  00100000-0039fbec : Kernel code
  0039fbed-004ae2ff : Kernel data
3ffd0000-3ffdefff : ACPI Tables
3ffdf000-3fffffff : ACPI Non-volatile Storage
40000000-400003ff : 0000:00:1f.1
d7f00000-f7efffff : PCI Bus #01
  e0000000-efffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fc900000-fe9fffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
feae8000-feaebfff : 0000:02:0e.0
feaef000-feaef7ff : 0000:02:0e.0
feaef800-feaef8ff : 0000:02:0f.0
  feaef800-feaef8ff : 8139too
feaefc00-feaeffff : 0000:02:0a.0
  feaefc00-feaeffff : saa7134[0]
feaf0000-feafffff : 0000:02:03.0
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
ffb80000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
-----------------------------------------------------------------

00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller
(rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a5
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW-
Rate=x8

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc900000-fe9fffff
        Prefetchable memory behind bridge: d7f00000-f7efffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at e000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at e400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at febffc00 (32-bit, non-prefetchable)
[size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev
02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller
(rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable)
[size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce FX
5900 Ultra] (rev a1) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 0313
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Expansion ROM at fe9e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x8

02:03.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
        Subsystem: GVC Corporation Compaq Stinger
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at feaf0000 (32-bit, non-prefetchable)
[size=64K]
        Region 1: I/O ports at bc00 [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown device 4840
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at feaefc00 (32-bit, non-prefetchable)
[size=1K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-

02:0b.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs: Unknown device 1009
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at b800 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0e.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 1000ns max), Cache Line Size: 0x04 (16
bytes)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at feaef000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: Memory at feae8000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 80b3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at feaef800 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
-----------------------------------------------------------------

/proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: USB SD Reader    Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic  Model: USB CF Reader    Rev: 1.01
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic  Model: USB SM Reader    Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic  Model: USB MS Reader    Rev: 1.03
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: USB DISK Pro     Rev: 1.0E
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 01
  Vendor:          Model: USB DISK Pro     Rev: 1.0E
  Type:   Direct-Access                    ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
> (please look in /proc and include all information that you
> think to be relevant):
-----------------------------------------------------------------
/proc/scsi/usb-storage/0

  Host scsi0: usb-storage
       Vendor:  
      Product: USB Reader
Serial Number: 9206051
     Protocol: Transparent SCSI
    Transport: Bulk
       Quirks:


/proc/scsi/usb-storage/2

   Host scsi2: usb-storage
       Vendor: Unknown
      Product: USB DISK Pro
Serial Number: 07361A051919
     Protocol: Transparent SCSI
    Transport: Bulk
       Quirks:

 [X.] Other notes, patches, fixes, workarounds:
----------------------------------------------
No additional patches installed.


