Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTFOVPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 17:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTFOVPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 17:15:53 -0400
Received: from m239.net195-132-57.noos.fr ([195.132.57.239]:5003 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262874AbTFOVPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 17:15:52 -0400
Date: Sun, 15 Jun 2003 23:29:35 +0200
From: Stelian Pop <stelian@popies.net>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.21] meye driver update
Message-ID: <20030615212935.GA1582@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Michael Buesch <fsdeveloper@yahoo.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030615163138.GD1857@deep-space-9.dsnet> <200306151906.57099.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306151906.57099.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:06:56PM +0200, Michael Buesch wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Sunday 15 June 2003 18:31, Stelian Pop wrote:
> > Hi,
> 
> Hi Stelian,
> 
> > +void dma_free_coherent(struct pci_dev *dev, size_t size,
>                           ^^^^^^^^^^^^^^^^^^^
> > +                         void *vaddr, dma_addr_t dma_handle)
>                                          ^^^^^^^^^^^^^^^^^^^^^
> Why do you define these unused parameters?

Because it's backported from 2.5, and I took it as it, without 
editing.

> > +{
> > +        free_pages((unsigned long)vaddr, get_order(size));
> > +}
> 
> And why are they defined in 2.5, too, althought unused.
> Is there some reason?

Unused of ix86 because bus addresses are the same as virtual addresses.
This is not however the case on other architetures, see 
Documentation/DMA-mapping.txt.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
