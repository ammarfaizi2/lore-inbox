Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVEXJ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVEXJ4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVEXJqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:46:15 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:37830 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262008AbVEXJU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:20:27 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092020.E212AFA33@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:20:20 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id F36ADFB6F

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:44 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261368AbVEXGzb (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:55:31 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVEXGzb

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:55:31 -0400

Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:33937 "EHLO

	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP

	id S261368AbVEXGzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:55:16 -0400

Received: from faui31y.informatik.uni-erlangen.de (mnwaitz@faui31y [131.188.33.40])

	by faui3es.informatik.uni-erlangen.de (8.13.4/8.13.4/Debian-1) with ESMTP id j4O6t96O021202;

	Tue, 24 May 2005 08:55:09 +0200

Received: (from mnwaitz@localhost)

	by faui31y.informatik.uni-erlangen.de (8.13.4/8.13.4/Submit) id j4O6t6RJ019924;

	Tue, 24 May 2005 08:55:06 +0200

Date:	Tue, 24 May 2005 08:55:06 +0200

From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: update comments

Message-ID: <20050524065506.GL14161@admingilde.org>

Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

X-Habeas-SWE-1:	winter into spring

X-Habeas-SWE-2:	brightly anticipated

X-Habeas-SWE-3:	like Habeas SWE (tm)

X-Habeas-SWE-4:	Copyright 2002 Habeas (tm)

X-Habeas-SWE-5:	Sender Warranted Email (SWE) (tm). The sender of this

X-Habeas-SWE-6:	email in exchange for a license for this Habeas

X-Habeas-SWE-7:	warrant mark warrants that this is a Habeas Compliant

X-Habeas-SWE-8:	Message (HCM) and not spam. Please report use of this

X-Habeas-SWE-9:	mark in spam to <http://www.habeas.com/report/>.

X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2

User-Agent: Mutt/1.5.9i

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



DocBook: update comments

This patch updates some comments to match code changes.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 Documentation/DocBook/kernel-api.tmpl |    2 +-
 drivers/pnp/card.c                    |    3 +--
 drivers/pnp/manager.c                 |    1 +
 fs/sysfs/file.c                       |    5 +++--
 mm/memory.c                           |    2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

Index: linux-docbook/mm/memory.c
===================================================================
--- linux-docbook.orig/mm/memory.c	2005-05-23 22:21:04.299019913 +0200
+++ linux-docbook/mm/memory.c	2005-05-23 22:22:52.763609544 +0200
@@ -1483,7 +1483,7 @@ restart:
  * unmap_mapping_range - unmap the portion of all mmaps
  * in the specified address_space corresponding to the specified
  * page range in the underlying file.
- * @address_space: the address space containing mmaps to be unmapped.
+ * @mapping: the address space containing mmaps to be unmapped.
  * @holebegin: byte in first page to unmap, relative to the start of
  * the underlying file.  This will be rounded down to a PAGE_SIZE
  * boundary.  Note that this is different from vmtruncate(), which
Index: linux-docbook/drivers/pnp/card.c
===================================================================
--- linux-docbook.orig/drivers/pnp/card.c	2005-04-27 11:47:01.000000000 +0200
+++ linux-docbook/drivers/pnp/card.c	2005-05-23 22:40:39.385145380 +0200
@@ -259,7 +259,6 @@ int pnp_add_card_device(struct pnp_card 
 
 /**
  * pnp_remove_card_device- removes a device from the specified card
- * @card: pointer to the card to remove from
  * @dev: pointer to the device to remove
  */
 
@@ -274,7 +273,7 @@ void pnp_remove_card_device(struct pnp_d
 
 /**
  * pnp_request_card_device - Searches for a PnP device under the specified card
- * @lcard: pointer to the card link, cannot be NULL
+ * @clink: pointer to the card link, cannot be NULL
  * @id: pointer to a PnP ID structure that explains the rules for finding the device
  * @from: Starting place to search from. If NULL it will start from the begining.
  */
Index: linux-docbook/drivers/pnp/manager.c
===================================================================
--- linux-docbook.orig/drivers/pnp/manager.c	2005-05-02 09:16:20.000000000 +0200
+++ linux-docbook/drivers/pnp/manager.c	2005-05-23 22:39:01.494968432 +0200
@@ -390,6 +390,7 @@ fail:
  * pnp_manual_config_dev - Disables Auto Config and Manually sets the resource table
  * @dev: pointer to the desired device
  * @res: pointer to the new resource config
+ * @mode: 0 or PNP_CONFIG_FORCE
  *
  * This function can be used by drivers that want to manually set thier resources.
  */
Index: linux-docbook/fs/sysfs/file.c
===================================================================
--- linux-docbook.orig/fs/sysfs/file.c	2005-05-02 09:16:20.000000000 +0200
+++ linux-docbook/fs/sysfs/file.c	2005-05-23 22:36:14.817206097 +0200
@@ -13,7 +13,7 @@
 #define to_subsys(k) container_of(k,struct subsystem,kset.kobj)
 #define to_sattr(a) container_of(a,struct subsys_attribute,attr)
 
-/**
+/*
  * Subsystem file operations.
  * These operations allow subsystems to have files that can be 
  * read/written. 
@@ -191,8 +191,9 @@ fill_write_buffer(struct sysfs_buffer * 
 
 /**
  *	flush_write_buffer - push buffer to kobject.
- *	@file:		file pointer.
+ *	@dentry:	dentry to the attribute
  *	@buffer:	data buffer for file.
+ *	@count:		number of bytes
  *
  *	Get the correct pointers for the kobject and the attribute we're
  *	dealing with, then call the store() method for the attribute, 
Index: linux-docbook/Documentation/DocBook/kernel-api.tmpl
===================================================================
--- linux-docbook.orig/Documentation/DocBook/kernel-api.tmpl	2005-05-02 09:16:19.000000000 +0200
+++ linux-docbook/Documentation/DocBook/kernel-api.tmpl	2005-05-23 22:31:44.727097652 +0200
@@ -266,7 +266,7 @@ X!Ekernel/module.c
   <chapter id="hardware">
      <title>Hardware Interfaces</title>
      <sect1><title>Interrupt Handling</title>
-!Iarch/i386/kernel/irq.c
+!Ikernel/irq/manage.c
      </sect1>
 
      <sect1><title>Resources Management</title>

-- 
Martin Waitz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

