Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWBOJws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWBOJws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWBOJws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:52:48 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:22674 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751053AbWBOJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:52:47 -0500
Date: Wed, 15 Feb 2006 10:52:46 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove duplicate #includes
Message-ID: <20060215095246.GC28677@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
References: <20060213093959.GA10496@MAIL.13thfloor.at> <20060214220313.1158be5b.khali@linux-fr.org> <20060214132133.0c48f874.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214132133.0c48f874.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:21:33PM -0800, Andrew Morton wrote:
> Jean Delvare <khali@linux-fr.org> wrote:
> >
> > Hi Herbert,
> > 
> > > recently I stumbled over a few files which #include the 
> > > same .h file twice -- sometimes even in the immediately
> > > following line. so I thought I'd look into that to reduce 
> > > the amount of duplicate includes in the kernel ...
> > > (...)
> > > diff -NurpP --minimal linux-2.6.16-rc2/drivers/macintosh/therm_pm72.c linux-2.6.16-rc2-mpf/drivers/macintosh/therm_pm72.c
> > > --- linux-2.6.16-rc2/drivers/macintosh/therm_pm72.c	2006-02-07 11:52:31 +0100
> > > +++ linux-2.6.16-rc2-mpf/drivers/macintosh/therm_pm72.c	2006-02-13 02:07:58 +0100
> > > @@ -104,7 +104,6 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/sched.h>
> > > -#include <linux/i2c.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/init.h>
> > >  #include <linux/spinlock.h>
> > 
> > This one was already taken care of in a different patch:
> > 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/broken-out/macintosh-cleanup-the-use-of-i2c-headers.patch
> > 
> > So please exclude this part from your patch so as to avoid collisions.
> > 
> 
> Is OK. I'll stage the big cleanup patches like this after everyone
> else's patches, so all that is left in this patch is stuff which
> doesn't intersect with anyone else's work.
>
> That's one of the advantages of having everyone's development trees
> all in one place. (And people who run development trees which aren't
> in -mm lose).

okay, after Arthurs input regarding the script, I'll
investigate this a little more and come up with a more
detailed list of duplicate includes, maybe categorized
by type of duplicate inclusion direct/indirect and by
subsystem/architecture if that is desired?

any input here would be appreciated, even if it just
is something like: "hey, we do not want this kind of
cleanup done in the kernel" ...

best,
Herbert

