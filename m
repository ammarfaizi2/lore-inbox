Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265448AbSKFA2N>; Tue, 5 Nov 2002 19:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbSKFA2N>; Tue, 5 Nov 2002 19:28:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15860 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265448AbSKFA2M>;
	Tue, 5 Nov 2002 19:28:12 -0500
Date: Tue, 5 Nov 2002 19:34:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: bert hubert <ahu@ds9a.nl>, Peter Chubb <peter@chubb.wattle.id.au>,
       jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
In-Reply-To: <32290000.1036545797@flay>
Message-ID: <Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Nov 2002, Martin J. Bligh wrote:

> It's not a few files if you have large numbers of tasks. It's an 
> interface that fundamentally wasn't designed to scale, and futzing
> around tweaking the thing isn't going to cut it, it needs a different
> design. I'm not proposing throwing out any of the old simple interfaces,
> just providing something efficient as a data gathering interface for
> those people who wish to use it.

That's odd, to say the least.  Userland side is at least linear by
number of tasks, regardless of the way you gather information.  So
I really wonder how opening O(number of tasks) files can show up
when you scale the things up - pure userland parts will grow at
least as fast as that.

