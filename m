Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSKZK2w>; Tue, 26 Nov 2002 05:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSKZK2w>; Tue, 26 Nov 2002 05:28:52 -0500
Received: from math.ut.ee ([193.40.5.125]:4487 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S262506AbSKZK2v>;
	Tue, 26 Nov 2002 05:28:51 -0500
Date: Tue, 26 Nov 2002 12:36:06 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: agpgart & Via VT8605 [PM133] AGP 
Message-ID: <Pine.GSO.4.44.0211261221130.29328-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed Linux on a PIII/733 computer with Via PM133
chipset. Agpgart module loads only when used with agp_try_unsupported=1.
It seems to be stable so far (several 3d screensavers tested for half an
hour and some tracks of tuxracer), Ati R128 DRM. Kernel is 2.4.20-rc3.

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] (rev 81)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP

lspci -n:

00:00.0 Class 0600: 1106:0605 (rev 81)
00:01.0 Class 0604: 1106:8605
00:04.0 Class 0601: 1106:0686 (rev 22)
00:04.1 Class 0101: 1106:0571 (rev 10)
00:04.2 Class 0c03: 1106:3038 (rev 10)
00:04.3 Class 0c03: 1106:3038 (rev 10)
00:04.4 Class 0600: 1106:3057 (rev 30)
00:0e.0 Class 0401: 1274:1371 (rev 08)
00:10.0 Class 0200: 8086:1229 (rev 08)
01:00.0 Class 0300: 1002:5246

>From dmesg:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Trying generic Via routines for device id: 0605
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on VIA @ 0xe4000000 64MB
[drm] Initialized r128 2.2.0 20010917 on minor 0

-- 
Meelis Roos (mroos@linux.ee)

