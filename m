Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVICK35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVICK35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 06:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVICK35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 06:29:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751407AbVICK34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 06:29:56 -0400
Date: Sat, 3 Sep 2005 18:35:03 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050903103503.GB15239@redhat.com>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <1125728040.3223.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125728040.3223.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 08:14:00AM +0200, Arjan van de Ven wrote:
> On Sat, 2005-09-03 at 13:18 +0800, David Teigland wrote:
> > On Thu, Sep 01, 2005 at 01:21:04PM -0700, Andrew Morton wrote:
> > > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> > > > >   possibly gain (or vice versa)
> > > > > 
> > > > > - Relative merits of the two offerings
> > > > 
> > > > You missed the important one - people actively use it and have been for
> > > > some years. Same reason with have NTFS, HPFS, and all the others. On
> > > > that alone it makes sense to include.
> > > 
> > > Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
> > > the technical reasons for merging gfs[2], ocfs2, both or neither?
> > > 
> > > If one can be grown to encompass the capabilities of the other then we're
> > > left with a bunch of legacy code and wasted effort.
> > 
> > GFS is an established fs, it's not going away, you'd be hard pressed to
> > find a more widely used cluster fs on Linux.  GFS is about 10 years old
> > and has been in use by customers in production environments for about 5
> > years.
> 
> but you submitted GFS2 not GFS.

Just a new version, not a big difference.  The ondisk format changed a
little making it incompatible with the previous versions.  We'd been
holding out on the format change for a long time and thought now would be
a sensible time to finally do it.

This is also about timing things conveniently.  Each GFS version coincides
with a development cycle and we decided to wait for this version/cycle to
move code upstream.  So, we have new version, format change, and code
upstream all together, but it's still the same GFS to us.

As with _any_ new version (involving ondisk formats or not) we need to
thoroughly test everything to fix the inevitible bugs and regresssions
that are introduced, there's nothing new or surprising about that.

About the name -- we need to support customers running both versions for a
long time.  The "2" was added to make that process a little easier and
clearer for people, that's all.  If the 2 is really distressing we could
rip it off, but there seems to be as many file systems ending in digits
than not these days...

Dave

