Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUCRX4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbUCRXzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:55:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263349AbUCRXwx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:52:53 -0500
Date: Thu, 18 Mar 2004 23:52:50 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [3/3] claim PCI resources on ia64
Message-ID: <20040318235250.GK25059@parcelfarce.linux.theplanet.co.uk>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Call pci_claim_resources() so we can see what PCI resources are being used.

Index: arch/ia64/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/pci/pci.c,v
retrieving revision 1.7
diff -u -p -r1.7 pci.c
--- a/arch/ia64/pci/pci.c	16 Mar 2004 15:39:51 -0000	1.7
+++ b/arch/ia64/pci/pci.c	18 Mar 2004 23:40:52 -0000
@@ -367,6 +366,7 @@ pcibios_fixup_device_resources (struct p
 				dev->resource[i].end   += window->offset;
 			}
 		}
+		pci_claim_resource(dev, i);
 	}
 }
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
