Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWEJNXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWEJNXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWEJNXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:23:16 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:43631 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S964955AbWEJNXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:23:14 -0400
Date: Wed, 10 May 2006 16:23:12 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
X-X-Sender: ogerlitz@zuben
To: rdreier@cisco.com
cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] iSER's Kconfig and Makefile
In-Reply-To: <Pine.LNX.4.44.0605101622320.17835-100000@zuben>
Message-ID: <Pine.LNX.4.44.0605101622570.17835-100000@zuben>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 May 2006 13:23:12.0900 (UTC) FILETIME=[E367F440:01C67434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Kconfig	1970-01-01 02:00:00.000000000 +0200
+++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/Kconfig	2006-05-10 15:32:01.000000000 +0300
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
--- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/Makefile	2006-05-10 15:32:01.000000000 +0300
@@ -0,0 +1,8 @@
+EXTRA_CFLAGS += -Idrivers/infiniband/include
+
+obj-$(CONFIG_INFINIBAND_ISER)	+= ib_iser.o
+
+ib_iser-y			:= iser_verbs.o \
+				   iser_initiator.o \
+				   iser_memory.o \
+				   iscsi_iser.o

