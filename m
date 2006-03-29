Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWC2N5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWC2N5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWC2N5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:57:55 -0500
Received: from wproxy.gmail.com ([64.233.184.237]:17001 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbWC2N5z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:57:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pEqUyTo58BWS8mkGElzYSKtxCfE7gQjUlf1SVR/S9hFUdkUwnxNZJTe5A39RsCC+XeVidckt2NnovLXtGx0D7qT99q2WMAF9KFb2hXp6c608bJMKuKetuAWtQ+jcnWKKEtkgpHCggjBuIiBcQr+fKmw0Pyg74HI1p2vVGtXqs+E=
Message-ID: <194f62550603290557v71415cedw9e565d8c59d7630b@mail.gmail.com>
Date: Wed, 29 Mar 2006 15:57:53 +0200
From: "Clemens Eisserer" <linuxhippy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with SiS 7018 sound chipset
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope I don't bother you too much, I thought a long time wether I
should report this at all but well, as an AC/DC fan I can't live
without my soundcard ;)

I own a laptop with a sis7018 sound-chipset and I am running FC4
updated to kernel Linux cehost 2.6.15-1.1831_FC4 (not compiled
myself).
I never had problems with my soundcard at all but some time ago it
suddely stopped to work. I can't remember wether it was a
kernel-update or a motherboard exchange made by service engineers.

Whenever an application tries to access the sound-device I get
messages like the following on syslog:
codec_write 0: semaphore is not ready for register 0x2c
the same again and again, but different registers: 0x2c, 0x2a 0x2c
0x2c 0x2c 0x2c 0x3a 0x2a

When booting up I get a strange message from the pci subsystem:
PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
booting with pci=noacpi did not help or change the situation.

this is the output I get from lspci:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 645xx (rev 03)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL
Media IO] (rev 14)
00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS]
FireWire Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
PCI Fast Ethernet (rev 90)
00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
01:00.0 VGA compatible controller: nVidia Corporation NV18M [GeForce4
488 Go] (rev a2)

I hope somebody reads this, if not the life will go on ;)

Thanks for making linux-2.6 such great, lg Clemens
