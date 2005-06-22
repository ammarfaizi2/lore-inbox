Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVFVGSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVFVGSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVFVGSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:18:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:42140 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262810AbVFVFWK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:10 -0400
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] I2C: documentation update 3/3
In-Reply-To: <1119417466661@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <11194174672285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: documentation update 3/3

This patch adds information about available userspace utillities
for system health monitoring drivers.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 828621dda6381093ceafbe9381b6118cae3f9b13
tree 60fae466a2a5af340d156da1532c3ceb9c6bab5b
parent 7f15b66468b7003d5241e352a007e73be5519b20
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> Thu, 26 May 2005 12:42:29 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:02 -0700

 Documentation/i2c/userspace-tools |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/userspace-tools b/Documentation/i2c/userspace-tools
new file mode 100644
--- /dev/null
+++ b/Documentation/i2c/userspace-tools
@@ -0,0 +1,39 @@
+Introduction
+------------
+
+Most mainboards have sensor chips to monitor system health (like temperatures,
+voltages, fans speed). They are often connected through an I2C bus, but some
+are also connected directly through the ISA bus.
+
+The kernel drivers make the data from the sensor chips available in the /sys
+virtual filesystem. Userspace tools are then used to display or set or the
+data in a more friendly manner.
+
+Lm-sensors
+----------
+
+Core set of utilites that will allow you to obtain health information,
+setup monitoring limits etc. You can get them on their homepage
+http://www.lm-sensors.nu/ or as a package from your Linux distribution.
+
+If from website:
+Get lmsensors from project web site. Please note, you need only userspace
+part, so compile with "make user_install" target.
+
+General hints to get things working:
+
+0) get lm-sensors userspace utils
+1) compile all drivers in I2C section as modules in your kernel
+2) run sensors-detect script, it will tell you what modules you need to load.
+3) load them and run "sensors" command, you should see some results.
+4) fix sensors.conf, labels, limits, fan divisors
+5) if any more problems consult FAQ, or documentation
+
+Other utilites
+--------------
+
+If you want some graphical indicators of system health look for applications
+like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
+hardware-monitor
+
+If you are server administrator you can try snmpd or mrtgutils.

