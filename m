Return-Path: <linux-kernel-owner+w=401wt.eu-S1751523AbWLQAtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWLQAtG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 19:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWLQAtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 19:49:06 -0500
Received: from tim.rpsys.net ([194.106.48.114]:46588 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbWLQAtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 19:49:05 -0500
X-Greylist: delayed 1608 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 19:49:04 EST
Subject: Schedule tsdev.c for removal
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Date: Sun, 17 Dec 2006 00:21:17 +0000
Message-Id: <1166314878.5606.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Schedule drivers/input/tsdev.c for removal, nobody should be using
this anymore. See the patch for details.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

 Documentation/feature-removal-schedule.txt |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: git/Documentation/feature-removal-schedule.txt
===================================================================
--- git.orig/Documentation/feature-removal-schedule.txt	2006-12-16 21:44:40.000000000 +0000
+++ git/Documentation/feature-removal-schedule.txt	2006-12-17 00:15:03.000000000 +0000
@@ -256,3 +256,17 @@ Why:	Speedstep-centrino driver with ACPI
 Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
 ---------------------------
+
+What:   Compaq touchscreen device emulation
+When:   March 2007
+Files:  drivers/input/tsdev.c
+Why:    The code says it was obsolete when it was written in 2001.
+	tslib is a userspace library which does anything tsdev can do and 
+	much more besides in userspace where this code belongs. There is no 
+	longer any need for tsdev and applications should have converted to 
+	use tslib by now.
+	The name "tsdev" is also extremely confusing and lots of people have 
+	it loaded when they don't need/use it.
+Who:    Richard Purdie <rpurdie@rpsys.net>
+
+---------------------------

