Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVEBRdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEBRdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVEBRb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:31:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:19090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261315AbVEBR33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:29:29 -0400
Date: Mon, 2 May 2005 10:31:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ryan Anderson <ryan@michonline.com>
cc: Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050502172012.GD11726@mythryan2.michonline.com>
Message-ID: <Pine.LNX.4.58.0505021028540.3594@ppc970.osdl.org>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
 <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
 <20050502172012.GD11726@mythryan2.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Ryan Anderson wrote:
>
> On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> > That said, I think the /usr/bin/env trick is stupid too. It may be more 
> > portable for various Linux distributions, but if you want _true_ 
> > portability, you use /bin/sh, and you do something like
> > 
> > 	#!/bin/sh
> > 	exec perl perlscript.pl "$@"
> 		if 0;
> 
> You don't really want Perl to get itself into an exec loop.

This would _not_ be "perlscript.pl" itself. This is the shell-script, and 
it's not called ".pl".

In other words, you'd put this as ~/bin/cg-xxxx, and then "perlscript.pl" 
wouldn't be in the path at all, it would be in some separate install 
directory.

But hey, if people want to be safe for bad installations, add the extra 
line. Shell won't care ;)

		Linus
