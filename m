Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWE3Nwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWE3Nwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWE3Nwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:52:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751504AbWE3Nw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:52:29 -0400
Date: Tue, 30 May 2006 09:52:24 -0400
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530135224.GA3179@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org> <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de> <20060530134450.GF14721@redhat.com> <20060530135059.GA4199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530135059.GA4199@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 03:50:59PM +0200, Jens Axboe wrote:

 > >  > >  > Pretty baffling... cfq has been hammered pretty thoroughly over the
 > >  > >  > last months and _nothing_ has shown up except some performance anomalies
 > >  > >  > that are now fixed. Since daves case (at least) seems to be
 > >  > >  > use-after-free, I'll see if I can reproduce with some contrived case.
 > >  > >  > I'm asuming that picasa forks and exits a lot with submitted io in
 > >  > >  > between than may not have finished at exit.
 > >  > > 
 > >  > > The second time I hit it, was actually during boot up.
 > >  > 
 > >  > Dave, do you have any io scheduler switching going on?
 > > 
 > > Nope, everything set to use CFQ as default, and left that way.
 > 
 > Hrmpf ok, I had hoped perhaps something in your init scripts modified
 > the scheduler value.

grep doesn't show anything in init scripts, and ttbomk, hald isn't messing
with this. (Actually I'm seeing it trigger before that gets started
anyway, so that can't be it).

		Dave

-- 
http://www.codemonkey.org.uk
