Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWEKHDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWEKHDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWEKHDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:03:32 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:21445 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965177AbWEKHDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:03:31 -0400
Date: Thu, 11 May 2006 10:03:30 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
X-X-Sender: ogerlitz@zuben
To: rdreier@cisco.com
cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] iSER Kconfig and Makefile
In-Reply-To: <Pine.LNX.4.44.0605111002510.18975-100000@zuben>
Message-ID: <Pine.LNX.4.44.0605111003160.18975-100000@zuben>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 May 2006 07:03:30.0355 (UTC) FILETIME=[025D3830:01C674C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig and Makefile for iSER.

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>

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

