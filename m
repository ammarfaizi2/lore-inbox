Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbUKQMf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUKQMf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUKQMf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:35:29 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:9667 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262295AbUKQMe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:34:57 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Documentation/pci.txt inconsistency
Date: Wed, 17 Nov 2004 13:34:56 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411171334.56492@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The examples in section 2 of Documentation/pci.txt use pci_get_*. Some lines
later there is this funny little paragraph:

> Note that these functions are not hotplug-safe.  Their hotplug-safe
> replacements are pci_get_device(), pci_get_class() and pci_get_subsys().
> They increment the reference count on the pci_dev that they return.
> You must eventually (possibly at module unload) decrement the reference
> count on these devices by calling pci_dev_put().

How about this:

These functions are hotplug-safe. They increment the reference count on the
pci_dev that they return. You must eventually (possibly at module unload)
decrement the reference count on these devices by calling pci_dev_put().

Eike
