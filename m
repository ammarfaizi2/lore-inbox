Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTDTASZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 20:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDTASZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 20:18:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19640 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263503AbTDTASX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 20:18:23 -0400
Date: Sat, 19 Apr 2003 17:30:21 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK->CVS, kernel.bkbits.net
Message-ID: <20030420003021.GA10547@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20030417162723.GA29380@work.bitmover.com> <b7n46e$dtb$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7n46e$dtb$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 01:52:30PM -0700, H. Peter Anvin wrote:
> Followup to:  <20030417162723.GA29380@work.bitmover.com>
> By author:    Larry McVoy <lm@bitmover.com>
> In newsgroup: linux.dev.kernel
> >
> > It's back up, and the CVS server up to date with the 2.4 2.5 kernels as
> > of a few minutes ago.  The CVS server is at
> > 
> > :pserver:anonymous@kernel.bkbits.net:/home/cvs 
> > 
> > There are linux-2.4/ and linux-2.5/ subdirectories there (should this go in
> > a FAQ someplace or does nobody except Andrea care?).
> 
> It definitely should.

OK, so how about this?  I assume you manage DNS for kernel.org, right?
How about a DNS entry for cvs.kernel.org -> 64.241.2.13?  If you ever
find a machine to host this then you already own cvs.kernel.org and you
can just reset the address.  By the way, I think the bandwidth is pretty
darn low, after all that fuss almost nobody seems to use this, it just
gives them warm fuzzies to know that the history has been captured in
an open format which is worth it if it means no more BK flame wars, eh?

Then whoever maintains the kernel FAQ these days could add something like
this:

SCM access to the kernel trees:
-------------------------------

Linus started using an SCM (source code management) tool called BitKeeper
in February of 2002.  Since BitKeeper isn't free software, he does not
require that anyone else use BitKeeper, he continues to accept patches
just like he always did.  The only difference is that information about
who did what, and maybe why they did it, is recorded and is useful for
learning the source base, tracking down bugs, etc.  Many, but not all,
of the core developers have switched to using BitKeeper because it makes
their life easier in various ways.

Some people haven't switched because BitKeeper isn't free software and
they feel uncomfortable using non-free software as part of working on
the kernel.  That's fine, it's an explicit goal of both Linus and the
BitKeeper developers that nobody is required to use BitKeeper to work
on the kernel.  Some senior developers have decided they'd rather
not use BitKeeper, Alan Cox being a good example.  That's not a problem,
the BitKeeper developers worked with Linus to streamline the importing
of traditional patches so that anyone can work in any way they see fit.

If you want to use BitKeeper (http://www.bitkeeper.com) then the official
trees are maintained on linux.bkbits.net - to get a particular release
try this:

	bk clone bk://linux.bkbits.net/linux-2.4

There was a fair amount of fuss amongst the free software purists,
over the fact that a lot of information that was available in BitKeeper
was lost when Linus provided the traditional tarball releases and patch
updates.  Flame wars happened and when the dust settled, the BitKeeper
folks built a BitKeeper to CVS gateway which captures the bulk of the
information (as of this writing on April 19th 2003 there are 9,311
snapshots captured).  If you would prefer to get your source with 100%
God fearing, politically correct, open source, fully buzzword enabled
software, then you can do this:

	cvs -d:pserver:anonymous@cvs.kernel.org:/home/cvs co linux-2.4

As releases progress, the release numbers will change so some day you might
say

	bk clone bk://linux.bkbits.net/linux-4.2
or
	cvs -d:pserver:anonymous@cvs.kernel.org:/home/cvs co linux-4.2

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
