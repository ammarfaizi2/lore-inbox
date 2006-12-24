Return-Path: <linux-kernel-owner+w=401wt.eu-S1752410AbWLXRN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbWLXRN1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 12:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbWLXRN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 12:13:27 -0500
Received: from mx1.suse.de ([195.135.220.2]:39730 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbWLXRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 12:13:26 -0500
From: Andreas Schwab <schwab@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
X-Yow: I know things about TROY DONAHUE that can't even be PRINTED!!
Date: Sun, 24 Dec 2006 18:13:23 +0100
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> (Linus
	Torvalds's message of "Sat, 23 Dec 2006 20:49:41 -0800 (PST)")
Message-ID: <jey7ox2p58.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Yu Luming (1):
>       ACPI: video: Add dev argument for backlight_device_register

Fix compilation of via-pmu-backlight.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 drivers/macintosh/via-pmu-backlight.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.20-rc2/drivers/macintosh/via-pmu-backlight.c
===================================================================
--- linux-2.6.20-rc2.orig/drivers/macintosh/via-pmu-backlight.c	2006-11-30 23:33:39.000000000 +0100
+++ linux-2.6.20-rc2/drivers/macintosh/via-pmu-backlight.c	2006-12-24 17:58:18.000000000 +0100
@@ -147,7 +147,7 @@ void __init pmu_backlight_init()
 
 	snprintf(name, sizeof(name), "pmubl");
 
-	bd = backlight_device_register(name, NULL, &pmu_backlight_data);
+	bd = backlight_device_register(name, NULL, NULL, &pmu_backlight_data);
 	if (IS_ERR(bd)) {
 		printk("pmubl: Backlight registration failed\n");
 		goto error;

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
