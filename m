Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbULHGud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbULHGud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULHGud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:50:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54937 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261762AbULHGu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:50:27 -0500
Date: Wed, 8 Dec 2004 07:49:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208064925.GD3035@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102467253.8095.10.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2004, Nick Piggin wrote:
> On Wed, 2004-12-08 at 01:37 +0100, Andrea Arcangeli wrote:
> > On Thu, Dec 02, 2004 at 08:52:36PM +0100, Jens Axboe wrote:
> > > with its default io scheduler has basically zero write performance in
> > 
> > IMHO the default io scheduler should be changed to cfq. as is all but
> > general purpose so it's a mistake to leave it the default (plus as Jens
> 
> I think it is actually pretty good at general purpose stuff. For
> example, the old writes starve reads thing. It is especially bad
> when doing small dependent reads like `find | xargs grep`. (Although
> CFQ is probably better at this than deadline too).

Time sliced cfq fixes this.

> It also tends to degrade more gracefully under memory load because
> it doesn't require much readahead.

Ditto.

> > found the write bandwidth is not existent during reads, no surprise it
> > falls apart in any database load). We had to make the cfq the default
> > for the enterprise release already. The first thing I do is to add
> > elevator=cfq on a new install. I really like how well cfq has been
> > designed, implemented and turned, Jens's results with his last patch are
> > quite impressive.
> > 
> 
> That is synch write bandwidth. Yes that seems to be a problem.

A pretty big one :-)

-- 
Jens Axboe

