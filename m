Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTFULkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTFULkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:40:08 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:14091 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265162AbTFULj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:39:59 -0400
Date: Sat, 21 Jun 2003 15:53:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] reimplement pci proc name
Message-ID: <20030621155333.A24141@jurassic.park.msu.ru>
References: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk> <20030620212413.GA13694@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030620212413.GA13694@kroah.com>; from greg@kroah.com on Fri, Jun 20, 2003 at 02:24:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:24:13PM -0700, Greg KH wrote:
> Thanks, I've reverted your previous patch, and fixed the one typo in
> this patch and applied it all to my bk tree.  Hopefully Linus will pull
> from it sometime soon :)

Argh, where were my eyes... There was another typo which broke Alpha.

Greg, please apply.

Ivan.

--- 2.5/include/asm-alpha/pci.h	Sat Jun 21 15:36:01 2003
+++ linux/include/asm-alpha/pci.h	Sat Jun 21 15:36:24 2003
@@ -197,7 +197,8 @@ pcibios_resource_to_bus(struct pci_dev *
 /* Bus number == domain number until we get above 256 busses */
 static inline int pci_name_bus(char *name, struct pci_bus *bus)
 {
-	int domain = pci_domain_nr(bus)
+	int domain = pci_domain_nr(bus);
+
 	if (domain < 256) {
 		sprintf(name, "%02x", domain);
 	} else {
