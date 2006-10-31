Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423574AbWJaQg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423574AbWJaQg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423582AbWJaQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:36:27 -0500
Received: from dxv01.wellsfargo.com ([151.151.5.42]:8595 "EHLO
	dxv01.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1423574AbWJaQgZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:36:25 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: [PATCH 1/1] PS/2 driver update for Fujitsu 4-wire touchscreen on Hitachi tablets.
Date: Tue, 31 Oct 2006 10:36:12 -0600
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D02170EEE@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] PS/2 driver update for Fujitsu 4-wire touchscreen on Hitachi tablets.
Thread-Index: Acb9Cq0JIJ3ZiQ97QL6yAaOhz69A2w==
From: <Greg.Chandler@wellsfargo.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, <linux-input@atrey.karlin.mff.cuni.cz>,
       <dmitry.torokhov@gmail.com>
X-OriginalArrivalTime: 31 Oct 2006 16:36:15.0318 (UTC) FILETIME=[AEF12F60:01C6FD0A]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds another DMI detected touchscreen.  It is exactly the same
driver as the existing ones, but this allows it to be detected on the
Hitachi Flora-IE 55mi tablet.  The original Midori drivers are "abeo
antiquus".  This should allow new life for these machines.



--- drivers/input/mouse/lifebook.c.old  2006-10-13 22:34:03.000000000
-0500
+++ drivers/input/mouse/lifebook.c      2006-10-31 10:08:29.000000000
-0600
@@ -22,6 +22,12 @@

 static struct dmi_system_id lifebook_dmi_table[] = {
        {
+               .ident = "FLORA-ie 55mi",
+               .matches = {
+                       DMI_MATCH(DMI_PRODUCT_NAME, "FLORA-ie 55mi"),
+               },
+       },
+       {
                .ident = "LifeBook B",
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook B
Series"),


