Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbREBKvX>; Wed, 2 May 2001 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbREBKvN>; Wed, 2 May 2001 06:51:13 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:29203 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132563AbREBKvD>; Wed, 2 May 2001 06:51:03 -0400
Date: Wed, 2 May 2001 12:36:19 +0200
To: linux-kernel@vger.kernel.org
Subject: Weird HWaddr with rtl 8139too since 8129 merge?
Message-ID: <20010502123619.A633@timekeeper.cm.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: tstone@t-online.de (Tim Krieglstein)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi 

I just compiled the 2.4.4 release with gcc version 2.95.3 20010315 (Debian release).
After starting up both realtek 8139 network cards (ok they where cheap) won't work.
The source of the problem seems to be the hwaddr of the cards (ifconfig output):
eth0      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF  
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:4294967293 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0xe000 

eth1      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:4294967293 overruns:0 frame:0
          TX packets:0 errors:0 dropped:4 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0xe800 
When booting 2.4.2-ac20 both cards work fine. I looked a bit into the source of the driver, but
there where tons of changes obviusly because of the merge of the 8129 Support, so i didn't look
into this further.

I'll append lspci to give an overview of installed hardware.

Thanks for any help
Tim
-- 
It's a damn poor mind that can only think of one way to spell a word. - Andrew Jackson

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
00:08.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10)

--UlVJffcvxoiEqYs2--
