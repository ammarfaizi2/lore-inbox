Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbTHSJuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHSJuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:50:06 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:2271 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S269583AbTHSJuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:50:02 -0400
To: Jes Sorensen <jes@wildopensource.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfzuen2.fsf@defiant.pm.waw.pl> <m3y8xqroqo.fsf@trained-monkey.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Aug 2003 11:49:28 +0200
In-Reply-To: <m3y8xqroqo.fsf@trained-monkey.org>
Message-ID: <m3vfsuj7tj.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@wildopensource.com> writes:

> Bzzzt, *wrong*! Take a look at drivers/scsi/aic7xxx/aic7xxx_osm_pci.c,
> if you look at the code you will notice that the hardware does support
> different masks for consistent vs dynamic allocations (32 bit for
> consistent vs 39 or 64 bit for dynamic).

The hardware, maybe.

> However make a note that the
> driver uses the current interface incorrectly and thinks that
> pci_set_dma_mask() actually applies to pci_alloc_consistent, which is
> something it never did.

No, it nearly always does. Looks at the actual pci_alloc_consistent on,
say, i386.

Will it be ok if I fix the consistent allocs to use consistent_dma_mask
(some drivers will need a fix on i386 etc.)?
-- 
Krzysztof Halasa
Network Administrator
