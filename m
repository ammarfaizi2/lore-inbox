Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWAJSly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWAJSly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:41:54 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:45192 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751179AbWAJSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:41:52 -0500
Message-ID: <43C3FFE2.1040401@ens-lyon.org>
Date: Tue, 10 Jan 2006 13:41:38 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] add DRM support for Radeon X600
Content-Type: multipart/mixed;
 boundary="------------050507000305030900040102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507000305030900040102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Andrew,

Now that Xorg 6.9/7.0 has been released, DRI is supported on more Radeon
cards without ATI proprietary drivers. I got my X300 to work  without
problem. But, another Radeon X600 required to add its PCI ids to the
Radeon driver. Patch is attached.
I can't be sure about the "CHIP_RV350", I copied it from the X300 entry
(from http://dri.freedesktop.org/wiki/ATIRadeon, X600 is a rv380 chip
while X300 is a rv370). But, at least it works now.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Thanks,
Brice


--------------050507000305030900040102
Content-Type: text/x-patch;
 name="add_radeon_x600_to_drm_radeon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_radeon_x600_to_drm_radeon.patch"

--- linux-2.6.15/drivers/char/drm/drm_pciids.h.old	2006-01-10 13:23:34.000000000 -0500
+++ linux-2.6.15/drivers/char/drm/drm_pciids.h	2006-01-10 13:24:35.000000000 -0500
@@ -3,6 +3,7 @@
    Please contact dri-devel@lists.sf.net to add new cards to this list
 */
 #define radeon_PCI_IDS \
+	{0x1002, 0x3150, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350}, \
 	{0x1002, 0x4136, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS100|CHIP_IS_IGP}, \
 	{0x1002, 0x4137, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|CHIP_IS_IGP}, \
 	{0x1002, 0x4144, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \

--------------050507000305030900040102--
