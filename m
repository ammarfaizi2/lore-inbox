Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRDNK1D>; Sat, 14 Apr 2001 06:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRDNK0x>; Sat, 14 Apr 2001 06:26:53 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:37824 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131832AbRDNK0l>;
	Sat, 14 Apr 2001 06:26:41 -0400
Date: Sat, 14 Apr 2001 12:26:40 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200104141026.MAA22602@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: module load/unload race protection?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the kernel's module loader (kernel/module.c, not kmod)
protect adequately against concurrent load/load or load/unload
requests? The question applies to both 2.2 and 2.4 kernels.

I'm trying to track down a problem where a user using a
RedHat 2.2.17-14 SMP kernel managed to trigger a situation where
a driver module had been unloaded while still being in use
(as in "the kernel has pointers into it", not USE_COUNT != 0).
I'm reviewing the driver's internal INC/DEC_USE_COUNT usage,
but so far I've not found any obvious errors.

/Mikael
