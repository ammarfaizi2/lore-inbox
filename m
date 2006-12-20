Return-Path: <linux-kernel-owner+w=401wt.eu-S964886AbWLTE4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWLTE4X (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWLTE4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:56:22 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:49882 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964886AbWLTE4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:56:20 -0500
Date: Wed, 20 Dec 2006 04:56:12 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061220045612.GB20234@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191919.36813.david-b@pacbell.net> <20061220034315.GA19440@srcf.ucam.org> <200612192015.14587.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612192015.14587.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: [PATCH 2/2] Update feature-removal-schedule.txt
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm_has_noirq_stage to feature-removal-schedule as part of the 
/sys/devices/.../power/state removal. Also note that this functionality 
won't be removed until alternative functionality is implemented, in 
order to avoid having this argument again in July.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 30f3c8c..8a91689 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -9,7 +9,8 @@ be removed from this file.
 What:	/sys/devices/.../power/state
 	dev->power.power_state
 	dpm_runtime_{suspend,resume)()
-When:	July 2007
+	bus->pm_has_noirq_stage()
+When:	Once alternative functionality has been implemented
 Why:	Broken design for runtime control over driver power states, confusing
 	driver-internal runtime power management with:  mechanisms to support
 	system-wide sleep state transitions; event codes that distinguish

-- 
Matthew Garrett | mjg59@srcf.ucam.org
