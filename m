Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWC2QoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWC2QoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 11:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWC2QoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 11:44:09 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:6062 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1750832AbWC2QoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 11:44:08 -0500
Date: Wed, 29 Mar 2006 18:44:02 +0200
From: Frank Gevaerts <frank@gevaerts.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-rc4] hdaps: add support for Thinkpad R52
Message-ID: <20060329164402.GA19770@gevaerts.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060314205758.GA9...@gevaerts.be> <20060325210946.GZ4053@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325210946.GZ4053@stusta.de>
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.9i
X-gevaerts-MailScanner: Found to be clean
X-MailScanner-From: fg@gevaerts.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for my Thinkpad R52, which for some reason is not
matched by the "ThinkPad R52" line.

Signed-off-by: Frank Gevaerts <frank@gevaerts.be>

diff -ur linux-2.6.16-rc4/drivers/hwmon/hdaps.c linux-2.6.16-rc4-fg/drivers/hwmon/hdaps.c
--- linux-2.6.16-rc4/drivers/hwmon/hdaps.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-fg/drivers/hwmon/hdaps.c	2006-02-24 13:25:53.000000000 +0100
@@ -515,6 +515,7 @@
 
 	/* Note that DMI_MATCH(...,"ThinkPad T42") will match "ThinkPad T42p" */
 	struct dmi_system_id hdaps_whitelist[] = {
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),
