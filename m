Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbULHHUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbULHHUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbULHHT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:19:59 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:55673 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262047AbULHHT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:19:57 -0500
Subject: Re: Time sliced CFQ io scheduler
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208071141.GB19522@suse.de>
References: <20041202130457.GC10458@suse.de>
	 <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org>
	 <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random>
	 <1102467253.8095.10.camel@npiggin-nld.site>
	 <20041208013732.GF16322@dualathlon.random>
	 <20041207180033.6699425b.akpm@osdl.org> <20041208065534.GF3035@suse.de>
	 <1102489719.8095.56.camel@npiggin-nld.site>
	 <20041208071141.GB19522@suse.de>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 18:19:49 +1100
Message-Id: <1102490389.8095.69.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 08:11 +0100, Jens Axboe wrote:
> On Wed, Dec 08 2004, Nick Piggin wrote:
> > On Wed, 2004-12-08 at 07:55 +0100, Jens Axboe wrote:

> > > Currently I think the time sliced cfq is the best all around. There's
> > > still a few kinks to be shaken out, but generally I think the concept is
> > > sounder than AS.
> > > 
> > 
> > But aren't you basically unconditionally allowing a 4ms idle time after
> > reads? The complexity of AS (other than all the work we had to do to get
> > the block layer to cope with it), is getting it to turn off at (mostly)
> > the right times. Other than that, it is basically the deadline
> > scheduler.
> 
> Yes, the concept is similar and there will be time wasting currently.
> I've got some cases covered that AS doesn't, and there are definitely
> some the other way around as well.
> 

Oh? What have you got covered that AS doesn't? (I'm only reading the
patch itself, which isn't trivial to follow).

> If you have any test cases/programs, I'd like to see them.
> 

Hmm, damn. Lots of stuff. I guess some of the notable ones that I've
had trouble with are OraSim (Oracle might give you a copy), Andrew's
patch scripts when applying a stack of patches, pgbench... can't
really remember any others off the top of my head.

I've got a small set of basic test programs that are similar to the
sort of tests you've been running in this thread as well.


