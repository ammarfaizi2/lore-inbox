Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUDPO22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDPO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:28:28 -0400
Received: from canalmusic.webnext.com ([213.161.194.17]:57361 "HELO
	www.canalmusic.com") by vger.kernel.org with SMTP id S263214AbUDPO2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:28:25 -0400
Message-ID: <407FED4A.8040307@canalmusic.com>
Date: Fri, 16 Apr 2004 16:27:22 +0200
From: Gilles May <gilles@canalmusic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PDC20376 PATA?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody::

I have got a problem getting my onboard FastTrak 376 Controller to work. 
The motherboard is an Asus A7V8X.

Kernels 2.6.1 to 2.6.5 do detect the controller, but not the harddisk 
connected to it.
During bootup of 2.6.5 stock kernel I get the following:


libata version 1.02 loaded.
sata_promise version 0.91
ata1: SATA max UDMA/133 cmd 0xE0A5F200 ctl 0xE0A5F238 bmdma 0x0 irq 10
ata2: SATA max UDMA/133 cmd 0xE0A5F280 ctl 0xE0A5F2B8 bmdma 0x0 irq 10
ata1: no device found (phy stat 00000000)
ata1: thread exiting
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_promise

I assume it is only trying to detect SATA devices while my HDD is 
connected as PATA.. With Windows it works like a charm.

Do I have to pass some parameters to sata_promise or are there any 
patches to try for the PATA HDD to work?


lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host 
Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46)
0000:00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
0000:00:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T 
(rev 01)
0000:00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 02)
0000:00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 02)
0000:00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235 AC97 Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 
[GeForce4 Ti 4200] (rev a3)

Thanks for your time.

Gilles



-- 
If you don't live for something you'll die for nothing!



