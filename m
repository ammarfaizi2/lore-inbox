Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVD0DxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVD0DxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 23:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVD0DxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 23:53:10 -0400
Received: from colo.lackof.org ([198.49.126.79]:17892 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261904AbVD0DxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 23:53:06 -0400
Date: Tue, 26 Apr 2005 21:55:35 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com
Subject: Re: pci-sysfs resource mmap broken
Message-ID: <20050427035535.GI2612@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston> <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114555655.7183.81.camel@gaston>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 08:47:34AM +1000, Benjamin Herrenschmidt wrote:
> No. I don't agree. userspace has no business understanding the kernel
> resources content.

Sorry - you are right. Userspace doesn't need to understand kernel
resources. It just needs some sort of handle so it can talk
to the device in whatever way is appropriate. I was thinking
the resource content (which happens to be CPU View of a BAR)
could be that handle.

...
> The only thing I dislike a bit is that forces me to read the BAR on
> every access to "un-offset" the kernel resource. We may be able to have
> some arch hook do that properly, but for now, that would fix the problem
> and make the whole stuff work again.


What is wrong with reading the BAR?
Is the "IO View" needed in the performance path someplace?

It should be trivial since config space is exported via /sys and /proc.
libpci probably already has everything that's needed.

grant
