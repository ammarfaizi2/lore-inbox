Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVD0ElO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVD0ElO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVD0ElO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:41:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:35027 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261913AbVD0EkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:40:22 -0400
Subject: Re: pci-sysfs resource mmap broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com
In-Reply-To: <20050426212859.40c14c36.davem@davemloft.net>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <20050427035535.GI2612@colo.lackof.org> <1114576221.7182.140.camel@gaston>
	 <20050426212859.40c14c36.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 14:39:37 +1000
Message-Id: <1114576777.7112.143.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 21:28 -0700, David S. Miller wrote:
> On Wed, 27 Apr 2005 14:30:21 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > True, but then, I tend to prefer you idea of a CPU view ... so my new
> > "proposal" is something like pci_resource_to_user() implementation.
> > Anyway, wait a bit so I can polish this patch and tell me what you
> > think :)
> 
> I know that in particular I don't need to tell you this Ben,
> but just in case please make sure it handles the 64-bit
> kernel 32-bit userspace properly :-)

Well, I'm not changing /proc here, it will stay broken, but sysfs
already always exposes 64 bits and I won't change this. I'm also making
sure that can deal with 32 bits kernels with >32 bits IO space.

> I'm very happy someone is working on this issue.
> So don't get discouraged :)

Ok, cool. Please comment on my email/patch (coming real soon now) as
it's really more an RFC than a final fix at this point.

Ben.


