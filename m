Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWIOF6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIOF6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 01:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWIOF6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 01:58:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46262 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750784AbWIOF6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 01:58:48 -0400
Date: Fri, 15 Sep 2006 15:58:31 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Message-ID: <20060915055831.GP3034@melbourne.sgi.com>
References: <6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com> <20060914035904.GF3034@melbourne.sgi.com> <450914C4.2080607@gmail.com> <6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com> <20060914090808.GS3024@melbourne.sgi.com> <6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com> <6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com> <6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com> <20060915025745.GM3034@melbourne.sgi.com> <20060914204801.e37a112b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914204801.e37a112b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 08:48:01PM -0700, Andrew Morton wrote:
> On Fri, 15 Sep 2006 12:57:45 +1000
> David Chinner <dgc@sgi.com> wrote:
> 
> > On Thu, Sep 14, 2006 at 07:01:38PM +0200, Michal Piotrowski wrote:
> > > >>
> > > >> I'll build system with gcc 3.4
> > > >
> > > >It's not a compiler issue.
> > > >
> > > >Binary search should solve this mystery.
> > > 
> > > I was wrong - it's in vanilla tree
> > > (http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg1).
> > > 
> > > cat hunt | head -n 3
> > > origin.patch
> > > BAD
> > > libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch
> > 
> > Not sure what this means....
> 
> "BAD" is a bisection point, as per
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt.  So
> just 2.6.18-rc6+origin.patch exhibits the failure.  That is mainline.

Ah - thanks for explaining that for me, Andrew.

Michal, there were several XFS fixes (4, I think) that went into -rc7.  If
-rc6 fails and -rc7 doesn't then we need to check if one of those fixes is
responsible. The crash doesn't match any of the symptoms we've seen from them,
but it's worth checking.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
