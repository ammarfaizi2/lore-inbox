Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWJAMCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWJAMCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWJAMCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:02:17 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:58324 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932097AbWJAMCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:02:15 -0400
Message-ID: <451FAE45.703@arcor.de>
Date: Sun, 01 Oct 2006 14:02:13 +0200
From: Stephan Berberig <s.berberig@arcor.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hdaps: remove duplicate whitelist entry and add ThinkPad
 R52 (1847W62)
Content-Type: multipart/mixed;
 boundary="------------050403050404040606080808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403050404040606080808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

the attached patch removes a duplicate whitelist entry for the "ThinkPad
H" and adds the "strange" DMI for the ThinkPad R52 (1847W62).

BTW, The strange DMIs for the ThinkPad R52 1846AQG and 1847W62 are fixed
in latest BIOS. See http://www.thinkwiki.org/wiki/List_of_DMI_IDs#R_series

Best regards,
Stephan

PS: Please CC me as I'm not subscribed to the list. Thanks!

--------------050403050404040606080808
Content-Type: text/x-patch;
 name="hdaps-for-2.6.18-git15.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdaps-for-2.6.18-git15.patch"

--- linux-2.6.18-git15/drivers/hwmon/hdaps.c.orig	2006-10-01 13:49:03.000000000 +0200
+++ linux-2.6.18-git15/drivers/hwmon/hdaps.c	2006-10-01 13:50:12.000000000 +0200
@@ -525,12 +525,12 @@
 	/* Note that HDAPS_DMI_MATCH_NORMAL("ThinkPad T42") would match
 	  "ThinkPad T42p", so the order of the entries matters */
 	struct dmi_system_id hdaps_whitelist[] = {
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R52"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),	 /* R52 (1846AQG) */
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad ."),	 /* R52 (1847W62) */
 		HDAPS_DMI_MATCH_INVERT("ThinkPad T41p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T41"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad T42p"),

--------------050403050404040606080808--
