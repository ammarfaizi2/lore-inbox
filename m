Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264740AbSJ3RA4>; Wed, 30 Oct 2002 12:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264744AbSJ3RA4>; Wed, 30 Oct 2002 12:00:56 -0500
Received: from 216-42-72-152.ppp.netsville.net ([216.42.72.152]:56456 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S264740AbSJ3RAz>;
	Wed, 30 Oct 2002 12:00:55 -0500
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch 
	time"series.)
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       torvalds@transmeta.com, Nikita Danilov <Nikita@namesys.com>,
       landley@trommello.org, linux-kernel@vger.kernel.org
In-Reply-To: <3DBFA7E3.345690B2@digeo.com>
References: <200210280534.16821.landley@trommello.org>
	<15805.27643.403378.829985@laputa.namesys.com>
	<3DBF9600.4060208@namesys.com> <3DBF9BA5.6000100@pobox.com> 
	<3DBFA7E3.345690B2@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Oct 2002 12:06:57 -0500
Message-Id: <1035997617.14236.82.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 04:35, Andrew Morton wrote:
> Jeff Garzik wrote:
> > 
> > Hans Reiser wrote:
> > 
> > > We are going to submit a patch appropriate for inclusion as an
> > > experimental FS on Halloween.   I hope you will forgive our pushing
> > > the limit timewise, it is not by choice, but the algorithms we used to
> > > more than double reiserfs V3 performance were, quite frankly, hard to
> > > code.
> > 
> > Does your merge change the core code at all?  Does it add new syscalls?
> > 
> 
> Their changes are tiny, and sensible.  See
> http://www.namesys.com/snapshots/2002.10.29/
> 
> But I'd like to ask about the status of reiser3 support.
> 
> Chris had patches *ages* ago to convert it to use direct-to-BIO for
> reads, and writes should be done as well.  reiserfs3 is still using
> buffer-head-based IO for bulk reads and writes.  That's a 25-30% hit
> in CPU cost, and all the old ZONE_NORMAL-full-of-buffer_heads
> problems.
> 
> Any plans to get that work finished off?

Very much so, but I wanted it on top of the data journaling stuff to
make porting that easier.  But, in the interest in getting something
more stable and faster out the door asap, I'll pull just the
direct-to-BIO stuff out.

-chris


