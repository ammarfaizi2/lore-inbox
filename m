Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278091AbRJKEZz>; Thu, 11 Oct 2001 00:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278090AbRJKEZp>; Thu, 11 Oct 2001 00:25:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8856 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278089AbRJKEZh>; Thu, 11 Oct 2001 00:25:37 -0400
Date: Wed, 10 Oct 2001 22:25:54 -0600
Message-Id: <200110110425.f9B4PsG29656@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Chris Mason <mason@suse.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
In-Reply-To: <1160370000.1002764921@tiny>
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
	<m3elob3xao.fsf@belphigor.mcnaught.org>
	<20011010173449.Q10443@turbolinux.com>
	<200110110133.f9B1XtN28012@vindaloo.ras.ucalgary.ca>
	<1160370000.1002764921@tiny>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason writes:
> 
> 
> On Wednesday, October 10, 2001 07:33:55 PM -0600 Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
> 
> > Andreas Dilger writes:
> 
> >> In Linus kernels 2.4.11+ the block devices and filesystems all use
> >> the page cache, so no more coherency issues.
> > 
> > Um, I thought that there wasn't going to be coherency? For example, if
> > you open /dev/sda and /dev/sda1, they each have a separate cache. I
> > remember some debate about this, and Linus pointed out how hard it was
> > to make things coherent.
> 
> They all use the page cache, but they still use different address
> spaces.

OK, different "address spaces". I didn't recall the precise
terminology :-)

> The block device and getblk share the same address space, so the metadata
> and the block device are on the same cache, except for ext2 directories,
> which act like files do.  Each file has its own address space, so that
> isn't coherent with the block device.
> 
> In other words, block device reads with the FS mounted will probably
> never give consistent results.

Indeed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
