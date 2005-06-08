Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVFHIMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVFHIMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 04:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVFHIMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 04:12:35 -0400
Received: from [24.199.11.214] ([24.199.11.214]:17642 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262138AbVFHIMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 04:12:31 -0400
Message-ID: <42A64556.4060405@cyte.com>
Date: Tue, 07 Jun 2005 18:09:42 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: amd64 cdrom access locks system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having this problem in 2.6.12-rc2 and 2.6.12-rc6.

Any continued access to /dev/hda causes a complete and total
lock up of the system. Nothing is logged to /var/log/kernel
or /var/log/messages. Just a solid freeze.

This happens with at least cdparanoia and cdrecord as well.

The machine is an AMD64 FX55 CPU running in a shuttle
ST20G5 chassis.

The specs for the chipset say:
   ATi RADEON XPRESS 200 + ULi 1573 chipset

lspci produces (but doesn't say anything about the spec'ed chips):
0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950 (rev 01)
0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f
0000:00:06.0 PCI bridge: ATI Technologies Inc: Unknown device 5a38
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
0000:00:1c.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:1c.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:1c.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:1c.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
0000:00:1d.0 0403: ALi Corporation: Unknown device 5461
0000:00:1e.0 ISA bridge: ALi Corporation: Unknown device 1573 (rev 31)
0000:00:1e.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
0000:00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
0000:00:1f.1 RAID bus controller: ALi Corporation: Unknown device 5287 
(rev 02)
0000:01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown 
device 5954
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 
Gigabit Ethernet PCI Express (rev 01)
0000:03:15.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:03:16.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O 
Controller(rev 01)

Any ideas? I would really like to see this go away before 2.6.12
comes out. But it's been present for quite a while.

-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)

