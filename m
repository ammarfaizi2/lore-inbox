Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWDNM7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWDNM7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 08:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDNM7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 08:59:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51676 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751196AbWDNM7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 08:59:07 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 14 Apr 2006 14:58:35 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 3/4] sbp2: make TSB42AA9 workaround specific to Momobay CX-1
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org, Jody McIntyre <scjody@modernduck.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.2b0bd1ffd757d1b9@s5r6.in-berlin.de>
Message-ID: <tkrat.69177281aa563e69@s5r6.in-berlin.de>
References: <tkrat.c5c36090a52cc591@s5r6.in-berlin.de>
 <tkrat.f5439c0f83c7da87@s5r6.in-berlin.de>
 <tkrat.2b0bd1ffd757d1b9@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.75) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2: make TSB42AA9 workaround specific to Momobay CX-1

The workarounds are not required for DViCO Momobay FX-3A and AFAIR not
for Momobay CX-2. These contain an TSB42AA9A but feature the same
firmware_revision value as the older DViCO Momobay CX-1.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

first posted on 2006-03-19

Index: linux-2.6.17-rc1/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/ieee1394/sbp2.c	2006-04-14 13:20:13.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ieee1394/sbp2.c	2006-04-14 13:20:14.000000000 +0200
@@ -300,8 +300,9 @@ static const struct {
 	u32 model_id;
 	unsigned workarounds;
 } sbp2_workarounds_table[] = {
-	/* TSB42AA9 */ {
+	/* DViCO Momobay CX-1 with TSB42AA9 bridge */ {
 		.firmware_revision	= 0x002800,
+		.model_id		= 0x001010,
 		.workarounds		= SBP2_WORKAROUND_INQUIRY_36 |
 					  SBP2_WORKAROUND_MODE_SENSE_8,
 	},


