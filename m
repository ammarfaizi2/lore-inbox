Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWAKN55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWAKN55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWAKN55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:57:57 -0500
Received: from gw.webart.net ([195.30.14.5]:65040 "HELO sombrero.webart.net")
	by vger.kernel.org with SMTP id S1751627AbWAKN54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:57:56 -0500
Message-ID: <43C50ED4.3090707@packetalarm.com>
Date: Wed, 11 Jan 2006 14:57:40 +0100
From: Nils Rennebarth <nils.rennebarth@packetalarm.com>
Organization: Varysys GmbH & Co. KG
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e100 in 2.6.15 fails unless irqpoll ist used
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jan 2006 13:53:25.0647 (UTC) FILETIME=[64BAF1F0:01C616B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

An upgrade from 2.6.14.3 to 2.6.15 on my testmachine disabled my network cards: 
no packets are sent or received.

There is the following in dmesg:

usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
irq 11: nobody cared (try booting with the "irqpoll" option)
  [<c012ae21>] __report_bad_irq+0x31/0x77
  [<c012aef4>] note_interrupt+0x75/0x99
  [<c012a9f0>] __do_IRQ+0x65/0x91
...

Rebooting with irqpoll will make the network cards work. The above message will 
appeare nonetheless.

lspci output:

0000:00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub (rev 04)
0000:00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics 
Controller] (rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 11)
0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 11)
0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 11)
0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 11)
0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 11)
0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 11)
0000:01:00.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
0000:01:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
0000:01:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)

What does irqpoll do?
Any more info needed?


-- 

Mit freundlichen Grüßen / with kind regards

Nils Rennebarth
--
VarySys Technologies GmbH & Co. KG
Moenchhaldenstraße 28
70191 Stuttgart
Germany
Tel +49 711 2501198
Fax +49 711 2501197
mailto:Nils.Rennebarth@packetalarm.com
http://www.packetalarm.com

Download the free software trial version of PacketAlarm now
http://www.packetalarm.com/download/
