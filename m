Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVJ3O3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVJ3O3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJ3O3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:29:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59817 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932069AbVJ3O3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:29:22 -0500
Date: Sun, 30 Oct 2005 06:29:24 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Madore <michael.madore@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: high address but no IOMMU
Message-ID: <20051030142924.GA30183@us.ibm.com>
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <p73slum38rw.fsf@verdi.suse.de> <d4b6d3ea0510271539t782582ddpb13d1a9e13a84f9c@mail.gmail.com> <20051028015900.GB4141@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028015900.GB4141@us.ibm.com>
X-Operating-System: Linux 2.6.14 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2005 [18:59:00 -0700], Nishanth Aravamudan wrote:
> On 27.10.2005 [15:39:20 -0700], Michael Madore wrote:
> > On 28 Oct 2005 00:16:51 +0200, Andi Kleen <ak@suse.de> wro> >
> > > > Checking aperture...
> > > > CPU 0: aperture @ 8000000 size 32 MB
> > > > Aperture from northbridge cpu 0 too small (32 MB)
> > > > No AGP bridge found
> > > > Your BIOS doesn't leave a aperture memory hole
> > > > Please enable the IOMMU option in the BIOS setup
> > > > This costs you 64 MB of RAM
> > > > Mapping aperture over 65536 KB of RAM @ 8000000
> > > >
> > > > ...
> > > >
> > > > PCI-DMA: Disabling AGP.
> > > > PCI-DMA: aperture base @ 8000000 size 65536 KB
> > > > PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> > >
> > > Can you post the full boot log?
> > >
> > 
> > Hi Andy,
> > 
> > Here is the full boot log from 2.6.14-rc5.
> 
> Just as another datapoint, here is mine (ignore the inode issues, they
> are due to a power failure yesterday):

Ah, silly me, I set IOMMU_DEBUG to Y at some point without realizing.
Taking that away removed the issues and I now only get:

[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ 4000000 size 32 MB
[    0.000000] Aperture from northbridge cpu 0 too small (32 MB)
[    0.000000] No AGP bridge found

...

[   47.737770] PCI-DMA: Disabling IOMMU.

Which makes a lot more sense.

Sorry for the noise.

Thanks,
Nish
