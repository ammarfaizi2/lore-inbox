Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVCJCk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVCJCk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVCJBOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:14:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:43679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262606AbVCJAmX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:23 -0500
Cc: linux@dominikbrodowski.de
Subject: [PATCH] cpufreq 2.4 interface removal schedule
In-Reply-To: <1110414878721@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:39 -0800
Message-Id: <1110414879646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2037, 2005/03/09 09:32:00-08:00, linux@dominikbrodowski.de

[PATCH] cpufreq 2.4 interface removal schedule

Even though these 2.4. interfaces are already gone in Dave Jones' cpufreq
bitkeeper tree, here's a patch which properly announces it in
Documentation/feature-removal-schedule.txt:


Add meaningful content concerning the removal of deprecated interfaces to
the cpufreq core.

Signed-off-by: Dominik Brodowski <linux@brodo.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/feature-removal-schedule.txt |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)


diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2005-03-09 16:30:09 -08:00
+++ b/Documentation/feature-removal-schedule.txt	2005-03-09 16:30:09 -08:00
@@ -17,10 +17,18 @@
 
 ---------------------------
 
-What:	/proc/sys/cpu and the sysctl interface to cpufreq (2.4.x interfaces)
+What:	/proc/sys/cpu/*, sysctl and /proc/cpufreq interfaces to cpufreq (2.4.x interfaces)
 When:	January 2005
 Files:	drivers/cpufreq/: cpufreq_userspace.c, proc_intf.c
-	function calls throughout the kernel tree
-Why:	Deprecated, has been replaced/superseded by (what?)....
+Why:	/proc/sys/cpu/* has been deprecated since inclusion of cpufreq into
+	the main kernel tree. It bloats /proc/ unnecessarily and doesn't work
+	well with the "governor"-based design of cpufreq.
+	/proc/cpufreq/* has also been deprecated for a long time and was only
+	meant for usage during 2.5. until the new sysfs-based interface became
+	ready. It has an inconsistent interface which doesn't work well with
+	userspace setting the frequency. The output from /proc/cpufreq/* can
+	be emulated using "cpufreq-info --proc" (cpufrequtils).
+	Both interfaces are superseded by the cpufreq interface in
+	/sys/devices/system/cpu/cpu%n/cpufreq/.
 Who:	Dominik Brodowski <linux@brodo.de>
 

