Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWA3AvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWA3AvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWA3AvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:51:06 -0500
Received: from xenotime.net ([66.160.160.81]:2529 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751213AbWA3AvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:51:05 -0500
Date: Sun, 29 Jan 2006 16:51:23 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060129165123.58b62b36.rdunlap@xenotime.net>
In-Reply-To: <20060129235853.GD3777@stusta.de>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060129233403.GA3777@stusta.de>
	<20060129154002.360c7294.rdunlap@xenotime.net>
	<20060129235853.GD3777@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006 00:58:53 +0100 Adrian Bunk wrote:

> On Sun, Jan 29, 2006 at 03:40:02PM -0800, Randy.Dunlap wrote:
> > On Mon, 30 Jan 2006 00:34:03 +0100 Adrian Bunk wrote:
> > 
> > > On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.16-rc1-mm3:
> > > >...
> > > > +i386-add-a-temporary-to-make-put_user-more-type-safe.patch
> > > > 
> > > >  x86 fixes/features
> > > >...
> > > 
> > > This patch generates so many "ISO C90 forbids mixed declarations and code"
> > > warnings that I start to consider Andrew's rejection of my "mark 
> > > virt_to_bus/bus_to_virt as __deprecated on i386" patch due to the 
> > > warnings it generates a personal insult...
> > 
> > I prefer to think of it as reasons why neither of them
> > should be merged.
> 
> 
> Some remarks:
> 
> 
> I forgot the smiley.

OK.  I guess I should not have replied at all then.

> If we want to get rid of a long deprecated API (as in the 
> virt_to_bus/bus_to_virt case), adding warnings could help making 
> maintainers aware of the fact that the API is deprecated.

I seriously expect that the maintainers are already aware
of that.  It's not new(s).

> In such cases the warnings are supposed to be present only temporarily 
> until the code using the deprecated API got fixed.
> 
> It might not be visible for people only using allyesconfig/allmodconfig, 
> but BROKEN_ON_SMP drivers often spit screenfuls of warnings. That's OK, 
> and most of them have been fixed during the last years.
> 
> And otherwise, we could simply remove __deprecated from the kernel.
> 
> Andrew rejected my patch to add -Werror-implicit-function-declaration to 
> the CFLAGS which helps us to avoid a certain class of nasty runtime 
> errors because it turned virt_to_bus/bus_to_virt link errors on powerpc 
> into compile errors (sic).
> 
> 
> > ~Randy
> 
> cu
> Adrian


---
~Randy
