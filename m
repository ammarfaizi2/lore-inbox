Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTEWBEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTEWBEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:04:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29845 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263567AbTEWBEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:04:48 -0400
Date: Fri, 23 May 2003 02:17:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [patch?] truncate and timestamps
Message-ID: <20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
References: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 05:30:33PM -0700, Linus Torvalds wrote:
> 
> On Fri, 23 May 2003 Andries.Brouwer@cwi.nl wrote:
> > 
> > On the other hand, my question was really a different one:
> > do we want to follow POSIX, also in the silly requirement
> > that truncate only sets mtime when the size changes, while
> > O_TRUNC and ftruncate always set mtime.
> 
> Does POSIX really say that? What a crock. If so, we should probably add 
> the ATTR_xxx mask as an argument to do_truncate() itself, and then make 
> sure that may_open() sets the ATTR_MTIME bit.

"POSIX says" has value only if there is at least some consensus among
implementations.  Otherwise it's worthless, simply because any program
that cares about portability can't rely on specified behaviour and
any program that doesn't couldn't care less anyway - it will rely on
actual behaviour on system it's supposed to run on.

Andries had shown that there is _no_ consensus.  Ergo, POSIX can take
a hike and we should go with the behaviour convenient for us.  It's that
simple...

