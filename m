Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275041AbRJKBd5>; Wed, 10 Oct 2001 21:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJKBdp>; Wed, 10 Oct 2001 21:33:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:31127 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S275041AbRJKBde>; Wed, 10 Oct 2001 21:33:34 -0400
Date: Wed, 10 Oct 2001 19:33:55 -0600
Message-Id: <200110110133.f9B1XtN28012@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
In-Reply-To: <20011010173449.Q10443@turbolinux.com>
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
	<m3elob3xao.fsf@belphigor.mcnaught.org>
	<20011010173449.Q10443@turbolinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Oct 10, 2001  19:11 -0400, Doug McNaught wrote:
> > Lew Wolfgang <wolfgang@sweet-haven.com> writes:
> > > I was looking for some scripts to backup ext2 partitions
> > > to multiple CDR's when I stumbled onto "cdbackup" at
> > > http://www.cableone.net/ccondit/cdbackup/.
> > > 
> > > Alas, there is a warning saying:
> > > 
> > > "WARNING! When using this program under Linux, be sure not to use
> > >  dump with kernels in the 2.4.x series. Using dump on an ext2
> > >  filesystem has a very high potential for causing filesystem
> > >  corruption.  As of kernel version 2.4.5, this has not been
> > >  resolved, and it may not be for some time."
> > 
> > I'm pretty sure this is because dump reads the block device directly
> > (which is cached in the buffer cache), while the file data for cached
> > files lives in the page cache, and the two caches are no longer
> > coherent (as of 2.4).
> 
> In Linus kernels 2.4.11+ the block devices and filesystems all use
> the page cache, so no more coherency issues.

Um, I thought that there wasn't going to be coherency? For example, if
you open /dev/sda and /dev/sda1, they each have a separate cache. I
remember some debate about this, and Linus pointed out how hard it was
to make things coherent.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
