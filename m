Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTJZMRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 07:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTJZMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 07:17:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14022 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263081AbTJZMRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 07:17:48 -0500
Date: Sun, 26 Oct 2003 13:17:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, daniel@osdl.org,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIOtestingon2.6.0-test7-mm1)
Message-ID: <20031026121742.GC10333@fs.tum.de>
References: <1066869631.1963.46.camel@ibm-c.pdx.osdl.net> <20031023104923.GA11543@in.ibm.com> <20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org> <20031023232006.GH21490@fs.tum.de> <20031023162539.0051249d.akpm@osdl.org> <20031023233700.GJ21490@fs.tum.de> <20031023164638.5c32b80f.akpm@osdl.org> <20031026115719.GA10333@fs.tum.de> <20031026120808.D25595@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026120808.D25595@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 12:08:08PM +0000, Russell King wrote:
> On Sun, Oct 26, 2003 at 12:57:19PM +0100, Adrian Bunk wrote:
> > On Thu, Oct 23, 2003 at 04:46:38PM -0700, Andrew Morton wrote:
> > >...
> > > > -Os has it's benefits on some systems, so it shouldn't be totally hidden 
> > > > under EMBEDDED. OTOH, it's less tested, so only people who know what 
> > > > they are doing should use it (EXPERIMENTAL plus help text).
> > > 
> > > It causes kernels to crash on a major linux distribution.  We need to
> > > either make it very hard to turn on, or just forget it altogether.
> > 
> > The -Os patch with a dependency on EMBEDDED is below.
> > 
> > diffstat output:
> > 
> >  arch/arm/Makefile   |    2 --
> >  arch/h8300/Kconfig  |    4 ++++
> >  arch/h8300/Makefile |    2 +-
> >  Makefile            |    8 +++++++-
> >  init/Kconfig        |   10 ++++++++++
> >  5 files changed, 22 insertions(+), 4 deletions(-)
> 
> So now ARM goes back to not building with -Os.
>...

With this patch ARM should default to -Os.

Could you recheck whether it really doesn't work?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

