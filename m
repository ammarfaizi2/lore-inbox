Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSLJSeE>; Tue, 10 Dec 2002 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSLJSeE>; Tue, 10 Dec 2002 13:34:04 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:24975 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265236AbSLJSeD>; Tue, 10 Dec 2002 13:34:03 -0500
Message-Id: <4.3.2.7.2.20021210191827.00b53900@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 10 Dec 2002 19:42:07 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.20 AGP for I845 wrong ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From drivers/char/agp/agpgart_be.c
4554,4559
     { PCI_DEVICE_ID_INTEL_845_G_0,
                  PCI_VENDOR_ID_INTEL,
                  INTEL_I845_G,
                  "Intel",
                  "i845G",
                  intel_830mp_setup },

Surely this is wrong or ?
Should be "intel_845_setup", I think.

Which might explain funny messages in th X/DRI/DRM log.

For info, the Intel M/B D845PESV(L) reports as a "G" -
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host 
Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge 
(rev 02)

Also in drivers/char/drm/drm_agpsupport.h, the switch statement at 262 is 
missing the
cases for INTEL_I830_M, INTEL_I845_G.

Margit

