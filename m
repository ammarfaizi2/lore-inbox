Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVF0WzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVF0WzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVF0WxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:53:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262046AbVF0Wvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:51:38 -0400
Date: Mon, 27 Jun 2005 15:50:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       Mika Kukkonen <mikukkon@gmail.com>, hch@infradead.org
Subject: [01/07] Fix typo in drivers/pci/pci-driver.c
Message-ID: <20050627225040.GJ9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

The git commit 794f5bfa77955c4455f6d72d8b0e2bee25f1ff0c
accidentally suffers from a previous typo in that file
(',' instead of ';' in end of line). Patch included.

Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>
Signed-off-by: Chris Wright <chrisw@osdl.org>

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c	2005-06-18 22:05:42.642463416 +0300
+++ linux-2.6/drivers/pci/pci-driver.c	2005-06-18 22:10:37.486761280 +0300
@@ -396,7 +396,7 @@
 	/* FIXME, once all of the existing PCI drivers have been fixed to set
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
-		drv->driver.shutdown = pci_device_shutdown,
+		drv->driver.shutdown = pci_device_shutdown;
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
