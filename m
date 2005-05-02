Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVEBRTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVEBRTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEBRTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:19:15 -0400
Received: from nevyn.them.org ([66.93.172.17]:31446 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261359AbVEBRSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:18:12 -0400
Date: Mon, 2 May 2005 13:18:02 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050502171802.GA28045@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> It's not about environment.
> 
> It's about the fact that many people have things like python in
> /usr/local/bin/python, because they compiled it themselves or similar.
> 
> Pretty much the only path you can _really_ depend on for #! stuff is 
> /bin/sh.
> 
> Any system that doesn't have /bin/sh is so fucked up that it's not worth
> worrying about. Anything else can be in /bin, /usr/bin or /usr/local/bin
> (and sometimes other strange places).
> 
> That said, I think the /usr/bin/env trick is stupid too. It may be more 
> portable for various Linux distributions, but if you want _true_ 
> portability, you use /bin/sh, and you do something like
> 
> 	#!/bin/sh
> 	exec perl perlscript.pl "$@"
> 
> instead.

Do you know any vaguely Unix-like system where #!/usr/bin/env does not
work?  I don't; I've used it on Solaris, HP-UX, OSF/1...

-- 
Daniel Jacobowitz
CodeSourcery, LLC
