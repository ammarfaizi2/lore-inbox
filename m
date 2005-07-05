Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVGET0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVGET0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVGET0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:26:33 -0400
Received: from frontend-1.hamburg.de ([212.1.41.126]:63967 "EHLO
	lee.int-rz.hamburg.de") by vger.kernel.org with ESMTP
	id S261500AbVGETZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:25:10 -0400
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
Date: Tue, 5 Jul 2005 21:24:48 +0200
User-Agent: KMail/1.8.1
Cc: Sonny Rao <sonny@burdell.org>, Al Boldi <a1426z@gawab.com>,
       "'Jens Axboe'" <axboe@suse.de>, "'David Masover'" <ninja@slaphack.com>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <20050705154919.GA13262@kevlar.burdell.org> <200507051725.UAA07417@raad.intranet> <20050705181057.GA16422@kevlar.burdell.org>
In-Reply-To: <20050705181057.GA16422@kevlar.burdell.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507052124.49199.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. Juli 2005 20:10 schrieb Sonny Rao:
> On Tue, Jul 05, 2005 at 08:25:11PM +0300, Al Boldi wrote:
> > Sonny Rao wrote: {
> >
> > > > >On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> > > > >>What I found were 4 things in the dest dir:
> > > > >>1. Missing Dirs,Files. That's OK.
> > > > >>2. Files of size 0. That's acceptable.
> > > > >>3. Corrupted Files. That's unacceptable.
> > > > >>4. Corrupted Files with original fingerprint. That's ABSOLUTELY
> > > > >>unacceptable.
> > >
> > > 2. Moral of the story is: What's ext3 doing the others aren't?
> >
> > Ext3 has stronger guaranties than basic filesystem consistency.
> > I.e. in ordered mode, file data is always written before metadata, so the
> > worst that could happen is a growing file's new data is written but the
> > metadata isn't updated before a power failure... so the new writes
> > wouldn't be seen afterwards.
> >
> > }
> >
> > Sonny,
> > Thanks for you input!
> > Is there an option in XFS,ReiserFS,JFS to enable ordered mode?
>
> I beleive in newer 2.6 kernels that Reiser has ordered mode (IIRC, courtesy
> of Chris Mason),

And SuSE, ack.

ftp://ftp.suse.com/pub/people/mason/patches/data-logging

They are around some time ;-)

> but XFS and JFS do not support it.  I seem to remember 
> Shaggy (JFS maintainer) saying in older 2.4 kernels he tried to write
> file data before metadata but had to change that behavior in 2.6, not
> really sure why or anything beyond that.

Greetings,
	Dieter

-- 
Dieter Nützel
@home: <Dieter () nuetzel-hh ! de>
