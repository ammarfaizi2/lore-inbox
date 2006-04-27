Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWD0Mae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWD0Mae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWD0Mae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:30:34 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:24796 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965107AbWD0Mad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:30:33 -0400
Date: Thu, 27 Apr 2006 15:30:32 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
X-X-Sender: ogerlitz@zuben
To: rdreier@cisco.com
cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] iSER's Makefile and Kconfig
In-Reply-To: <Pine.LNX.4.44.0604271528140.16463-100000@zuben>
Message-ID: <Pine.LNX.4.44.0604271530141.16463-100000@zuben>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 27 Apr 2006 12:30:32.0441 (UTC) FILETIME=[60416E90:01C669F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>

--- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/Makefile	2006-04-27 15:12:33.000000000 +0300
@@ -0,0 +1,6 @@
+obj-$(CONFIG_INFINIBAND_ISER)	+= ib_iser.o
+
+ib_iser-y			:= iser_verbs.o \
+				   iser_initiator.o \
+				   iser_memory.o \
+				   iscsi_iser.o 
--- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Kconfig	1970-01-01 02:00:00.000000000 +0200
+++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/Kconfig	2006-04-16 11:04:42.000000000 +0300
@@ -0,0 +1,12 @@
+config INFINIBAND_ISER
+	tristate "ISCSI RDMA Protocol"
+	depends on INFINIBAND && SCSI
+	select SCSI_ISCSI_ATTRS
+	---help---
+
+	  Support for the ISCSI RDMA Protocol over InfiniBand.  This
+	  allows you to access storage devices that speak ISER/ISCSI
+	  over InfiniBand.
+
+	  The ISER protocol is defined by IETF.
+	  See <http://www.ietf.org/>.

