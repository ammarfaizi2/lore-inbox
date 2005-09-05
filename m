Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVIEKKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVIEKKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 06:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVIEKKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 06:10:51 -0400
Received: from barad-dur.crans.org ([138.231.141.187]:44954 "EHLO
	barad-dur.minas-morgul.org") by vger.kernel.org with ESMTP
	id S1750742AbVIEKKu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 06:10:50 -0400
From: "Mathieu" <matt@minas-morgul.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Brand-new notebook useless with Linux...
References: <200509031859_MC3-1-A720-F705@compuserve.com>
X-PGP-KeyID: 0x2E13FCA8
X-PGP-Fingerprint: D41C FC4F 7374 D3FA A121 9182 90AC 62B0 2E13 FCA8
Date: Mon, 05 Sep 2005 12:10:51 +0200
In-Reply-To: <200509031859_MC3-1-A720-F705@compuserve.com> (Chuck Ebbert's
	message of "Sat, 3 Sep 2005 18:58:00 -0400")
Message-ID: <87psrn6d04.fsf@barad-dur.minas-morgul.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> disait dernièrement que :

> I just bought a new notebook.  Here is the output from lspci using the latest
> pci.ids file from sourceforge:

I have got the same machine or so and it runs nicely a linux kernel.

> 00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
> 00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f
> 00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
> 00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
> 00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI
> 00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
> 00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
> 00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400
> AC'97 Audio Controller (rev 02)

snd-ati-ixp or snd-ati-ixp-modem

> 00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 02)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 01:05.0 VGA compatible controller: ATI Technologies Inc ATI Radeon
> XPRESS 200M 5955 (PCIE)
no 3d for now, or maybe in Dave Airlie's latest drm tree which seems
to have r300 in it. But to have X actually use it, you need the latest
cvs from X.org and Mesa 6.x

> 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 05:02.0 Network controller: Broadcom Corporation BCM4318 [AirForce
> One 54g] 802.11g Wireless LAN Controller (rev 02)

it is a mini pci card. take it away and put an ipw2200 in here (beware
of the killswitch if it is an ACER)

> 05:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
> 05:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller
> 05:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
> 05:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller0

as mentioned in another

> None of these work and I can find no support anywhere for them:
>
> SMBus

the bioses released by phoenix seem a little broken. try a 2.6.13
kernel with the option ec_burst=1.

> Audio ("unknown codec")
> Modem ("no codec available")
> Wireless
> FlashMedia
> SD/MMC
>
> Additionally, the system clock runs at 2x normal speed with PowerNow enabled.

> Am I stuck with running XP on this thing?

I do not think so :)

another problem is the Synaptics device, which does not seem to come
up if the framebuffer is used....

-- 
Mathieu
