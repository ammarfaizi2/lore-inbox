Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424322AbWKJBKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424322AbWKJBKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424326AbWKJBKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:10:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57314 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424322AbWKJBKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:10:43 -0500
Date: Fri, 10 Nov 2006 12:10:18 +1100
From: David Chinner <dgc@sgi.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: "Igor A. Valcov" <viaprog@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
Message-ID: <20061110011018.GP8394166@melbourne.sgi.com>
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com> <1163095715.5632.102.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163095715.5632.102.camel@xenon.msp.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 12:08:35PM -0600, Russell Cattelan wrote:
> On Thu, 2006-11-09 at 20:30 +0300, Igor A. Valcov wrote:
> > Hello,
> > 
> > For one of our projects we have a test program that measures file
> > system performance by writing up to 1000 files simultaneously. After
> > installing kernel v2.6.16 we noticed that XFS performance dropped by a
> > factor of 5 (tests that took around 4 minutes on kernel 2.6.15 now
> > take around 20 minutes to complete). We then checked all kernels
> > starting from 2.6.16 up to 2.6.19-rc5 with the same unpleasant result.
> > The funny thing about all this is that we chose XFS for that
> > particular project specifically because it was about 5 times faster
> > with the tests than the other file systems. Now they all take about
> > the same time.
> > 
> > I also noticed that I/O barriers were introduced in v2.6.16 and
> > thought they may be the cause, but mounting the file system with
> > 'nobarrier' doesn't seem to affect the performance in any way.
> > 
> > Any thoughts on the matter are appreciated.
> I would try verifying the problem on a non ide disk just
> to confirm the write barrier theory.
> 
> Also file a bug.
> http://oss/sgi.com/bugzilla
> include test case and hard description if possible.

and cc xfs@oss.sgi.com on XFS bug reports ;)

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
