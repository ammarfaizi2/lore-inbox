Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTIUS0j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTIUS0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:26:39 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:30478 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262493AbTIUS0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:26:38 -0400
Date: Sun, 21 Sep 2003 15:28:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Jeff Garzik <jgarzik@pobox.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, <jgarzik@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 fix pci_generic_prep_mwi export breakage
In-Reply-To: <3F6C9B6B.4070308@pobox.com>
Message-ID: <Pine.LNX.4.44.0309211524290.18223-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Sep 2003, Jeff Garzik wrote:

> Bjorn Helgaas wrote:
> > I think the recent change to pci.c to export pci_generic_prep_mwi() 
> > is incorrect.
> > 
> > pci_generic_prep_mwi() is only defined if !HAVE_ARCH_PCI_MWI,
> > so it is wrong to export it.  In particular, it breaks on
> > ia64, because we define HAVE_ARCH_PCI_MWI.
> > 
> > It looks to me like the following patch should be applied.  This
> > removes the export and in fact makes pci_generic_prep_mwi() static
> > as it is in 2.5.
> 
> 
> Looks OK to me.  Marcelo applied this already, right?

Well I dont remember applying it but I dont seem to have 
pci_generic_prep_mwi exported. 



