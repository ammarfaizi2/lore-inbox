Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVCCIGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVCCIGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCCIGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:06:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:43434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261552AbVCCIFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:05:30 -0500
Date: Thu, 3 Mar 2005 00:04:59 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303080459.GA29235@kroah.com>
References: <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4226C235.1070609@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:52:21AM -0500, Jeff Garzik wrote:
> 2.6.x.y has a very real engineering benefit:  it becomes a stable 
> release branch.  That will encourage even more users to test it, over 
> and above a simple release naming change.
> 
> Users have been clamoring for a stable release branch in any case, as 
> you see from comments about Alan's -ac and an LKML user's -as kernels.

Sure they've been asking for it, but I think they really don't know what
it entails.  Look at all of the "non-stable" type patches in the -ac and
as tree.  There's a lot of stuff in there.  It's a slippery slope down
when trying to say, "I'm only going to accept bug fixes." 

Bug fixes for what?  Kernel api changes that fix bugs?  That's pretty
big.  Some driver fixes, but not others?  Driver fixes that are in the
middle of bigger, subsystem reworks as a series of patches?  All of this
currently happens today in the main tree in a semi-cohesive manner.  To
try to split it out is a very difficult task.

So, while I like the _idea_ of the 2.6.x.y type releases, having those
releases contain anything but a handful of patches will quickly get
quite messy.

Not to mention the issue of the need for me as a maintainer to mark
"bugfix only" specific patches and pull them out and submit them
separately.  Due to api changes, and all sorts of other issues, that can
get to be a difficult job in itself.

Personally, I like the current, "test it all in -mm and then forward the
good bits to Linus" mode we are operating in.  My only suggestion would
to possibly speed up the release cycle a bit faster than every two
months, like we currently are on.  Once a month perhaps?  That was how
we were working at the beginning of 2.6, and it seemed like the backlog
was much smaller then.

thanks,

greg k-h
