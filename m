Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWDKBrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWDKBrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWDKBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:47:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:27363 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932238AbWDKBrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:47:41 -0400
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060410221359.GC27596@ens-lyon.fr>
References: <20060410040120.GA4860@ens-lyon.fr>
	 <200604100607.33362.mb@bu3sch.de> <20060410042228.GN27596@ens-lyon.fr>
	 <200604100628.01483.mb@bu3sch.de> <20060410134625.GA25360@tuxdriver.com>
	 <20060410221359.GC27596@ens-lyon.fr>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 11:47:30 +1000
Message-Id: <1144720050.19353.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The hacks i see there is reallocating a buffer with GFP_DMA, so that
> means that if the ppc dma_alloc_coherent did the same thing as the i386
> counterpart (adding GFP_DMA if dma_mask is less than 32bits) it should
> work, no ?

Except that GFP_DMA covers the whole address space on ppc64...

Ben.


