Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVCSGKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVCSGKN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 01:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVCSGKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 01:10:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24736 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262415AbVCSGJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 01:09:51 -0500
Subject: Re: [PATCH 2.4.30-pre3] x86_64: pci_alloc_consistent() match 2.6
	implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050318212344.GC26112@lists.us.dell.com>
References: <20050318212344.GC26112@lists.us.dell.com>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 07:09:45 +0100
Message-Id: <1111212585.6291.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 15:23 -0600, Matt Domsch wrote:
> For review and comment.
> 
> On x86_64 systems with no IOMMU and with >4GB RAM (in fact, whenever
> there are any pages mapped above 4GB), pci_alloc_consistent() falls
> back to using ZONE_DMA for all allocations, even if the device's
> dma_mask could have supported using memory from other zones.  Problems
> can be seen when other ZONE_DMA users (SWIOTLB, scsi_malloc()) consume
> all of ZONE_DMA, leaving none left for pci_alloc_consistent() use.

scsi_malloc no longer uses ZONE_DMA nowadays....


