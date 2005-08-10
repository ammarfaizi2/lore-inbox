Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVHJGLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVHJGLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 02:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVHJGLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 02:11:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30409 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965017AbVHJGLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 02:11:00 -0400
Subject: Re: [RFC/PATCH] Add pci_walk_bus function to PCI core
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linas@austin.ibm.com
In-Reply-To: <17145.23098.798473.364481@cargo.ozlabs.ibm.com>
References: <17145.23098.798473.364481@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 08:10:49 +0200
Message-Id: <1123654250.3217.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 11:36 +1000, Paul Mackerras wrote:
> Greg,
> 
> Any comments on this patch?  Would you be amenable to it going in post
> 2.6.13?
> 
> The PCI error recovery infrastructure needs to be able to contact all
> the drivers affected by a PCI error event, which may mean traversing
> all the devices under a given PCI-PCI bridge.  This patch adds a
> function to the PCI core that traverses all the PCI devices on a PCI
> bus and under any PCI-PCI bridges on that bus (recursively), calling a
> given function for each device. 

is there a way to avoid the recursion somehow? Recursion is "not fun"
stack usage wise, esp if you have really deep hierarchies....


