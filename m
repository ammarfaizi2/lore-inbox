Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTK2Crw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 21:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTK2Crw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 21:47:52 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:36100 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S263620AbTK2Crv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 21:47:51 -0500
Date: Fri, 28 Nov 2003 20:47:54 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Parallel build not working since -test6?
In-Reply-To: <200311282126.59634.sam@ravnborg.org>
Message-ID: <Pine.LNX.4.58.0311282039170.23104@uberdeity>
References: <02d801c3b474$e09e42a0$02c8a8c0@steinman> <200311282126.59634.sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Nov 2003, Sam Ravnborg wrote:

> On Thursday 27 November 2003 00:27, Adam Kropelin wrote:
> > Lately I've noticed my kernel compilations taking longer than usual.
> > Tonight I finally realized the cause... Parallel building (i.e. make -jN)
> > is no longer working for me. I traced it back and the last kernel it worked
> > in was -test5. It ceased working in -test6.
> It works for me, and for sure it works for most others. Otherwise I would
> have seen lot of complaints like yours.
> I recall one similar post, and the person in question used a homegrown
> script that caused the problems.

Well, this explains why 2.6.x builds so much slower here than it did a few
kernels ago.

make -j3 improves things.  but currently, make -j2 doesn't use both my
cpus.

no scripts, just make -j2 bzImage
