Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWBNQCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWBNQCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWBNQCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:02:17 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:38598 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1161088AbWBNQCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:02:16 -0500
Date: Wed, 15 Feb 2006 00:57:53 +0900 (JST)
Message-Id: <20060215.005753.74732581.toriatama@inter7.jp>
To: paulkf@microgate.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Kouji Toriatama <toriatama@inter7.jp>
In-Reply-To: <1139863919.3868.16.camel@amdx2.microgate.com>
References: <20060213.231636.103125334.toriatama@inter7.jp>
	<1139863919.3868.16.camel@amdx2.microgate.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
> On Mon, 2006-02-13 at 23:16 +0900, Kouji Toriatama wrote:
> > I am trying to run pppd with high speed PCMCIA modem on an
> > IBM Thinkpad T41 laptop.  My Linux system is Debian (sarge)
> > with vanilla kernel such as 2.6.15.4.
> 
> What make and model of PCMCIA modem?

I am using Vodafone Connect Card model VC701SI.
Following web page has the product information:
http://www.vodafone.jp/en/data_card/product_info/


> Are any special drivers used?
> (what is output of /proc/modules)

No special drivers are used.  The modem can be controlled by
Hays style AT command.  Following is output of /proc/modules
in kernel 2.6.10.
-------------------------------------------------------------
ppp_async 10624 1 - Live 0xe0b32000
ppp_generic 27540 5 ppp_async, Live 0xe0b7b000
slhc 6912 1 ppp_generic, Live 0xe0b1a000
serial_cs 9628 1 - Live 0xe0b60000
pcmcia 24584 5 serial_cs, Live 0xe0b69000
thermal 13448 0 - Live 0xe0b2d000
fan 4612 0 - Live 0xe0b1d000
button 6800 0 - Live 0xe0b0c000
processor 19756 1 thermal, Live 0xe0b21000
ac 4996 0 - Live 0xe0b0f000
battery 10244 0 - Live 0xe0b02000
ipv6 229120 15 - Live 0xe0ba3000
af_packet 20744 2 - Live 0xe0b13000
irtty_sir 7936 0 - Live 0xe0ac7000
sir_dev 17964 1 irtty_sir, Live 0xe0b06000
irda 167744 2 irtty_sir,sir_dev, Live 0xe0b36000
crc_ccitt 2176 2 ppp_async,irda, Live 0xe09f5000
parport_pc 34372 0 - Live 0xe0ada000
parport 33352 1 parport_pc, Live 0xe0af5000
pcspkr 3688 0 - Live 0xe09f3000
yenta_socket 19584 1 - Live 0xe0ad4000
pcmcia_core 57520 3 serial_cs,pcmcia,yenta_socket, Live 0xe0ae5000
snd_intel8x0m 17220 0 - Live 0xe0ac1000
snd_intel8x0 29856 0 - Live 0xe0acb000
snd_ac97_codec 64608 2 snd_intel8x0m,snd_intel8x0, Live 0xe0a32000
snd_pcm 84744 3 snd_intel8x0m,snd_intel8x0,snd_ac97_codec, Live 0xe0a69000
snd_timer 23300 1 snd_pcm, Live 0xe0a2b000
snd 50276 5 snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer, Live 0xe0a5b000
snd_page_alloc 9604 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xe0a27000
i2c_i801 8076 0 - Live 0xe0870000
i2c_core 21136 1 i2c_i801, Live 0xe09fb000
shpchp 86116 0 - Live 0xe0a44000
pci_hotplug 30512 1 shpchp, Live 0xe0a1e000
intel_agp 20508 1 - Live 0xe098f000
agpgart 31656 1 intel_agp, Live 0xe09ea000
ehci_hcd 29316 0 - Live 0xe09e1000
uhci_hcd 30096 0 - Live 0xe09b7000
usbcore 109688 3 ehci_hcd,uhci_hcd, Live 0xe0a02000
i810_audio 33428 0 - Live 0xe09ad000
ac97_codec 16780 1 i810_audio, Live 0xe0981000
soundcore 9696 2 snd,i810_audio, Live 0xe0862000
e1000 77748 0 - Live 0xe0999000
aes_i586 39028 2 - Live 0xe0881000
dm_crypt 11784 1 - Live 0xe0867000
tsdev 7360 0 - Live 0xe083f000
mousedev 11032 1 - Live 0xe080c000
evdev 9088 0 - Live 0xe083b000
dm_mod 53116 3 dm_crypt, Live 0xe0873000
psmouse 19208 0 - Live 0xe085c000
ide_cd 38276 0 - Live 0xe0851000
cdrom 36380 1 ide_cd, Live 0xe0847000
genrtc 9204 0 - Live 0xe082a000
unix 26036 230 - Live 0xe0833000
-------------------------------------------------------------


> What resources (IO/IRQ) are used by the device
> in 2.6.9 (working) and 2.6.10+ (problem)?

Following is a part of dmesg.  The resources (IO/IRQ) used by
the modem in 2.6.9 and that of 2.6.10 are same.
-------------------------------------------------------------
ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
-------------------------------------------------------------


> What is the output of /proc/interrupts and
> /proc/tty/driver/serial between the two versions?

Output of /proc/interrupts in 2.6.9:
-------------------------------------------------------------
           CPU0       
  0:     294810          XT-PIC  timer
  1:        545          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:        216          XT-PIC  serial
  7:          2          XT-PIC  parport0
  9:         74          XT-PIC  acpi
 11:        174          XT-PIC  Intel ICH4, uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd, Intel 82801DB-ICH4 Modem, yenta, yenta, eth0
 12:       6759          XT-PIC  i8042
 14:       3361          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
-------------------------------------------------------------

Output of /proc/interrupts in 2.6.10:
-------------------------------------------------------------
           CPU0       
  0:     421249          XT-PIC  timer
  1:       1053          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:        501          XT-PIC  serial
  7:          2          XT-PIC  parport0
  9:         77          XT-PIC  acpi
 11:        244          XT-PIC  Intel ICH4, uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd, Intel 82801DB-ICH4 Modem, yenta, yenta, eth0
 12:       7266          XT-PIC  i8042
 14:       3488          XT-PIC  ide0
 15:         11          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
-------------------------------------------------------------

Output of /proc/tty/driver/serial in 2.6.9:
-------------------------------------------------------------
serinfo:1.0 driver revision:
0: uart:NS16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:NS16550A port:000002F8 irq:3 tx:0 rx:0 CTS|DSR
2: uart:16550A port:000003E8 irq:3 tx:1621 rx:13777 RTS|CTS|DTR|DSR|CD
3: uart:unknown port:000002E8 irq:3
4: uart:unknown port:000001A0 irq:9
5: uart:unknown port:000001A8 irq:9
6: uart:unknown port:000001B0 irq:9
7: uart:unknown port:000001B8 irq:9
8: uart:unknown port:000002A0 irq:5
9: uart:unknown port:000002A8 irq:5
10: uart:unknown port:000002B0 irq:5
11: uart:unknown port:000002B8 irq:5
12: uart:unknown port:00000330 irq:4
13: uart:unknown port:00000338 irq:4
14: uart:unknown port:00000000 irq:0
15: uart:unknown port:00000000 irq:0
16: uart:unknown port:00000100 irq:12
17: uart:unknown port:00000108 irq:12
18: uart:unknown port:00000110 irq:12
19: uart:unknown port:00000118 irq:12
20: uart:unknown port:00000120 irq:12
21: uart:unknown port:00000128 irq:12
22: uart:unknown port:00000130 irq:12
23: uart:unknown port:00000138 irq:12
24: uart:unknown port:00000140 irq:12
25: uart:unknown port:00000148 irq:12
26: uart:unknown port:00000150 irq:12
27: uart:unknown port:00000158 irq:12
28: uart:unknown port:00000160 irq:12
29: uart:unknown port:00000168 irq:12
30: uart:unknown port:00000170 irq:12
31: uart:unknown port:00000178 irq:12
32: uart:unknown port:00000302 irq:3
33: uart:unknown port:00000302 irq:3
34: uart:unknown port:00000302 irq:3
35: uart:unknown port:00000302 irq:3
36: uart:unknown port:00000302 irq:3
37: uart:unknown port:00000302 irq:3
38: uart:unknown port:00000302 irq:3
39: uart:unknown port:00000302 irq:3
40: uart:unknown port:00000302 irq:3
41: uart:unknown port:00000302 irq:3
42: uart:unknown port:00000302 irq:3
43: uart:unknown port:00000302 irq:3
44: uart:unknown port:00003220 irq:3
45: uart:unknown port:00003228 irq:3
46: uart:unknown port:00004220 irq:3
47: uart:unknown port:00004228 irq:3
48: uart:unknown port:00005220 irq:3
49: uart:unknown port:00005228 irq:3
50: uart:unknown port:00000000 irq:0
51: uart:unknown port:00000000 irq:0
52: uart:unknown port:00000000 irq:0
53: uart:unknown port:00000000 irq:0
-------------------------------------------------------------

Output of /proc/tty/driver/serial in 2.6.10:
-------------------------------------------------------------
serinfo:1.0 driver revision:
0: uart:NS16550A port:000003F8 irq:4 tx:0 rx:0
1: uart:NS16550A port:000002F8 irq:3 tx:0 rx:0 CTS|DSR
2: uart:16550A port:000003E8 irq:3 tx:3542 rx:49502 RTS|CTS|DTR|DSR|CD
3: uart:unknown port:000002E8 irq:3
4: uart:unknown port:000001A0 irq:9
5: uart:unknown port:000001A8 irq:9
6: uart:unknown port:000001B0 irq:9
7: uart:unknown port:000001B8 irq:9
8: uart:unknown port:000002A0 irq:5
9: uart:unknown port:000002A8 irq:5
10: uart:unknown port:000002B0 irq:5
11: uart:unknown port:000002B8 irq:5
12: uart:unknown port:00000330 irq:4
13: uart:unknown port:00000338 irq:4
14: uart:unknown port:00000000 irq:0
15: uart:unknown port:00000000 irq:0
16: uart:unknown port:00000100 irq:12
17: uart:unknown port:00000108 irq:12
18: uart:unknown port:00000110 irq:12
19: uart:unknown port:00000118 irq:12
20: uart:unknown port:00000120 irq:12
21: uart:unknown port:00000128 irq:12
22: uart:unknown port:00000130 irq:12
23: uart:unknown port:00000138 irq:12
24: uart:unknown port:00000140 irq:12
25: uart:unknown port:00000148 irq:12
26: uart:unknown port:00000150 irq:12
27: uart:unknown port:00000158 irq:12
28: uart:unknown port:00000160 irq:12
29: uart:unknown port:00000168 irq:12
30: uart:unknown port:00000170 irq:12
31: uart:unknown port:00000178 irq:12
32: uart:unknown port:00000302 irq:3
33: uart:unknown port:00000302 irq:3
34: uart:unknown port:00000302 irq:3
35: uart:unknown port:00000302 irq:3
36: uart:unknown port:00000302 irq:3
37: uart:unknown port:00000302 irq:3
38: uart:unknown port:00000302 irq:3
39: uart:unknown port:00000302 irq:3
40: uart:unknown port:00000302 irq:3
41: uart:unknown port:00000302 irq:3
42: uart:unknown port:00000302 irq:3
43: uart:unknown port:00000302 irq:3
44: uart:unknown port:00003220 irq:3
45: uart:unknown port:00003228 irq:3
46: uart:unknown port:00004220 irq:3
47: uart:unknown port:00004228 irq:3
48: uart:unknown port:00005220 irq:3
49: uart:unknown port:00005228 irq:3
50: uart:unknown port:00000000 irq:0
51: uart:unknown port:00000000 irq:0
52: uart:unknown port:00000000 irq:0
53: uart:unknown port:00000000 irq:0
-------------------------------------------------------------


> > The problem is PPP connection through the modem stalls at
> > frequent intervals.  (To be exact, the PPP connection means
> > TCP traffic such as SSH, HTTP.)
> 
> What applications are running and how are you
> determining that there is a stall?
> 
> Does the stall persist until disconnect or
> does data start flowing again after a while?

I run following wget command:
	wget http://www.kernel.org/pub/linux/kernel/README

In kernel 2.6.9, the wget finishes within 5 seconds.  But
kernel 2.6.10, the wget takes about 120 seconds to finish.
Following example shows how to stall.
-------------------------------------------------------------
$ wget http://www.kernel.org/pub/linux/kernel/README
--23:12:00--  http://www.kernel.org/pub/linux/kernel/README                                => `README'
Resolving www.kernel.org... 204.152.191.37
Connecting to www.kernel.org[204.152.191.37]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 12,056 [text/plain]

 0% [                                     ] 0             --.--K/s             
        <stall about 15 seconds>
69% [========================>            ] 8,436        712.80B/s    ETA 00:05
        <stall about 30 seconds>
93% [=================================>   ] 11,332       296.07B/s    ETA 00:02
        <stall about 70 seconds>
100%[====================================>] 12,056       104.26B/s    ETA 00:00

23:14:00 (104.26 B/s) - `README' saved [12056/12056]
-------------------------------------------------------------


> Can you tell if the transmit or receive side
> is stalling (looking at ifconfig stats)?

Following is a status of ppp0 interface when the above wget
command finished.  The count of RX errors, RX bytes and TX
bytes has sometimes increased while stalling.  In kernel
2.6.9, the count of Rx errors was 0.
-------------------------------------------------------------
ppp0      Link encap:Point-to-Point Protocol  
          inet addr:202.179.209.95  P-t-P:172.24.24.22  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:44 errors:18 dropped:0 overruns:0 frame:0
          TX packets:50 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3 
          RX bytes:15992 (15.6 KiB)  TX bytes:2544 (2.4 KiB)
-------------------------------------------------------------


Best regards,
Kouji Toriatama
