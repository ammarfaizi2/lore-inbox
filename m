Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVALHLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVALHLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVALHIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:08:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26829 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263014AbVALHHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:07:32 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: Linux 2.6.11-rc1 
In-reply-to: Your message of "Tue, 11 Jan 2005 21:09:21 -0800."
             <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jan 2005 18:07:26 +1100
Message-ID: <23675.1105513646@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005 21:09:21 -0800 (PST), 
Linus Torvalds <torvalds@osdl.org> wrote:
>Ok, the big merges after 2.6.10 are hopefully over, and 2.6.11-rc1 is out 
>there.

Export pcibios_resource_to_bus in ia64 to match other architectures.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: linux/arch/ia64/pci/pci.c
===================================================================
--- linux.orig/arch/ia64/pci/pci.c	2005-01-12 17:07:23.000000000 +1100
+++ linux/arch/ia64/pci/pci.c	2005-01-12 18:04:12.000000000 +1100
@@ -367,6 +367,7 @@ void pcibios_resource_to_bus(struct pci_
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
+EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 void pcibios_bus_to_resource(struct pci_dev *dev,
 		struct resource *res, struct pci_bus_region *region)

