Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTERRhS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTERRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 13:37:18 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:34566 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262150AbTERRhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 13:37:17 -0400
Subject: Re: [Linux-ia64] Re: [patch] support 64 bit pci_alloc_consistent
From: James Bottomley <James.Bottomley@steeleye.com>
To: Grant Grundler <iod00d@hp.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@wildopensource.com>, torvalds@transmeta.com,
       grundler@dsl2.external.hp.com, cngam@sgi.com, jeremy@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
In-Reply-To: <20030518172203.GA13855@cup.hp.com>
References: <16071.1892.811622.257847@trained-monkey.org>
	<1053250142.1300.8.camel@laptop.fenrus.com>
	<20030518.023533.98888328.davem@redhat.com>
	<20030518094341.A1709@devserv.devel.redhat.com> 
	<20030518172203.GA13855@cup.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 May 2003 12:49:49 -0500
Message-Id: <1053280195.10810.61.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-18 at 12:22, Grant Grundler wrote:
> On Sun, May 18, 2003 at 09:43:41AM +0000, Arjan van de Ven wrote:
> > Most drivers will just say "look I
> > can do THIS much. I don't give a flying fish about how much of
> > that you actually use". At least in the probing code. 
> 
> The platform code needs a way to indicate the given mask will not work.
> Rejecting proposals by the driver seems reasonable if the driver
> only supports two different masks anyway (eg 64 and 32-bit).
> 
> In the case of a platform requiring 64-bit masks for consistent mappings,
> the platform DMA code must reject proposals for non-64-bit DMA masks.
> (eg PCI-X device implementing less than 64-bits)
> 
> In both cases the driver will care because it will crash the box otherwise.

In that case, the platform returns zero to "this much" being less than
the full 64 bits implying there's no mask the platform and driver can
agree on.

James


