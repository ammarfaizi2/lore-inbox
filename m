Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266428AbRG1GmF>; Sat, 28 Jul 2001 02:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266448AbRG1Glz>; Sat, 28 Jul 2001 02:41:55 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:46864 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S266428AbRG1Glh>; Sat, 28 Jul 2001 02:41:37 -0400
Date: Sat, 28 Jul 2001 07:41:43 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH for another bad VAIO APM BIOS
Message-ID: <20010728074143.A16328@xyzzy.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Another VAIO BIOS to join the list that byte swap the battery condition.
This is a Sony VAIO PCG-Z600NE.
The patch is against 2.4.7-ac2


--- linux/arch/i386/kernel/dmi_scan.c.orig	Sat Jul 28 07:20:00 2001
+++ linux/arch/i386/kernel/dmi_scan.c	Sat Jul 28 07:19:44 2001
@@ -347,6 +347,11 @@
 			MATCH(DMI_BIOS_VERSION, "R0203D0"),
 			MATCH(DMI_BIOS_DATE, "05/12/00"), NO_MATCH
 			} },
+	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600NE */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0121Z1"),
+			MATCH(DMI_BIOS_DATE, "05/11/00"), NO_MATCH
+			} },
 	{ NULL, }
 };
	


-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
