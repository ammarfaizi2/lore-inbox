Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbULCV77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbULCV77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbULCV77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:59:59 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:55300 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262400AbULCV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:59:53 -0500
Date: Fri, 3 Dec 2004 15:59:27 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tripperda@nvidia.com
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041203215927.GE1709@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 03 Dec 2004 21:59:30.0656 (UTC) FILETIME=[5D8B2600:01C4D983]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry for breaking the email thread, I tried to grab the mbox archive
for responding, but ftp.uwsg.iu.edu seems to be having problems with
the mail archive).

in response to Alan Cox' voiced concerns from Tue Nov 30:

> That would also be a proprietary hook wouldn't it 8)

nvidia really isn't interested in proprietary hooks; such a hook
really wouldn't be good for nvidia or the linux kernel. but we don't
feel that a 32-bit zone is such a hook.

> beyond the supported open source hardware PCI-Express is the
> non-AGPGART user and that is 64bit.

I assume you mean traditional pci in this case, but I remain confused.
the pci spec calls for 32-bits of addressing, although there is an
optional extension for 64-bit bus extension pins. I can't speak for other
pci devices, but all of our pci devices are 32-bit.

additionally, the pci-express spec defines legacy and non-legacy
devices.  legacy devices are only required to address 32-bits, whereas
non-legacy devices are required to handle 64-bit addresses.

> In the video space it's even stranger because DRI doesn't need it

I'm unclear how traditional pci video cards function without being
able to allocate < 32-bit addresses for dma purposes. are the video cards
you've tested 64-bit capable or is dma disabled? what about 32-bit cards? I'm
afraid I don't understand how this isn't an issue.

> it seems a risky path because of the past problems trying to get
> zone balancing working.

I certainly understand the concerns with this, although I was led to
believe that recent 2.6 work made the zone balancing much less
expensive.  is that not the case?

> I can find users for a 512Mb or 1Gb DMA region

there was some brief discussion of this when we originally discussed
32-bit addressing issues, but I don't know if a satisfactory solution was
reached.  If a 1Gb region was prefered for this reason, that should satisfy
nvidia's needs for 32-bit addressing, but I couldn't speak for any other device
drivers.

for reference, the previous discussion was here:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0406.2/2093.html

Thanks,
Terence


