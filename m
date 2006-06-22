Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030628AbWFVNKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbWFVNKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030629AbWFVNKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:10:24 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:59273 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030628AbWFVNKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:10:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 3/13] Equinox SST driver: char Kconfig and Makefile
Date: Thu, 22 Jun 2006 09:10:23 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B710FD@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 3/13] Equinox SST driver: char Kconfig and Makefile
Thread-Index: AcaV/ThDoxNrRuhXRK6M1yTMcND4Rw==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 3: drivers/char Kconfig and Makefile changes.  SST driver source is
in
its own directory.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 Kconfig  |    2 ++
 Makefile |    1 +
 2 files changed, 3 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/Kconfig
linux-2.6.17.eqnx/drivers/char/Kconfig
--- linux-2.6.17/drivers/char/Kconfig	2006-06-17 21:49:35.000000000
-0400
+++ linux-2.6.17.eqnx/drivers/char/Kconfig	2006-06-20
09:50:00.000000000 -0400
@@ -1034,5 +1034,7 @@ config TELCLOCK
 	  sysfs directory, /sys/devices/platform/telco_clock, with a
number of
 	  files for controlling the behavior of this hardware.
 
+source "drivers/char/eqnx/Kconfig"
+
 endmenu
 
diff -Naurp -X dontdiff linux-2.6.17/drivers/char/Makefile
linux-2.6.17.eqnx/drivers/char/Makefile
--- linux-2.6.17/drivers/char/Makefile	2006-06-17 21:49:35.000000000
-0400
+++ linux-2.6.17.eqnx/drivers/char/Makefile	2006-06-20
09:50:00.000000000 -0400
@@ -96,6 +96,7 @@ obj-$(CONFIG_IPMI_HANDLER)	+= ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER)	+= hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM)		+= tpm/
+obj-$(CONFIG_EQNX)		+= eqnx/
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
