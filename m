Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUCSA6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUCSA6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:58:10 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:10182 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261158AbUCSA6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:58:07 -0500
Date: Thu, 18 Mar 2004 19:58:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
In-Reply-To: <9860000.1079653397@flay>
Message-ID: <Pine.LNX.4.58.0403181956560.28447@montezuma.fsmlabs.com>
References: <1079651064.8149.158.camel@arrakis> <200403181523.10670.jbarnes@sgi.com>
 <8090000.1079652747@flay> <200403181537.10060.jbarnes@sgi.com>
 <9860000.1079653397@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Martin J. Bligh wrote:

> >> I/O isn't directly associated with a node, though it should fit into the
> >> topo infrastructure, to give distances from io buses to nodes (for which
> >> I think we currently use cpumasks, which is probably wrong in retrospect,
> >> but then life is tough and flawed ;-))
> >
> > It's probably not too late to change this to
> > pcibus_to_nodemask(pci_bus *), or pci_to_nodemask(pci_dev *), there
> > aren't that many callers, are there (my grep is still running)?
>
> It probably shouldn't have anything to do with PCI directly either,
> so .... ;-) My former thought was that you might just want the most
> local memory for DMAing into.

That knowledge should be in the dma api thing shouldn't it? But in it's
current incarnation i don't see how that's possible.
