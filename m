Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVD1HtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVD1HtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVD1Hs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:48:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:15842 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261926AbVD1Hr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:47:57 -0400
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20050428002209.12bd3f37.davem@davemloft.net>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org>
	 <20050427223702.21051afc.davem@davemloft.net>
	 <1114670353.7182.246.camel@gaston>
	 <20050427235056.0bd09a94.davem@davemloft.net>
	 <1114672880.7111.254.camel@gaston>
	 <20050428002209.12bd3f37.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 17:46:38 +1000
Message-Id: <1114674398.7183.257.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 00:22 -0700, David S. Miller wrote:
> On Thu, 28 Apr 2005 17:21:19 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > I have a real net big performance improvement on X by doing that
> > trick ... the sysfs mmap API doesn't really provide a mean to do
> > it explicitely from userland (unlike the ioctl with the old proc api)
> 
> You can refine your test to "if PCI class is display or VGA" and the
> prefetchability is set in the BAR, then elide the guard PTE
> protection bit.

Yes, but I was also thinking about some of those Myrinet kind of things
who also provide large PCI shared memory region ...

I may end up adding an explicit list of classes/vid/did that are
"allowed" to use the trick to avoid problems.

Ben.


