Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJWXhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTJWXhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:37:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5076 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261879AbTJWXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:37:03 -0400
Date: Fri, 24 Oct 2003 01:37:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testingon2.6.0-test7-mm1)
Message-ID: <20031023233700.GJ21490@fs.tum.de>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net> <20031020142727.GA4068@in.ibm.com> <1066693673.22983.10.camel@ibm-c.pdx.osdl.net> <20031021121113.GA4282@in.ibm.com> <1066869631.1963.46.camel@ibm-c.pdx.osdl.net> <20031023104923.GA11543@in.ibm.com> <20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org> <20031023232006.GH21490@fs.tum.de> <20031023162539.0051249d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023162539.0051249d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 04:25:39PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > On Thu, Oct 23, 2003 at 03:59:37PM -0700, Andrew Morton wrote:
> > > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > > >
> > > > It turns out that backing out gcc-Os.patch (on RH 9) or switching 
> > > > to a system with an older compiler version made those errors go away.
> > > 
> > > Ho hum, so we have our answer.
> > > 
> > > Adrian, how do you feel about slotting this under CONFIG_EMBEDDED?
> > 
> > That was in the first version of the patch, but Christoph Hellwig asked 
> > to drop the EMBEDDED.
> 
> That was before we knew that it craps out when compiled on RH9.

And one of the arguments I had for making it dependent on EXPERIMENTAL 
instead of enabling it unconditionally was:

- it's less tested (there might be miscompilations in some part of the
  kernel with some supported compilers)

-Os has it's benefits on some systems, so it shouldn't be totally hidden 
under EMBEDDED. OTOH, it's less tested, so only people who know what 
they are doing should use it (EXPERIMENTAL plus help text).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

