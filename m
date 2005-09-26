Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVIZXsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVIZXsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVIZXsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:48:05 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:34205 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S964777AbVIZXsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:48:04 -0400
Date: Mon, 26 Sep 2005 16:54:07 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Raj, Ashok" <ashok.raj@intel.com>, bjorn.helgaas@hp.com
Subject: RE: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
In-Reply-To: <7F740D512C7C1046AB53446D37200173055345A1@scsmsx402.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0509261630220.1684@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D37200173055345A1@scsmsx402.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Nakajima, Jun wrote:

> Zwane Mwaikambo wrote:
> > Apologies for the long periods between updates, i've been doing some
> > relocating.
> > 
> > Changes since last post:
> > 
> > * Current interrupt handling domain is still on a node basis,
> > although i 
> > have moved over to dynamically allocated per cpu IDTs.
> 
> I think it might be better if you define some cpu group where the cpus
> share the same IDT. Then you can handle big SMP machines as well; it's a
> kind of software partitioning limited to I/O device interrupts. That
> will be helpful for virtulization like Xen.

With the move to per cpu IDT, we can now easily fit in a higher level 
policy with respect to which groups share IDTs. 

Thanks,
	Zwane

