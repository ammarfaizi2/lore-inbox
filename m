Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSCWSDB>; Sat, 23 Mar 2002 13:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310681AbSCWSCv>; Sat, 23 Mar 2002 13:02:51 -0500
Received: from [195.145.236.227] ([195.145.236.227]:52718 "EHLO
	notus.mii.dynalabs.de") by vger.kernel.org with ESMTP
	id <S310666AbSCWSCg>; Sat, 23 Mar 2002 13:02:36 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dmi_scan.c, kernel 2.4.18: Another Sony Vaio needing
 swab_apm_power_in_minutes
From: Michael Piotrowski <mxp@dynalabs.de>
Date: Sat, 23 Mar 2002 19:03:44 +0100
Message-ID: <x6663nrwjj.fsf@notus.mii.dynalabs.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
X-Operating-System: Linux
X-Face: %OvAx]kKl`N,i?yQ+$^p9w2oy)Yg|O}a_~6wtRQ@UTZ*(jSPubbonT]m++M>YBtJqkZZa!W
 "y5`aI.FoKO%$JHz=ws|<S'l>i?y^o2bds(+pcp>gcX]H}?-tCzL^ABzJUWYzS{<Pb.+6b>"!_hFg:
 JD)`kxRKLsNp
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Sony Vaio PCG-Z600LEK(DE) has the same APM problem as many other
Vaio models.

Here's the patch, against 2.4.18:


--- arch/i386/kernel/dmi_scan.c.orig	Sat Mar 23 17:05:30 2002
+++ arch/i386/kernel/dmi_scan.c	Sat Mar 23 18:33:14 2002
@@ -534,6 +534,12 @@
 			MATCH(DMI_BIOS_DATE, "08/11/00"), NO_MATCH
 			} },
 
+	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z600LEK(DE) */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0206Z3"),
+			MATCH(DMI_BIOS_DATE, "12/25/00"), NO_MATCH
+			} },
+
 	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-Z505LS */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "R0203D0"),


-- 
Michael Piotrowski, M.A.                                  <mxp@dynalabs.de>
