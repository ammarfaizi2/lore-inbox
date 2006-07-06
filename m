Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWGFQWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWGFQWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWGFQWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:22:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030303AbWGFQWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:22:42 -0400
Date: Thu, 6 Jul 2006 09:22:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Keenan <matt.keenan@btinternet.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
In-Reply-To: <44ACDB94.4040201@btinternet.com>
Message-ID: <Pine.LNX.4.64.0607060914300.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
 <44ACDB94.4040201@btinternet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Matt Keenan wrote:
>
> > Git users should generally just select the part they are interested in, and
> > do something like
> > 
> > 	git log v2.6.17.. -- drivers/usb/ | git shortlog | less -S
> > 
> > to get a better and more focused view of what has changed.
> >   
> [snip snip]
> 
> Is it possible to get a URL to a shortlog on a web git somewhere? Has this
> information been posted before and I have missed it?

The most recent version of "gitweb" can actually do this kind of thing for 
you on the web, but the version currently installed on kernel.org only 
does it per-file, not per directory, making it less useful.

I suspect it will get upgraded one of these days, and when it does, you 
can generate the above kind of listing without even having git installed 
by going to

	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git

and then selecting the "tree" view (it defaults to "summary" - see the top 
line that says "summary"/"shortlog"/"log"/"commit"/"commitdiff"/"tree", 
and select "tree" from there). Then you can walk down the tree, and when 
you find the file (or, eventually, directory) you are interested in, click 
on "history".

So even without git, you can get a lot of this kind of information. 
However, with just the web interface, you do lose a lot of browsing 
capability, like browsing multiple files/directories at the same time, and 
doing things like limiting the output since just a particular version.

So you could  just get git on your own, and read the docs, and play with 
it. The place to start is probably the git homepage:

	http://git.or.cz/

(also look up the Wiki there - click on "Wiki" in the header to see some 
Wiki resources that probably get updated a bit more often than the home 
page itself).

			Linus
