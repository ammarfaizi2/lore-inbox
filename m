Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUIVHnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUIVHnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIVHnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:43:41 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:16396 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S261426AbUIVHlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:41:47 -0400
Subject: Re: Help on CardBus Bridge...
From: Norbert van Nobelen <Norbert@edusupport.nl>
To: todd nguyen <toddnguyen@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040922045302.39084.qmail@web11206.mail.yahoo.com>
References: <20040922045302.39084.qmail@web11206.mail.yahoo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095838905.4616.9.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Sep 2004 09:41:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remark "we suck" in the log is not a hint yet?
It looks like the implementation for this device is not completed.

On Wed, 2004-09-22 at 06:53, todd nguyen wrote:
> Hello,  
> I have a little problem with the CardBus Bridge that
> we bought recently.  When Linux bootup, the OS see all
> the devices after the CardBus twice.  For example, we
> have only 1 device called "VIS16" after the CardBus
> but the the "lspci" display twice. Does anyone have
> any idea why?  Also, dmesg showed some conflict in the
> bus segment which has the "VIS16" device.  Please let
> me know if you need more information.
> 
> Thanks in advance,
> Todd Nguyen
> 
> ===============Kernel version==========
> 
>  Linux winter-lnx 2.4.21-4.0.1.EL #1 Thu Oct 23
> 01:36:33 EDT 2003 i686 unknown unknown GNU/Linux
> 
> ================lspci=================
> 00:00.0 Host bridge: Intel Corp.: Unknown device 3340
> (rev 03)
> 00:01.0 PCI bridge: Intel Corp.: Unknown device 3341
> (rev 03)
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub
> #1) (rev 01)
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub
> #2) (rev 01)
> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub
> #3) (rev 01)
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI
> Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI
> Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc
> (rev 01)
> 00:1f.1 IDE interface: Intel Corp.: Unknown device
> 24ca (rev 01)
> 00:1f.5 Multimedia audio controller: Intel Corp.
> 82801DB AC'97 Audio (rev 01)
> 01:00.0 VGA compatible controller: ATI Technologies
> Inc: Unknown device 4c66 (rev 02)
> 02:00.0 Ethernet controller: BROADCOM Corporation:
> Unknown device 165d (rev 01)
> 02:01.0 CardBus bridge: O2 Micro, Inc.: Unknown device
> 7113 (rev 20)
> 02:01.1 CardBus bridge: O2 Micro, Inc.: Unknown device
> 7113 (rev 20)
> 02:03.0 Network controller: BROADCOM Corporation:
> Unknown device 4320 (rev 02)
> 03:00.0 PCI bridge: Unknown device 9902:0001 (rev 02)
> 03:00.1 Bridge: Unknown device 9902:0002 (rev 02)
> 04:00.0 PCI bridge: Unknown device 9902:0003 (rev 01)
> 04:00.0 PCI bridge: Unknown device 9902:0003 (rev 01)
> 05:01.0 PCI bridge: Unknown device 9902:0001 (rev 02)
> 05:01.0 PCI bridge: Unknown device 9902:0001 (rev 02)
> 05:02.0 PCI bridge: Unknown device 9902:0001 (rev 02)
> 05:02.0 PCI bridge: Unknown device 9902:0001 (rev 02)
> 06:0d.0 Diamond Instrument: Todd System, Corp. VIS16 
> (rev ad)
> 06:0d.0 Diamond Instrument: Todd System, Corp. VIS16 
> (rev ad)
> 06:1f.0 Bridge: Unknown device 9902:0002 (rev 02)
> 06:1f.0 Bridge: Unknown device 9902:0002 (rev 02)
> ====================================================
> 
> =================dmesg==============================
> cs: cb_alloc(bus 3): vendor 0x9902, device 0x0001
> Cardbus: Bridge found - we suck.
> Allocating for type 101, in bus resource.
> Allocating for type 200, in bus resource.
> Allocating for type 1200, in bus resource.
> PCI: Cannot allocate resource region 9 of bridge
> 03:00.0
> Scanning behind PCI bridge 03:00.0, config 000000
> Scanning bus 04
> Fixups for bus 04
> Scanning behind PCI bridge 04:00.0, config 000000
> Scanning bus 05
> Fixups for bus 05
> Scanning behind PCI bridge 05:01.0, config 000000
> Scanning bus 06
> Fixups for bus 06
> PCI: Failed to allocate resource 0(0-1ff) for 06:0f.0
> PCI: Failed to allocate resource 1(1000-fff) for
> 06:0f.0
> PCI: Failed to allocate resource 2(0-1fffff) for
> 06:0f.0
> PCI: Device 06:0f.0 not available because of resource
> collisions
> PCI: Failed to allocate resource 0(0-7fff) for 06:1f.0
> PCI: Failed to allocate resource 1(1000-fff) for
> 06:1f.0
> PCI: Device 06:1f.0 not available because of resource
> collisions
> Bus scan for 06 returning with max=06
> Scanning behind PCI bridge 05:02.0, config 000000
> ================================================
> 
> 
> 
> 		
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail Address AutoComplete - You start. We finish.
> http://promotions.yahoo.com/new_mail
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Met vriendelijke groet,

Norbert van Nobelen
EduSupport

Postbus 95963
2509CZ Den Haag
T: 070-3280200
M: 06-43036586
F: 070-3280029
E: Norbert@edusupport.nl
I: www.edusupport.nl
B: ABN AMRO
R: 47.38.00.411

