Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269884AbUJSXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269884AbUJSXBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270191AbUJSWzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:55:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:61321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270071AbUJSWqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:20 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257321011@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <10982257333598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.7, 2004/10/06 11:20:43-07:00, greg@kroah.com

[PATCH] PCI: clean up the comments in search.c to be correct.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/search.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2004-10-19 15:27:21 -07:00
+++ b/drivers/pci/search.c	2004-10-19 15:27:21 -07:00
@@ -1,10 +1,10 @@
 /*
  * 	PCI searching functions.
  *
- *	Copyright 1993 -- 1997 Drew Eckhardt, Frederic Potter,
- *				David Mosberger-Tang
- *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
- *	Copyright 2003 -- Greg Kroah-Hartman <greg@kroah.com>
+ *	Copyright (C) 1993 -- 1997 Drew Eckhardt, Frederic Potter,
+ *					David Mosberger-Tang
+ *	Copyright (C) 1997 -- 2000 Martin Mares <mj@ucw.cz>
+ *	Copyright (C) 2003 -- 2004 Greg Kroah-Hartman <greg@kroah.com>
  */
 
 #include <linux/init.h>
@@ -258,12 +258,6 @@
  * @from: Previous PCI device found in search, or %NULL for new search.
  *
  * Iterates through the list of known PCI devices.  If a PCI device is
- * found with a matching @vendor and @device, a pointer to its device structure is
- * returned.  Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from next device on the global list.
- *
- * Iterates through the list of known PCI devices.  If a PCI device is
  * found with a matching @vendor and @device, the reference count to the
  * device is incremented and a pointer to its device structure is returned.
  * Otherwise, %NULL is returned.  A new search is initiated by passing %NULL
@@ -325,6 +319,10 @@
  * A new search is initiated by passing %NULL to the @from argument.
  * Otherwise if @from is not %NULL, searches continue from next device
  * on the global list.
+ *
+ * NOTE: Do not use this function anymore, use pci_get_class() instead, as
+ * the pci device returned by this function can disappear at any moment in
+ * time.
  */
 struct pci_dev *
 pci_find_class(unsigned int class, const struct pci_dev *from)

