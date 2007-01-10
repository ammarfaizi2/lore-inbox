Return-Path: <linux-kernel-owner+w=401wt.eu-S932643AbXAJFlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbXAJFlN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXAJFlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:41:12 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:55207 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbXAJFlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:41:09 -0500
Date: Tue, 9 Jan 2007 21:41:09 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Matt_Domsch@dell.com
Subject: [PATCH] docbook: add edd firmware interfaces
Message-Id: <20070109214109.3d70403f.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Cleanup kernel-doc notation in drivers/firmware/edd.c.

Add edd.c to DocBook/kernel-api.tmpl.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/DocBook/kernel-api.tmpl |    3 +++
 drivers/firmware/edd.c                |    8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2620-rc4.orig/drivers/firmware/edd.c
+++ linux-2620-rc4/drivers/firmware/edd.c
@@ -233,6 +233,8 @@ edd_show_interface(struct edd_device *ed
 
 /**
  * edd_show_raw_data() - copies raw data to buffer for userspace to parse
+ * @edev: target edd_device
+ * @buf: output buffer
  *
  * Returns: number of bytes written, or -EINVAL on failure
  */
@@ -634,8 +636,8 @@ static decl_subsys(edd,&ktype_edd,NULL);
 
 /**
  * edd_dev_is_type() - is this EDD device a 'type' device?
- * @edev
- * @type - a host bus or interface identifier string per the EDD spec
+ * @edev: target edd_device
+ * @type: a host bus or interface identifier string per the EDD spec
  *
  * Returns 1 (TRUE) if it is a 'type' device, 0 otherwise.
  */
@@ -657,7 +659,7 @@ edd_dev_is_type(struct edd_device *edev,
 
 /**
  * edd_get_pci_dev() - finds pci_dev that matches edev
- * @edev - edd_device
+ * @edev: edd_device
  *
  * Returns pci_dev if found, or NULL
  */
--- linux-2620-rc4.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2620-rc4/Documentation/DocBook/kernel-api.tmpl
@@ -316,6 +316,9 @@ X!Earch/i386/kernel/mca.c
      <sect1><title>DMI Interfaces</title>
 !Edrivers/firmware/dmi_scan.c
      </sect1>
+     <sect1><title>EDD Interfaces</title>
+!Idrivers/firmware/edd.c
+     </sect1>
   </chapter>
 
   <chapter id="security">


---
