Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbSLRAo6>; Tue, 17 Dec 2002 19:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSLRAo5>; Tue, 17 Dec 2002 19:44:57 -0500
Received: from havoc.daloft.com ([64.213.145.173]:15512 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267042AbSLRAo5>;
	Tue, 17 Dec 2002 19:44:57 -0500
Date: Tue, 17 Dec 2002 19:52:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: kill pdev_enable_device()
Message-ID: <20021218005250.GA27607@gtf.org>
References: <20021217201938.A16940@jurassic.park.msu.ru> <3DFFA5DD.4030804@pobox.com> <20021218004226.GA3204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218004226.GA3204@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 12:42:26AM +0000, Dave Jones wrote:
> On Tue, Dec 17, 2002 at 05:31:57PM -0500, Jeff Garzik wrote:
>  > Ivan Kokshaysky wrote:
>  > >- So, if we don't touch the PCI command registers, there is no point in
>  > >  using pdev_enable_device(). Most drivers properly use
>  > >  pci_enable_device() anyway.
>  > Not only that, a driver _should_ be calling pci-enable-device, it's an 
>  > API requirement.  J Random Driver should have a good reason _not_ to 
>  > call pci_enable_device() ...
> 
> What about the xircom issue that was discussed in the last days ?
> Sounds like the solution isn't a full on pci_enable_device() as
> pcmcia 'knows better than us' at that stage aparently.

The solution in the driver is almost always pci_enable_device().

That recent issue was related to subsystem code not driver code;
for that specific situation, you are absolutely right:
pci_enable_device is not the right thing to do.

	Jeff



