Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTFWXpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTFWXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:45:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:47853 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264486AbTFWXps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:45:48 -0400
Date: Mon, 23 Jun 2003 16:59:19 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.73
Message-ID: <20030623235919.GC12207@kroah.com>
References: <20030623235852.GA12207@kroah.com> <20030623235910.GB12207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623235910.GB12207@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1348.14.2, 2003/06/23 11:45:05-07:00, ink@jurassic.park.msu.ru

[PATCH] PCI: fix alpha for reimplement pci proc name

On Fri, Jun 20, 2003 at 02:24:13PM -0700, Greg KH wrote:
> Thanks, I've reverted your previous patch, and fixed the one typo in
> this patch and applied it all to my bk tree.  Hopefully Linus will pull
> from it sometime soon :)

Argh, where were my eyes... There was another typo which broke Alpha.


 include/asm-alpha/pci.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h	Mon Jun 23 16:54:02 2003
+++ b/include/asm-alpha/pci.h	Mon Jun 23 16:54:02 2003
@@ -197,7 +197,8 @@
 /* Bus number == domain number until we get above 256 busses */
 static inline int pci_name_bus(char *name, struct pci_bus *bus)
 {
-	int domain = pci_domain_nr(bus)
+	int domain = pci_domain_nr(bus);
+
 	if (domain < 256) {
 		sprintf(name, "%02x", domain);
 	} else {
