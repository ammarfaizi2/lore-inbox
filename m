Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTIHSym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbTIHSym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:54:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:14502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263496AbTIHSyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:54:40 -0400
Date: Mon, 8 Sep 2003 11:54:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
In-Reply-To: <20030908204023.A1060@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.44.0309081152180.3202-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Andries Brouwer wrote:

> On Mon, Sep 08, 2003 at 08:13:53AM -0700, Linus Torvalds wrote:
> 
> > I'd _much_ rather have a comment than make up some new "bad define" thing.
> 
> Pity.

Note that Arnd's "extra-anal check" added a XXX_BAD() define after all, 
and I ended up accepting that one, because it had a totally valid usage: 
it fixed a real issue not with bad type passing, but with passing types 
that are too _big_. 

I fixed two cases that I found where this was the case, there might be
others (I did a maxconfig, but on SMP. There might be some UP-only driver
that is affected by this).

But I'm too lazy to go back and fix up the older fixes, so..

		Linus

