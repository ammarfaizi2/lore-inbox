Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTKKRrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTKKRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:47:09 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:7078 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S263561AbTKKRrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:47:06 -0500
Date: Tue, 11 Nov 2003 18:46:55 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031111174654.GA28693@hout.vanvergehaald.nl>
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au> <1068469674.734.80.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068469674.734.80.camel@cube>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:07:54AM -0500, Albert Cahalan wrote:
> On Mon, 2003-11-10 at 05:19, Herbert Xu wrote:
> > Albert Cahalan <albert@users.sf.net> wrote:
> > > 
> > > Sure, but do it in a way that's friendly to
> > > all the apps and admins that only know "nice".
> > > 
> > > nice_cpu   sets CPU niceness
> > > nice_net   sets net niceness
> > > nice_disk  sets disk niceness
> > > ...
> > > nice       sets all niceness values at once
> > 
> > That's a user space problem.  No matter what Jens
> > does, you can always make nice(1) do what you said.
> 
> It's not just the nice command. There's a syscall
> interface you know, and lots of apps use it.
> 
> #include <unistd.h>
> int nice(int inc);
> 
> You planning to hack ALL those apps? You'll
> convince BSD-centric developers to include
> this Linux-specific change?

Yes, I really would like all those apps to be hacked.
Because I want to REMOVE those nice() calls, not because I want to
add another piece of functionality that doesn't belong in apps in the
first place.

My opinion is that it's the system administrator's job to assign
nice-values to processes. Apps that do that themselves make the task
of the admin harder, if not impossible.

Regards,
Toon.
