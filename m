Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVG0Xop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVG0Xop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVG0XnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:43:19 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:4228 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261205AbVG0XnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:43:01 -0400
Date: Thu, 28 Jul 2005 01:41:56 +0200 (CEST)
From: Jiri Slaby <xslaby@fi.muni.cz>
X-X-Sender: xslaby@localhost.localdomain
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, jirislaby@gmail.com
Subject: Re: [PATCH] pci_find_device --> pci_get_device [only marks deprecation]
Message-ID: <Pine.LNX.4.61.0507280135020.27145@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> Jiri Slaby wrote:
> >* Marks the function as deprecated in pci.h
[it is meant pci_find_device]
>
> This is a very good idea in my eyes.

2.6.13-rc3-mm2

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -754,7 +754,7 @@ void pci_setup_cardbus(struct pci_bus *b

  /* Generic PCI functions exported to card drivers */

-struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
+struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from) __deprecated;
  struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
  struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
  int pci_find_capability (struct pci_dev *dev, int cap);
