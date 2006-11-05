Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWKEUqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWKEUqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWKEUqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:46:30 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:30729 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422660AbWKEUq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:46:29 -0500
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 3/4] ehca: Kconfig: activate scaling code as default to prevent drop packets (UD)
Date: Sun, 5 Nov 2006 21:42:20 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sykTF3lLtF5NXBG"
Message-Id: <200611052142.20577.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_sykTF3lLtF5NXBG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
Here is a small patch of ehca's Kconfig that activates scaling code as default.
After several measurements we saw that this feature prevents drop packets (UD)
in stress situation. Thus, enabling it helps to improve ehca's bandwidth through
ipoib.
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 Kconfig |    1 +
 1 files changed, 1 insertion(+)


diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
index 922389b..727b10d 100644
--- a/drivers/infiniband/hw/ehca/Kconfig
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -10,6 +10,7 @@ config INFINIBAND_EHCA
 config INFINIBAND_EHCA_SCALING
  bool "Scaling support (EXPERIMENTAL)"
  depends on IBMEBUS && INFINIBAND_EHCA && HOTPLUG_CPU && EXPERIMENTAL
+ default y
  ---help---
  eHCA scaling support schedules the CQ callbacks to different CPUs.
 

--Boundary-00=_sykTF3lLtF5NXBG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_kconfig.patch"

diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
index 922389b..727b10d 100644
--- a/drivers/infiniband/hw/ehca/Kconfig
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -10,6 +10,7 @@ config INFINIBAND_EHCA
 config INFINIBAND_EHCA_SCALING
 	bool "Scaling support (EXPERIMENTAL)"
 	depends on IBMEBUS && INFINIBAND_EHCA && HOTPLUG_CPU && EXPERIMENTAL
+	default y
 	---help---
 	eHCA scaling support schedules the CQ callbacks to different CPUs.
 

--Boundary-00=_sykTF3lLtF5NXBG--
