Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUIAFFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUIAFFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUIAFFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:05:34 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:15249 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S268381AbUIAFEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:04:04 -0400
Message-ID: <41355813.6060304@nodivisions.com>
Date: Wed, 01 Sep 2004 01:03:15 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: devfsd stuck in D state
References: <41353913.70102@nodivisions.com> <20040831214554.03fe70e7.akpm@osdl.org>
In-Reply-To: <20040831214554.03fe70e7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>I'm running devfs v1.22 on this Gentoo system:
>>
>>
>> Linux soma 2.6.3 #8 Thu Jun 10 00:17:31 EDT 2004 i686 Pentium III 
>> (Coppermine) GenuineIntel GNU/Linux
>>
>>
>> ...and I just unplugged my USB memory-stick reader.  That apparently caused 
>> devfsd to go into "D" state (uninterruptible sleep, right?):
>>
>>
>> root       118  0.0  0.1  1832  924 ?        D    Aug27   0:01 /sbin/devfsd /dev
>>
>>
>> ...and it won't come back.  CPU is idle, but load is:
>>
>>
>> load average: 52.90, 51.41, 49.48
>>
>>
>> ...and now some weird stuff is happening, for example man doesn't work, and 
>> ps works but doesn't return.  (top works, vmstat works...)
>>
>> killall -HUP devfsd doesn't do anything.
>>
>> Is it possible to fix this without rebooting?
> 
> 
> Probably not.
> 
> Please do
> 
> 	dmesg -c
> 	echo t > /proc/sysrq-trigger
> 	dmesg -s 1000000 > foo
> 
> then send us foo.  Then reboot.

I don't have /proc/sysrq-trigger, and the second dmesg command gives no 
output.  The output of dmesg -c is below if that helps at all.

Thanks,
Anthony
http://nodivisions.com/


[0049][~]# dmesg -c
: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
usb 1-1: USB disconnect, address 5
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: removed
usb 1-1: new full speed USB device using address 6
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 6 if 0 alt 
1 proto 2 vid 0x03F0 pid 0x1204
drivers/usb/class/usblp.c: usblp0: out of paper
drivers/usb/class/usblp.c: usblp0: ok
bttv0: PLL can sleep, using XTAL (28636363).
tuner: TV freq (268435455.93) out of range (44-958)
bttv0: timeout: irq=38/38, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=295/295, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=295/295, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=295/295, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=295/295, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=310/310, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=310/310, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=313/313, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=318/318, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=318/318, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=325/325, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=328/328, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=334/334, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=334/334, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=334/334, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=411/411, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=415/415, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=418/418, risc=2877803c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=418/418, risc=2877803c, bits: HSYNC OFLOW
bttv0: unloading
Linux video capture interface: v1.00
bttv: Unknown parameter `btcx_risc'
bttv: Unknown parameter `btcx_risc'
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 10, latency: 32, mmio: 0xfd006000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffebff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: pinnacle/mt: id=6 info="NTSC / stereo" radio=no
bttv0: using tuner=33
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3425G-B8 +nicam +simple +radio
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
msp3410: daemon started
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
tda9887: chip found @ 0x86
tuner: chip found @ 0xc0
tuner: type set to 33 (MT20xx universal)
tuner: microtune: companycode=4d54 part=04 rev=04
tuner: microtune MT2032 found, OK
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: PLL can sleep, using XTAL (28636363).
tuner: TV freq (268435455.93) out of range (44-958)
bttv0: timeout: irq=1760/1760, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1824/1824, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1829/1829, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1830/1830, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1830/1830, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1831/1831, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1831/1831, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1831/1831, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1831/1831, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1833/1833, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1833/1833, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1833/1833, risc=0b8c203c, bits: HSYNC OFLOW
bttv0: reset, reinitialize
bttv0: PLL can sleep, using XTAL (28636363).
bttv0: timeout: irq=1833/1833, risc=0b8c203c, bits: HSYNC OFLOW
process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
process `host' is using obsolete setsockopt SO_BSDCOMPAT
process `dig' is using obsolete setsockopt SO_BSDCOMPAT
usb 1-2: new full speed USB device using address 7
scsi3 : SCSI emulation for USB Mass Storage devices
   Vendor:           Model: MS Reader         Rev: 1.05
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi3, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 7
ieee1394: Node 0-00:1023 has non-standard ROM format (0 quads), cannot parse
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: The root node is not cycle master capable; selecting a new root 
node and resetting...
ieee1394: Node 0-00:1023 has non-standard ROM format (0 quads), cannot parse
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c501e0000bf1]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
   Vendor: WDC WD25  Model: 00JB-00EVA0       Rev:
   Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
  /dev/scsi/host2/bus0/target0/lun0: p1 p2
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
ieee1394: Node 0-00:1023 has non-standard ROM format (0 quads), cannot parse
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect timed-out
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
ieee1394: sbp2: sbp2_reconnect_device failed!
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[0050c501e0000bf1]
ieee1394: Node 0-00:1023 has non-standard ROM format (0 quads), cannot parse
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c501e0000bf1]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
   Vendor: WDC WD25  Model: 00JB-00EVA0       Rev:
   Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
  /dev/scsi/host2/bus0/target0/lun0: p1 p2
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
usb 1-2: USB disconnect, address 7
usb 1-2: new full speed USB device using address 8
scsi4 : SCSI emulation for USB Mass Storage devices
   Vendor:           Model: MS Reader         Rev: 1.05
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 8
usb 1-2: USB disconnect, address 8
ieee1394: Node 0-00:1023 has non-standard ROM format (0 quads), cannot parse
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect timed-out
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
ieee1394: sbp2: sbp2_reconnect_device failed!
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[0050c501e0000bf1]
drivers/usb/core/usb.c: deregistering driver usb-storage
drivers/usb/core/usb.c: deregistering driver usblp
drivers/usb/class/usblp.c: usblp0: removed
uhci_hcd 0000:00:07.2: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-1: USB disconnect, address 6
uhci_hcd 0000:00:07.2: USB bus 1 deregistered
uhci_hcd 0000:00:07.3: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:07.3: USB bus 2 deregistered
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
[0050][~]#
