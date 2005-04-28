Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVD1Wsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVD1Wsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVD1Wsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:48:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:20971 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262319AbVD1Wss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:48:48 -0400
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20050428151117.GB10171@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org>
	 <20050427223702.21051afc.davem@davemloft.net>
	 <1114670353.7182.246.camel@gaston>
	 <20050427235056.0bd09a94.davem@davemloft.net>
	 <20050428151117.GB10171@colo.lackof.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 08:47:27 +1000
Message-Id: <1114728447.7182.262.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 09:11 -0600, Grant Grundler wrote:

> 
> > Anyways, what I'm trying to say is that blinding turning prefetchable
> > BAR into "don't set side effect bit in PTE" might not be so wise.
> > 
> > I really think it's a userlevel decision.  That's where all the ioctl()
> > garbage came from for the /proc/bus/pci mmap() stuff.  It was for chossing
> > IO vs MEM space, and also for setting these kinds of mapping attributes.
> 
> Well, if it's a device driver decision, I guess that's ok.
> And the primary device driver happens to live in user space in X.org case.

Agreed, but 1) Do you have an idea on how to expose this capability with
the sysfs interface ? Adding ioctl's to it would suck big time :) and 2)
It's still nice to have a "workaround" for existing X since the
performance benefit is significant, but then, it's in arch code, so
that's fine (and I could indeed limit it to VGA class devices as David
suggests).

Ben.


