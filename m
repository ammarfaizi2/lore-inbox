Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269712AbRHTWaE>; Mon, 20 Aug 2001 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRHTW3y>; Mon, 20 Aug 2001 18:29:54 -0400
Received: from front2.grolier.fr ([194.158.96.52]:56471 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S269712AbRHTW3g>; Mon, 20 Aug 2001 18:29:36 -0400
Message-ID: <3B818F1B.EE31267F@club-internet.fr>
Date: Tue, 21 Aug 2001 00:28:43 +0200
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Another Sony VAIO apm swab.
Content-Type: multipart/mixed;
 boundary="------------BB59818327F94D4EA9309805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BB59818327F94D4EA9309805
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi list,

	Well, like many other Vaio owner, mine have +5000min
of autonomy ;-). Not really. Here is the patch to add this
PCG-F104K to ari/i386/kernel/dmi_scan.c and turn on the 
workaround.

Cheers.
-- 
73's de Daniel, F1RMB.

              -=- Daniel Caujolle-Bert -=- segfault@club-internet.fr -=-
                        -=- f1rmb@f1rmb.ampr.org (AMPR NET) -=-
--------------BB59818327F94D4EA9309805
Content-Type: text/plain; charset=us-ascii;
 name="dmi_scan.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi_scan.c.diff"

--- linux-2.4.8-ac7.vanilla/arch/i386/kernel/dmi_scan.c	Tue Aug 21 00:29:12 2001
+++ linux-2.4.8-ac7/arch/i386/kernel/dmi_scan.c	Tue Aug 21 00:27:48 2001
@@ -485,6 +485,11 @@
 			MATCH(DMI_BIOS_VERSION, "R0117A0"),
 			MATCH(DMI_BIOS_DATE, "04/25/00"), NO_MATCH
 			} },
+	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-F104K */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0204K2"),
+			MATCH(DMI_BIOS_DATE, "08/28/00"), NO_MATCH
+			} },
 	
 	/* Problem Intel 440GX bioses */
 

--------------BB59818327F94D4EA9309805--


