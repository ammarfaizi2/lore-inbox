Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTHYIrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTHYIrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:47:52 -0400
Received: from trained-monkey.org ([209.217.122.11]:37892 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S261368AbTHYIrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:47:49 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
From: Jes Sorensen <jes@wildopensource.com>
Date: 25 Aug 2003 04:47:47 -0400
In-Reply-To: <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
Message-ID: <m3znhym8cs.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Krzysztof" == Krzysztof Halasa <khc@pm.waw.pl> writes:

Krzysztof> There is one big problem with current API: the DMA (struct
Krzysztof> driver) API does not have consistent_dma_mask. If the PCI
Krzysztof> API is implemented on top of DMA API, it can't be correct
Krzysztof> (and, obviously, DMA API on top of PCI API can't be correct
Krzysztof> either). So, if we insist on keeping consistent_dma_mask in
Krzysztof> pci_dev structure, we need to add it to DMA API as
Krzysztof> well. There is no trivial change which can fix this
Krzysztof> problem.

So why are we dancing around the thing like this, the problem is sooo
bloody simple. Add consistent_dma_mask to the DMA API as well. I
already spoke to James briefly about this earlier and he didn't sound
like had anything against us adding this feature there.

Jes
