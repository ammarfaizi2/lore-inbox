Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVHRSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVHRSLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHRSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:11:04 -0400
Received: from xenotime.net ([66.160.160.81]:32462 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932373AbVHRSLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:11:03 -0400
Date: Thu, 18 Aug 2005 11:11:01 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Steven Rostedt <rostedt@goodmis.org>
cc: Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "" <linux-kernel@vger.kernel.org>, "" <sudoyang@gmail.com>
Subject: Re: compiling only one module in kernel version 2.6?
In-Reply-To: <1124387678.5186.76.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0508181107510.4843-100000@shark.he.net>
References: <4f52331f050816190957cec081@mail.gmail.com> 
 <1124248729.5764.70.camel@localhost.localdomain>  <20050816224101.295806c8.rdunlap@xenotime.net>
  <1124257739.5764.107.camel@localhost.localdomain> 
 <1124258090.5764.109.camel@localhost.localdomain>  <20050818174255.GA8457@mars.ravnborg.org>
 <1124387678.5186.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Steven Rostedt wrote:

> On Thu, 2005-08-18 at 19:42 +0200, Sam Ravnborg wrote:
> > On Wed, Aug 17, 2005 at 01:54:50AM -0400, Steven Rostedt wrote:
> > > On Wed, 2005-08-17 at 01:48 -0400, Steven Rostedt wrote:
> > > > On Tue, 2005-08-16 at 22:41 -0700, Randy.Dunlap wrote:
> > > > >
> > > > > Sam only added make .ko build support very recently,
> > > > > so it could easily depend on what kernel verison Fong is using.
> > > >
> > > > That could very well explain it. I'm doing this on 2.6.13-rc6-rt6
> > > > (2.6.13-rc6 with Ingo's rt6 patch applied).  So I really do have a
> > > > recent kernel.
> > > >
> > >
> > > I just did this on a 2.6.9 vanilla kernel, and it still worked.
> >
> > Hi Steve.
> >
> > make fs/reiserfs/
> > and
> > make fs/reiserfs/resiserfs.ko
> >
> > does not do the same thing. Only the latter result in a .ko file.
>
> I never said I did a "make fs/reiserfs". I did a
> "make SUBDIRS=fs/reiserfs"  which does produce a .ko file.

That command uses an implicit target of all (which is
bzImage + modules), and then SUBDIRS (or M) limits it to
the specified subdir., so it builds all modules in the
specified subdir.
As opposed to what I thought(?) the OP was asking about:
how to build one module only.

I think that we have nailed it enough now, yes?  :)

> But even shorter is to do a "make M=fs/reiserfs", which also works.
>
> But, I guess what was added was the ability to just type the module
> itself.  That's cool, but I haven't had the need to do that (yet).

-- 
~Randy
