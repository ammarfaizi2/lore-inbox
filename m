Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVKHCnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVKHCnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVKHCnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:43:43 -0500
Received: from quark.didntduck.org ([69.55.226.66]:64187 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965004AbVKHCnm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:43:42 -0500
Message-ID: <43701166.1010705@didntduck.org>
Date: Mon, 07 Nov 2005 21:45:58 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: NVidia nForce4 + AMD Athlon64 X2 --> no access to north-bridge
 PCI resources
References: <20051107225755.GE5706@mea-ext.zmailer.org>
In-Reply-To: <20051107225755.GE5706@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> The _very_short_ view of  lspci  output on a problem machine:
> 
> 00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
> 00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
> 00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
> 00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
> 00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
> 00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
> 00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
> 00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> 00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> 00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> 00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> 01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2)
> 05:06.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394 Controller
> 05:07.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
> 05:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
> 05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
> 
> This problem machine is  ASUS A8N-SLI Premium 
> AMD CPU family/model/stepping: 15/35/2
> 
> The question is:
> 
>   Where are "host bridge" subsystem things in this new
>   ASUS board with NVidia nForce4 ?
> 

I see a similar scenario on a Gigabyte GA-K8NF-9 board:

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a2)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 
Audio Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a2)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a2)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a2)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a2)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a2)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a2)
01:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
01:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
01:0a.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link 
Layer Controller (rev 01)
05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 
GT] (rev a2)

Maybe it's a BIOS thing, like how some hide the SMBus interface?

--
					Brian Gerst
