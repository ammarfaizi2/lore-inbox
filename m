Return-Path: <linux-kernel-owner+w=401wt.eu-S1754706AbXAAVWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbXAAVWY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbXAAVWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:22:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44297 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754706AbXAAVWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:22:23 -0500
Date: Mon, 1 Jan 2007 21:31:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Message-ID: <20070101213152.2cfc51c2@localhost.localdomain>
In-Reply-To: <459973F6.2090201@pobox.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * I was unable to argue against Alan's logic behind 
> 368c73d4f689dae0807d0a2aa74c61fd2b9b075f but I just don't like it. 
> Regardless of whether or not this truly reflects how the PCI device is 
> wired, it makes pci_request_regions() and similar resource handling code 
> behave differently.

Correctly: The resource tree is no longer corrupt for example and
pci_* resource functions actually now do the right thing. The old code
works by chance due to link order, not because anything was "broken" by
the corrections.

> * Alan proposed a libata fix patch.  I noted two key breakages in his 
> fix patch, one of which Alan agreed was a problem.

Not a "2.6.20 stopping problem" and trivial to fix further.

> So I vote for revert, for 2.6.20, but I know Alan will squawk loudly. 
> Also NOTE thoughfb0f2b40faff41f03acaa2ee6e6231fc96ca497c which fixes 
> fallout from Alan's change, too.

I'm very concerned about what that will break that depends upon it - eg
all the work done for suspend/resume PCI handling has not been tested
without the patch. Thus I'd rather fix it given the fix is trivial.

Want a fix Linus given Jeff is away ?

Alan
