Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272495AbRH3Vph>; Thu, 30 Aug 2001 17:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272492AbRH3Vp1>; Thu, 30 Aug 2001 17:45:27 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:3785 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S272493AbRH3VpR>; Thu, 30 Aug 2001 17:45:17 -0400
Message-ID: <3B8EB3FE.F7FEEAAB@bigfoot.com>
Date: Thu, 30 Aug 2001 14:45:34 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pascal Schmidt <pleasure.and.pain@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: System crashes with via82cxxx ide driver
In-Reply-To: <Pine.LNX.4.33.0108292239410.861-100000@neptune.sol.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How do I know that this is because of the via82cxxx driver? Well, it
> always happens with 2.4.x and this driver enabled. It never happens to me
> with 2.2.19, which has an older driver for this kind of ide controller.
> But when I apply the ide backport patch to 2.2.19, giving me the via82cxxx
> driver on 2.2.19, the machine once again crashes at the same 75.6% of the
> e2fsck run. When I disable the driver in the kernel config, e2fsck does
> not crash the machine. So it's not the newer IDE stuff in general, but
> specifically this driver.

FWIW no problems with this setup:

2.2.20p9, ide.2.2.19.05042001.patch.bz2, e2fsck v1.19.

[tim@abit 2.2]# e2fsck -f -p /dev/hdc4 -C 0
/dev/hdc4: 30/1411488 files (16.7% non-contiguous), 1754402/2819407
blocks     

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:08.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 OHCI Compliant
IEEE-1394 Controller
00:09.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 Model 64
(rev 11)

rgds,
tim


--
