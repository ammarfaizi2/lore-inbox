Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSJDL0E>; Fri, 4 Oct 2002 07:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJDL0E>; Fri, 4 Oct 2002 07:26:04 -0400
Received: from mail.spylog.com ([194.67.35.220]:30933 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S261556AbSJDL0C>;
	Fri, 4 Oct 2002 07:26:02 -0400
Date: Fri, 4 Oct 2002 15:31:28 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: NIC on Intel STL2 - bad work with eepro100 & e100
Message-ID: <20021004113128.GA31145@an.local>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux.nics@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.


1. Hardware:
			Intel Server Board STL2.
      Network: onboard NIC "Intel(R) 82559 single chip PCI LAN controller"

   Software: 
			Linux kernel up-to version 2.4.20pre9 + arp hidden patch.


2. dmesg:

...
Intel(R) PRO/100 Network Driver - version 2.1.15-k1
Copyright (c) 2002 Intel Corporation

e100: hw init failed
e100: Failed to initialize, instance #0
...


3. cat /proc/pci

...
  Bus  0, device   3, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
      IRQ 18.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfb101000 [0xfb101fff].
      I/O at 0x5400 [0x543f].
      Non-prefetchable 32 bit memory at 0xfb000000 [0xfb0fffff].
...


ps. eepro100 driver work, but bad.

dmesg:
...
<4>eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
<4>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.s
<6>eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:B6:B2:8B, IRQ 18.
<6>  Board assembly 000000-000, Physical connectors present: RJ45
<6>  Primary interface chip i82555 PHY #1.
<6>  General self-test: passed.
<6>  Serial sub-system self-test: passed.
<6>  Internal registers self-test: passed.
<6>  ROM checksum self-test: passed (0x04f4518b).
...
...
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
...

And periodically freeze.



-- 
bye.
Andrey Nekrasov, SpyLOG.
