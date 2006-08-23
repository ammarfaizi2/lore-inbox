Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWHWWeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWHWWeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWHWWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:34:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9438 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965246AbWHWWeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:34:11 -0400
Subject: Re: [Devel] [PATCH 1/6] BC: kconfig
From: Matt Helsley <matthltc@us.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, devel@openvz.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rohit Seth <rohitseth@google.com>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <20060823153207.0019aa3f.rdunlap@xenotime.net>
References: <44EC31FB.2050002@sw.ru> <44EC35A3.7070308@sw.ru>
	 <1156370698.12011.55.camel@localhost.localdomain>
	 <1156371222.2510.715.camel@stark>
	 <20060823153207.0019aa3f.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:27:59 -0700
Message-Id: <1156372079.2510.723.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:32 -0700, Randy.Dunlap wrote:
> On Wed, 23 Aug 2006 15:13:42 -0700 Matt Helsley wrote:
> 
> > On Wed, 2006-08-23 at 15:04 -0700, Dave Hansen wrote:
> > > On Wed, 2006-08-23 at 15:01 +0400, Kirill Korotaev wrote:
> > > > --- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
> > > > +++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
> > > > @@ -432,3 +432,5 @@ source "security/Kconfig"
> > > >  source "crypto/Kconfig"
> > > >  
> > > >  source "lib/Kconfig"
> > > > +
> > > > +source "kernel/bc/Kconfig"
> > > ...
> > > > --- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
> > > > +++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
> > > > @@ -432,3 +432,5 @@ source "security/Kconfig"
> > > >  source "crypto/Kconfig"
> > > >  
> > > >  source "lib/Kconfig"
> > > > +
> > > > +source "kernel/bc/Kconfig"
> > > 
> > > Is it just me, or do these patches look a little funky?  Looks like it
> > > is trying to patch the same thing into the same file, twice.  Also, the
> > > patches look to be -p0 instead of -p1.  
> > 
> > They do appear to be -p0
> > 
> > 	They aren't adding the same thing twice to the same file. This patch
> > makes different arches source the same Kconfig.
> 
> Look again.  There are 2 diffstat blocks and 2 of these at least:
> 
> --- ./kernel/bc/Kconfig.bckm	2006-07-28 13:07:38.000000000 +0400
> +++ ./kernel/bc/Kconfig	2006-07-28 13:09:51.000000000 +0400
> @@ -0,0 +1,25 @@
> 
> 
> > 	I seem to recall Chandra suggested that instead of doing it this way it
> > would be more appropriate to add the source line to init/Kconfig because
> > it's more central and arch-independent. I tend to agree.
> 
> ---
> ~Randy

My mistake, Dave is right.

Cheers,
	-Matt Helsley

