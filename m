Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262896AbSJATIn>; Tue, 1 Oct 2002 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262895AbSJATIm>; Tue, 1 Oct 2002 15:08:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64774 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262896AbSJATIk>; Tue, 1 Oct 2002 15:08:40 -0400
Date: Tue, 1 Oct 2002 12:16:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0210011210030.1878-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Ingo Molnar wrote:
> 
> the attached (compressed) patch is the next iteration of the workqueue
> abstraction. There are two major categories of changes:

Pease don't introduce more typedefs. They only hide what the hell the 
thing is, which is actively _bad_ for structures, since passing a 
structure by value etc is something that should never be done, for 
example. 

The few saved characters of typing do not actually _buy_ you anything 
else, and only obscures what the thing is.

Also, it's against the Linux coding standard, which does not like adding
magic single-letter suffixes to things - that also is the case for your
strange "_s" suffix for a structure (the real suffix is "_struct").

Remember: typing out something is not bad. It's _especially_ not bad if 
the typing makes it more clear what the thing is.

I've done a global search-and-replace on the patch. The resulting patch is
actually _cleaner_, because it also matches more closely the old code
(which used "struct tq_struct"), so things like tabbed comment alignment
etc tend to be more correct (not always, but closer).

		Linus

