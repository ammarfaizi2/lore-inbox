Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFOC3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 22:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTFOC3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 22:29:31 -0400
Received: from [211.167.76.68] ([211.167.76.68]:11140 "HELO soulinfo")
	by vger.kernel.org with SMTP id S261222AbTFOC32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 22:29:28 -0400
Date: Sun, 15 Jun 2003 10:43:22 +0800
From: hugang <hugang@soulinfo.com>
To: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Pcmcia GPRS cards not works in linux.
Message-Id: <20030615104322.496279e1.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= dahinds@users.sourceforge.net
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Machine Mode: Dell Latitude V740.
PCMCIA  card: OPTION (GLOBETROTTER)
Kernel      : 2.5.70-mm4 #29 Áù 6ÔÂ 14 18:57:13 CST 2003
Cardctl -V  : cardctl version 3.1.33

The cards is works fine in windows, How can I let it works in linux, Any information is welcome.

Thanks.

--daemon.log---
Jun 15 10:29:48 hugang cardmgr[361]: executing: 'modprobe -r 8250_cs'
Jun 15 10:31:27 hugang cardmgr[361]: exiting
Jun 15 10:31:27 hugang cardmgr[3484]: starting, version is 3.1.33
Jun 15 10:31:27 hugang cardmgr[3484]: watching 1 sockets
Jun 15 10:31:27 hugang cardmgr[3484]: Card Services release does not match
Jun 15 10:31:38 hugang cardmgr[3484]: socket 0: EE828
Jun 15 10:31:39 hugang cardmgr[3484]: executing: 'modprobe 8250_cs'
Jun 15 10:31:40 hugang cardmgr[3484]: get dev info on socket 0 failed: Resource temporarily unavailable
--dmesg---
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
serial_cs: RequestConfiguration: Bad Vcc
---/proc/ioport---
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
1400-14ff : PCI CardBus #03
1800-181f : PCI device 8086:2482
  1800-181f : uhci-hcd
1820-183f : PCI device 8086:2484
  1820-183f : uhci-hcd
1840-184f : PCI device 8086:248a
  1840-1847 : ide0
  1848-184f : ide1
1860-187f : PCI device 8086:2483
1880-18bf : PCI device 8086:2485
  1880-18bf : Intel 82801CA-ICH3 - Controller
1c00-1cff : PCI device 8086:2485
  1c00-1cff : Intel 82801CA-ICH3 - AC'97
2000-207f : PCI device 8086:2486
2400-24ff : PCI device 8086:2486
3000-307f : PCI device 10b7:9200
--/proc/interrupt---
           CPU0       
  0:    6653619          XT-PIC  timer
  1:       6948          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       2162          XT-PIC  uhci-hcd
  8:          3          XT-PIC  rtc
  9:          2          XT-PIC  acpi
 10:         19          XT-PIC  PCI device 1217:6972, uhci-hcd, Intel 82801CA-ICH3
 12:       7191          XT-PIC  i8042
 14:       9436          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
ERR:          0
--dump_cis -vSocket 0:
  offset 0x02, tuple 0x01, link 0x03
    00 00 ff 
  dev_info
    NULL 0ns, 512b

  offset 0x07, tuple 0x1c, link 0x04
    02 00 00 ff 

  offset 0x0d, tuple 0x15, link 0x13
    04 01 45 26 45 00 45 45 38 32 38 00 30 30 31 00 
    41 00 ff 
  vers_1 4.1, "E&E", "EE828", "001", "A"

  offset 0x22, tuple 0x20, link 0x04
    13 00 00 00 
  manfid 0x0013, 0x0000

  offset 0x28, tuple 0x21, link 0x02
    02 00 
  funcid serial_port

  offset 0x2c, tuple 0x22, link 0x04
    00 02 00 18 
  serial_interface
    uart 16550 [8] [1]

  offset 0x32, tuple 0x22, link 0x09
    05 1f 0f 00 03 00 00 03 00 
  serial_modem_cap_data
    flow [XON/XOFF xmit] [XON/XOFF rcv] [hw xmit] [hw rcv] [transparent]
    cmd_buf 64 rcv_buf 768 xmit_buf 768

  offset 0x3d, tuple 0x22, link 0x0d
    02 06 00 2e 04 03 03 0f 07 00 01 b5 ff 
  serial_data_services
    data_rate 115200
    modulation [V.21] [V.23] [V.22] [V.22bis] [V.32]
    error_control [MNP2-4] [V.42/LAPM]
    compression [V.42bis] [MNP5]
    cmd_protocol [AT1] [AT2] [AT3] [MNP_AT]

  offset 0x4c, tuple 0x1a, link 0x05
    01 31 00 04 01 
  config base 0x0400 mask 0x0001 last_index 0x31

  offset 0x53, tuple 0x1b, link 0x0a
    f0 01 19 01 b5 1e 24 30 ff ff 
  cftable_entry 0x30 [default]
    Vcc Vnom 3300mV
    io 0x0000-0x000f [lines=4] [8bit]
    irq mask 0xffff [level]

  offset 0x5f, tuple 0x1b, link 0x09
    f1 01 19 01 55 24 30 ff ff 
  cftable_entry 0x31 [default]
    Vcc Vnom 5V
    io 0x0000-0x000f [lines=4] [8bit]
    irq mask 0xffff [level]

  offset 0x6a, tuple 0x14, link 0x00
  no_long_link

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
