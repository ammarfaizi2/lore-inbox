Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274902AbTGaX1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274910AbTGaX1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:27:30 -0400
Received: from users.ccur.com ([208.248.32.211]:18867 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S274902AbTGaX0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:26:20 -0400
Date: Thu, 31 Jul 2003 19:26:03 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731232603.GD7852@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com> <1059692548.931.329.camel@localhost> <20030731230635.GA7852@rudolph.ccur.com> <1059693499.786.1.camel@localhost> <20030731231627.GC7852@rudolph.ccur.com> <1059694079.786.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059694079.786.7.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-07-31 at 16:16, Joe Korty wrote:
> 
> > Actually it is only 20 lines of changes .. 16 lines added, 4 deleted.
> 
> I know. But 16 new lines, including a new process flag, seems overkill.
> That is all I am saying. Just my opinion.
> 
> There are a _lot_ of things root can do wrong.
> 
> 	Robert Love


Hi Robert,
I don't consider SYS_CAP_NICE to be a typical 'root' thing at all.
Everything realtime needs it as part of normal operations.  I think
of it as an intermediate thing between 'ordinary desktop users' and
'root', and as such it should behave nicely, just like the
plain-vanilla services available to ordinary users.

I believe it is suboptimal to lump everything a normal desktop user
wouldn't normally do as 'root -- let the user beware'.

Joe
