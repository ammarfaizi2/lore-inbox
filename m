Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVECB3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVECB3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVECB3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:29:47 -0400
Received: from waste.org ([216.27.176.166]:47545 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261282AbVECB3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:29:40 -0400
Date: Mon, 2 May 2005 18:29:21 -0700
From: Matt Mackall <mpm@selenic.com>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050503012921.GD22038@waste.org>
References: <3YQn9-8qX-5@gated-at.bofh.it> <3ZLEF-56n-1@gated-at.bofh.it> <3ZM7L-5ot-13@gated-at.bofh.it> <3ZN3P-69A-9@gated-at.bofh.it> <3ZNdz-6gK-9@gated-at.bofh.it> <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 03:16:26AM +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> > On Mon, 2 May 2005, Ryan Anderson wrote:
> >> On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> 
> >> > That said, I think the /usr/bin/env trick is stupid too. It may be more
> >> > portable for various Linux distributions, but if you want _true_
> >> > portability, you use /bin/sh, and you do something like
> >> > 
> >> > #!/bin/sh
> >> > exec perl perlscript.pl "$@"
> >> if 0;
> 
> exec may fail.
> 
> #!/bin/sh
> exec perl -x $0 ${1+"$@"} || exit 127
> #!perl
> 
> >> You don't really want Perl to get itself into an exec loop.
> > 
> > This would _not_ be "perlscript.pl" itself. This is the shell-script, and
> > it's not called ".pl".
> 
> In this thread, it originally was.

In this thread, it was originally a Python script. In particular, one
aimed at managing the Linux kernel source. I'm going to use
/usr/bin/env, systems where that doesn't exist can edit the source.

--
Mathematics is the supreme nostalgia of our time.
