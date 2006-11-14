Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbWKNMeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWKNMeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965541AbWKNMeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:34:17 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:34540 "EHLO
	torres.zugschlus.de") by vger.kernel.org with ESMTP id S965290AbWKNMeQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:34:16 -0500
Date: Tue, 14 Nov 2006 13:34:15 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061114123415.GA10984@torres.l21.ma.zugschlus.de>
References: <20061111114352.GA9206@torres.l21.ma.zugschlus.de> <20061111115016.GA24112@flint.arm.linux.org.uk> <20061111123455.GB9206@torres.l21.ma.zugschlus.de> <20061111153005.GA28277@flint.arm.linux.org.uk> <20061111130656.c9bae39f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111130656.c9bae39f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 01:06:56PM -0800, Andrew Morton wrote:
> /proc/ioports and /proc/iomem might contain hints - can we see those please?

Sure:
$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0130-0137 : smsc-ircc2
01f0-01f7 : ide0
02f8-02ff : smsc-ircc2
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0d
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : ACPI PM1a_EVT_BLK
    1004-1005 : ACPI PM1a_CNT_BLK
    1008-100b : ACPI PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : ACPI PM2_CNT_BLK
    1028-102f : ACPI GPE0_BLK
1100-113f : 0000:00:1f.0
  1100-113f : motherboard
    1100-113f : pnp 00:0d
1200-121f : 0000:00:1f.3
  1200-121f : motherboard
    1200-121f : pnp 00:0d
      1200-121f : i801_smbus
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:00.0
3000-30ff : 0000:00:1f.5
  3000-30ff : Intel 82801DB-ICH4
3400-34ff : 0000:00:1f.6
  3400-34ff : Intel 82801DB-ICH4 Modem
3800-387f : 0000:00:1f.6
  3800-387f : Intel 82801DB-ICH4 Modem
3880-38bf : 0000:00:1f.5
  3880-38bf : Intel 82801DB-ICH4
38c0-38df : 0000:00:1d.0
  38c0-38df : uhci_hcd
38e0-38ff : 0000:00:1d.1
  38e0-38ff : uhci_hcd
3c00-3c1f : 0000:00:1d.2
  3c00-3c1f : uhci_hcd
3c20-3c2f : 0000:00:1f.1
  3c20-3c27 : ide0
  3c28-3c2f : ide1
4000-5fff : PCI Bus #02
  4000-40ff : PCI CardBus #03
  4400-44ff : PCI CardBus #03
  4800-48ff : PCI CardBus #05
  4c00-4cff : PCI CardBus #05
  5000-50ff : PCI CardBus #09
  5400-54ff : PCI CardBus #09
$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffcffff : System RAM
  00100000-0037dada : Kernel code
  0037dadb-003fd087 : Kernel data
3ffd0000-3fff0bff : reserved
3fff0c00-3fffbfff : ACPI Non-volatile Storage
3fffc000-3fffffff : reserved
50000000-56ffffff : PCI Bus #02
  50000000-51ffffff : PCI CardBus #03
  52000000-53ffffff : PCI CardBus #05
  54000000-55ffffff : PCI CardBus #09
  56000000-5600ffff : 0000:02:0e.0
57000000-570003ff : 0000:00:1f.1
58000000-59ffffff : PCI CardBus #03
5a000000-5bffffff : PCI CardBus #05
5c000000-5dffffff : PCI CardBus #09
90000000-903fffff : PCI Bus #02
  90000000-9000ffff : 0000:02:0e.0
    90000000-9000ffff : tg3
  90080000-90083fff : 0000:02:0d.0
  90100000-90100fff : 0000:02:04.0
    90100000-90100fff : ipw2200
  90180000-90180fff : 0000:02:06.0
    90180000-90180fff : yenta_socket
  90200000-90200fff : 0000:02:06.1
    90200000-90200fff : yenta_socket
  90280000-90280fff : 0000:02:06.2
  90300000-90300fff : 0000:02:06.3
    90300000-90300fff : yenta_socket
  90380000-903807ff : 0000:02:0d.0
    90380000-903807ff : ohci1394
90400000-904fffff : PCI Bus #01
  90400000-9040ffff : 0000:01:00.0
  90420000-9043ffff : 0000:01:00.0
98000000-9fffffff : PCI Bus #01
  98000000-9fffffff : 0000:01:00.0
a0000000-a00003ff : 0000:00:1d.7
  a0000000-a00003ff : ehci_hcd
a0100000-a01001ff : 0000:00:1f.5
  a0100000-a01001ff : Intel 82801DB-ICH4
a0180000-a01800ff : 0000:00:1f.5
  a0180000-a01800ff : Intel 82801DB-ICH4
b0000000-bfffffff : 0000:00:00.0
$

I now suspect a user space issue, since the port is there and
functional when I boot with init=/bin/sh. I'll see what udev is doing
with my resources.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
