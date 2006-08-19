Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWHSM2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWHSM2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 08:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWHSM2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 08:28:13 -0400
Received: from www17.your-server.de ([213.133.104.17]:12300 "EHLO
	www17.your-server.de") by vger.kernel.org with ESMTP
	id S1751739AbWHSM2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 08:28:12 -0400
Message-ID: <44E703D2.6050302@m3y3r.de>
Date: Sat, 19 Aug 2006 14:28:02 +0200
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, akpm@osdl.org
Subject: [PATCH] x86: Fix dmi detection of MacBookPro and iMac
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This commit: 
http://kernel.org/git/?p=linux/kernel/git/gregkh/linux-2.6.git;a=commit;h=b64ef8afa58f397e1eaba2bd9ecaa6812064d464 
contained a wrong DMI_MATCH.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

The error can also be found in this broken out patch: 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/broken-out/add-force-of-use-mmconfig.patch
Please change DMI_BIOS_VERSION into DMI_PRODUCT_NAME

With kind regards
Thomas

diff --git a/drivers/video/imacfb.c b/drivers/video/imacfb.c
index b485bec..a6a0ffd 100644
--- a/drivers/video/imacfb.c
+++ b/drivers/video/imacfb.c
@@ -71,10 +71,10 @@ static int set_system(struct dmi_system_
  static struct dmi_system_id __initdata dmi_system_table[] = {
  	{ set_system, "iMac4,1", {
  	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
-	  DMI_MATCH(DMI_BIOS_VERSION,"iMac4,1") }, (void*)M_I17},
+	  DMI_MATCH(DMI_PRODUCT_NAME,"iMac4,1") }, (void*)M_I17},
  	{ set_system, "MacBookPro1,1", {
  	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
-	  DMI_MATCH(DMI_BIOS_VERSION,"MacBookPro1,1") }, (void*)M_I17},
+	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBookPro1,1") }, (void*)M_I17},
  	{ set_system, "MacBook1,1", {
  	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
  	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook1,1")}, (void *)M_MACBOOK},

