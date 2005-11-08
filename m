Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965628AbVKHAUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965628AbVKHAUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965629AbVKHAUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:20:12 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:6566 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965628AbVKHAUK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:20:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A/oTLWBVhBaw2PMce/NjXmcCaS0JkRmORyLJF5LU22OZwz2tBKYuQFI5w9BGGolY/dlWOwlj1wWhCJADh3mmfzVIonIUO3Lxj6teVc5uiQNjvRf3l0eC8TQrEWOI1cBHIZIUgLsAM1TfQOed3OozCr1Vp+nsLyZlWmwYhW6os4k=
Message-ID: <5bdc1c8b0511071620o2032c85crd45a4777aae4b971@mail.gmail.com>
Date: Mon, 7 Nov 2005 16:20:09 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: NVidia nForce4 + AMD Athlon64 X2 --> no access to north-bridge PCI resources
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051107225755.GE5706@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051107225755.GE5706@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
>
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

Interesting. Here's another NForce4 from Asus - A8N-E. It does not
show the problem you observe:

lightning ~ # lspci
0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory
Controller (rev a3)
0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804
AC'97 Audio Controller (rev a2)
0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA
Controller (rev f3)
0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
Controller (rev f3)
0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV370
5B60 [Radeon X300 (PCIE)]
0000:01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
0000:05:06.0 Multimedia audio controller: Xilinx Corporation RME
Hammerfall DSP (rev 68)
0000:05:08.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2
IEEE-1394b Link Layer Controller (rev 01)
lightning ~ #

- Mark
