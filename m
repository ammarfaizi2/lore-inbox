Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbVKXFyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbVKXFyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbVKXFyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:54:54 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:16259 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030610AbVKXFyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:54:53 -0500
Date: Thu, 24 Nov 2005 05:54:49 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add extra IDs for headphone autosense
Message-ID: <20051124055449.GE28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds some extra IDs for the list of hardware which 
should have headphone line sense enabled by default.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- sound/pci/ac97/ac97_patch.c.orig	2005-11-24 05:51:52 +0000
+++ sound/pci/ac97/ac97_patch.c	2005-11-24 05:52:41 +0000
@@ -1639,8 +1639,12 @@ static void check_ad1981_hp_jack_sense(a
 {
 	u32 subid = ((u32)ac97->subsystem_vendor << 16) | ac97->subsystem_device;
 	switch (subid) {
+	case 0x0e11005a: /* HP nc4000/4010 */
 	case 0x103c0890: /* HP nc6000 */
+	case 0x103c0938: /* HP nc4220 */
 	case 0x103c099c: /* HP nx6110 */
+	case 0x103c0944: /* HP nc6220 */
+	case 0x103c0934: /* HP nc8220 */
 	case 0x103c006d: /* HP nx9105 */
 	case 0x17340088: /* FSC Scenic-W */
 		/* enable headphone jack sense */

-- 
Matthew Garrett | mjg59@srcf.ucam.org
