Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVCCSNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVCCSNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVCCSMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:12:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:22201 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262543AbVCCSKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:10:24 -0500
Date: Thu, 3 Mar 2005 10:09:59 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303180959.GA12103@kroah.com>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <Pine.LNX.4.21.0503031226430.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0503031226430.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:52:52PM -0500, Daniel Barkalow wrote:
> On Thu, 3 Mar 2005, Linus Torvalds wrote:
> 
> >  - some very _technical_ and objective rules on patches. And they should 
> >    limit the patches severely, so that people can never blame the sucker 
> >    who does the job. For example, I would suggest that "size" be one hard 
> >    technical rule. If the patch is more than 100 lines (with context) in
> >    size, it's not trivial any more. Really. Two big screenfuls (or four, 
> >    for people who still use the ISO-ANSI standard 80x24 vt100)
> 
> One thing that's worth pointing out is that sometimes the 20-line patch is
> sufficient to solve the problem, but is lousy code. That's fine for a tree
> that will be frozen in a couple of months after only getting little fixes
> to other files, but mainline should get a real fix, which wouldn't be
> acceptable in the sucker tree. So 2.6.(x+1) shouldn't automatically get
> 2.6.x.y. Should reverting a 200-line patch which turned out to need
> another 200 lines to work be acceptable?

It's simple in bk to revert a patch.  So in this instance, when the
2.6.x person pulls in the 2.6.x.y tree, they just revert the offending
patch, and move on.  Actually, the maintainer applying the offending
patch would do it, in their tree, before they sent it to Linus.  Or they
do it by the normal patch way, if they don't use bk.

So, not a problem.

> >    Also, I'd suggest that a _hard_ rule (ie nobody can override it) would 
> >    also be that the problem causes an oops, a hang, or a real security
> >    problem that somebody can come up with an exploit for (ie no "there
> >    could be a two-instruction race" crap. Only "there is a race, and
> >    here's how you exploit it"). The exploit wouldn't need to be full code 
> >    that gets root, but an explanation of it, at least.
> 
> Similar rule for driver patches: you can patch a driver if it makes the 
> device not work (but you couldn't patch the core)?

If it's a bugfix for the core, that met the above rules, I wouldn't mind
it at all.  See the sysfs core patch that made it in between 2.6.11-rc5
and 2.6.11 for such an example.

thanks,

greg k-h
