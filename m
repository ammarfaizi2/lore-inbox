Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUC0JRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 04:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUC0JRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 04:17:09 -0500
Received: from p3EE060FB.dip0.t-ipconnect.de ([62.224.96.251]:62080 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261624AbUC0JQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 04:16:54 -0500
Message-ID: <40654681.5070806@p3EE060FB.dip0.t-ipconnect.de>
Date: Sat, 27 Mar 2004 10:16:49 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB broken in 2.6.5rc2
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The following problem occures not in kernel 2.6.4!


I'm starting USB by loading the module uhci_hcd and usb_storage:

Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: registered new 
driver usbfs
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: registered new 
driver hub
Mar 27 10:04:02 athlon kernel: USB Universal Host Controller Interface 
driver v2.2
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: VIA Technologies, 
Inc. USB
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: irq 21, io base 0000d800
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: new USB bus 
registered, assigned bus number 1
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: detected 2 ports
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: root hub device 
address 1
Mar 27 10:04:02 athlon kernel: usb usb1: new device strings: Mfr=3, 
Product=2, SerialNumber=1
Mar 27 10:04:02 athlon kernel: drivers/usb/core/message.c: USB device 
number 1 default language ID 0x409
Mar 27 10:04:02 athlon kernel: usb usb1: Product: VIA Technologies, Inc. USB
Mar 27 10:04:02 athlon kernel: usb usb1: Manufacturer: Linux 2.6.5-rc2 
uhci_hcd
Mar 27 10:04:02 athlon kernel: usb usb1: SerialNumber: 0000:00:10.0
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:02 athlon kernel: usb usb1: registering 1-0:1.0 (config #1, 
interface 0)
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: usb_probe_interface
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: usb_probe_interface - got id
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: USB hub found
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: 2 ports detected
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: standalone hub
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: unknown reserved power 
switching mode
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: individual port over-current 
protection
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: Port indicators are not supported
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: power on to power good time: 2ms
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: hub controller current 
requirement: 0mA
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: local power source is good
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: no over-current condition exists
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: enabling power on all ports
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: VIA Technologies, 
Inc. USB (#2)
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: irq 21, io base 0000dc00
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: new USB bus 
registered, assigned bus number 2
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: detected 2 ports
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: root hub device 
address 1
Mar 27 10:04:02 athlon kernel: usb usb2: new device strings: Mfr=3, 
Product=2, SerialNumber=1
Mar 27 10:04:02 athlon kernel: drivers/usb/core/message.c: USB device 
number 1 default language ID 0x409
Mar 27 10:04:02 athlon kernel: usb usb2: Product: VIA Technologies, Inc. 
USB (#2)
Mar 27 10:04:02 athlon kernel: usb usb2: Manufacturer: Linux 2.6.5-rc2 
uhci_hcd
Mar 27 10:04:02 athlon kernel: usb usb2: SerialNumber: 0000:00:10.1
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:02 athlon kernel: usb usb2: registering 2-0:1.0 (config #1, 
interface 0)
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: usb_probe_interface
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: usb_probe_interface - got id
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: USB hub found
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: 2 ports detected
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: standalone hub
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: unknown reserved power 
switching mode
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: individual port over-current 
protection
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: Port indicators are not supported
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: power on to power good time: 2ms
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: hub controller current 
requirement: 0mA
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: local power source is good
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: no over-current condition exists
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: enabling power on all ports
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: VIA Technologies, 
Inc. USB (#3)
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: irq 21, io base 0000e000
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: new USB bus 
registered, assigned bus number 3
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: detected 2 ports
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: root hub device 
address 1
Mar 27 10:04:02 athlon kernel: usb usb3: new device strings: Mfr=3, 
Product=2, SerialNumber=1
Mar 27 10:04:02 athlon kernel: drivers/usb/core/message.c: USB device 
number 1 default language ID 0x409
Mar 27 10:04:02 athlon kernel: usb usb3: Product: VIA Technologies, Inc. 
USB (#3)
Mar 27 10:04:02 athlon kernel: usb usb3: Manufacturer: Linux 2.6.5-rc2 
uhci_hcd
Mar 27 10:04:02 athlon kernel: usb usb3: SerialNumber: 0000:00:10.2
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:02 athlon kernel: usb usb3: registering 3-0:1.0 (config #1, 
interface 0)
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: usb_probe_interface
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: usb_probe_interface - got id
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: USB hub found
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: 2 ports detected
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: standalone hub
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: unknown reserved power 
switching mode
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: individual port over-current 
protection
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: Port indicators are not supported
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: power on to power good time: 2ms
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: hub controller current 
requirement: 0mA
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: local power source is good
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: no over-current condition exists
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: enabling power on all ports
Mar 27 10:04:02 athlon kernel: Initializing USB Mass Storage driver...
Mar 27 10:04:02 athlon kernel: drivers/usb/core/usb.c: registered new 
driver usb-storage
Mar 27 10:04:02 athlon kernel: USB Mass Storage support registered.
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: port 1 portsc 008a
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: port 1, status 100, change 3, 
12 Mb/s
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: port 2 portsc 008a
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: port 2, status 100, change 3, 
12 Mb/s
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: port 1 portsc 008a
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: port 1, status 100, change 3, 
12 Mb/s
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: port 2 portsc 018a
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: port 2, status 300, change 3, 
1.5 Mb/s
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: port 1 portsc 008a
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: port 1, status 100, change 3, 
12 Mb/s
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: port 2 portsc 018a
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: port 2, status 300, change 3, 
1.5 Mb/s
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: port 1 portsc 0088
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: port 1 enable change, status 100
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: port 2 portsc 0088
Mar 27 10:04:02 athlon kernel: hub 1-0:1.0: port 2 enable change, status 100
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: port 1 portsc 0088
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: port 1 enable change, status 100
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: port 2 portsc 0188
Mar 27 10:04:02 athlon kernel: hub 2-0:1.0: port 2 enable change, status 300
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: port 1 portsc 0088
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: port 1 enable change, status 100
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: port 2 portsc 0188
Mar 27 10:04:02 athlon kernel: hub 3-0:1.0: port 2 enable change, status 300
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.0: suspend_hc
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.1: suspend_hc
Mar 27 10:04:02 athlon kernel: uhci_hcd 0000:00:10.2: suspend_hc


Now, I'm connecting a USB-Device:

Mar 27 10:04:26 athlon kernel: uhci_hcd 0000:00:10.1: wakeup_hc
Mar 27 10:04:26 athlon kernel: uhci_hcd 0000:00:10.1: port 1 portsc 0093
Mar 27 10:04:26 athlon kernel: hub 2-0:1.0: port 1, status 101, change 1, 
12 Mb/s
Mar 27 10:04:26 athlon kernel: hub 2-0:1.0: debounce: port 1: delay 100ms 
stable 4 status 0x101
Mar 27 10:04:26 athlon kernel: usb 2-1: new full speed USB device using 
address 3
Mar 27 10:04:26 athlon kernel: usb 2-1: new device strings: Mfr=1, 
Product=2, SerialNumber=0
Mar 27 10:04:26 athlon kernel: drivers/usb/core/message.c: USB device 
number 3 default language ID 0x409
Mar 27 10:04:26 athlon kernel: usb 2-1: Product: PENTAX OPTIO S4
Mar 27 10:04:26 athlon kernel: usb 2-1: Manufacturer: PENTAX
Mar 27 10:04:26 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:26 athlon kernel: usb 2-1: registering 2-1:1.0 (config #1, 
interface 0)
Mar 27 10:04:26 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:04:26 athlon kernel: usb-storage 2-1:1.0: usb_probe_interface
Mar 27 10:04:26 athlon kernel: usb-storage 2-1:1.0: usb_probe_interface - 
got id
Mar 27 10:04:26 athlon kernel: scsi1 : SCSI emulation for USB Mass Storage 
devices
Mar 27 10:04:26 athlon kernel:   Vendor: Pentax    Model: Optio S/S4 
   Rev: 1000
Mar 27 10:04:26 athlon kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 27 10:04:26 athlon kernel: USB Mass Storage device found at 3


I'm accessing some datas on the device, unmount it and disconnect it again.

Mar 27 10:04:41 athlon kernel: SCSI device sda: 22144 512-byte hdwr 
sectors (11 MB)
Mar 27 10:04:41 athlon kernel: sda: assuming Write Enabled
Mar 27 10:04:41 athlon kernel: sda: assuming drive cache: write through
Mar 27 10:04:41 athlon kernel:  sda: sda1
Mar 27 10:04:41 athlon kernel: Attached scsi removable disk sda at scsi1, 
channel 0, id 0, lun 0


Mar 27 10:05:05 athlon kernel: uhci_hcd 0000:00:10.1: port 1 portsc 008a
Mar 27 10:05:05 athlon kernel: hub 2-0:1.0: port 1, status 100, change 3, 
12 Mb/s
Mar 27 10:05:05 athlon kernel: usb 2-1: USB disconnect, address 3
Mar 27 10:05:05 athlon kernel: usb 2-1: usb_disable_device nuking all URBs
Mar 27 10:05:05 athlon kernel: usb 2-1: unregistering interface 2-1:1.0
Mar 27 10:05:05 athlon kernel: drivers/usb/core/usb.c: usb_hotplug
Mar 27 10:05:06 athlon kernel: uhci_hcd 0000:00:10.1: suspend_hc


Afterwards, I plugged in the device again - but the kernel doesn't
recognize it.

Mar 27 10:05:13 athlon kernel: uhci_hcd 0000:00:10.1: wakeup_hc


To do a "soft reboot", I unload all modules regarding usb. All works fine
- but I cannot remove uhci_hcd. The command never comes back. At this
state, the following modules are loaded:

ext2                   45700  1
snd_pcm_oss            49956  0
snd_mixer_oss          17920  1 snd_pcm_oss
snd_via82xx            22144  0
snd_pcm                86692  2 snd_pcm_oss,snd_via82xx
snd_timer              22468  1 snd_pcm
snd_ac97_codec         61380  1 snd_via82xx
snd_page_alloc          9092  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6144  1 snd_via82xx
snd_rawmidi            20960  1 snd_mpu401_uart
snd_seq_device          6792  1 snd_rawmidi
snd                    47268  9
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7328  1 snd
r128                   95472  28
agpgart                26728  0
eepro100               26892  0
sis900                 17156  0
8250                   18528  0
serial_core            20416  1 8250
uhci_hcd               29904  0
usbcore                93532  3 uhci_hcd
lp                      8324  0
ide_cd                 37892  0
cdrom                  38688  1 ide_cd
dm_mod                 38624  6
unix                   23728  266


My only chance to get it working again is a reboot.

This problem does not happen, if the device isn't mounted. Will say: If 
you just plug it in and plug it out again, the device is recognized again 
when plugged in again.


Kind regards,
Andreas Hartmann
