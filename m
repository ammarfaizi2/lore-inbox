Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWEVSku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWEVSku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWEVSku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:40:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10464 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751038AbWEVSkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:40:49 -0400
Date: Mon, 22 May 2006 20:40:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
Message-ID: <20060522184003.GD2979@elf.ucw.cz>
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net> <20060522170036.GD1893@elf.ucw.cz> <4471FAD0.9060403@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4471FAD0.9060403@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, fix emacs then. We definitely do not want 10000 settable knobs
> > that randomly break things. OTOH per-architecture different randomness
> > seems like good idea. And if Oracle breaks, fix it.
> 
> Fix this, fix that.  In due time perhaps.  I'm pretty sure Linus isn't
> going to break anything, esp. since his mail client breaks too.

Good. So fix emacs/oracle/pine, and year or so and some time after it
is fixed, we can change kernel defaults. That's still less bad than
having

[ ] Break emacs

in kernel config.

> Why should it NOT be configurable anyway?  If you don't configure it,
> then it behaves just like it would if it wasn't configurable at all.
> This is called "having sane defaults."

Because if it is configurable, someone _will_ configure it wrong, and
then ask us why it does not work.

And if it is configurable, applications will not get fixed for
basically forever.

> > Per-architecture ammount of randomness would be welcome, I
> > believe. That will force Oracle to fix their code, but that's okay,
> > and you can use disable PF_RANDOMIZE for Oracle in meantime.
> 
> No, this would leave Oracle shipping binaries with PF_RANDOMIZE
> (PT_GNU_STACK still?) disabled.  Also if PF_RANDOMIZE is still connected
> to PT_GNU_STACK, then this means that randomization is turned off BY
> MAKING THE STACK EXECUTABLE.  You should notice the obvious problem
> here.  You should also understand that as long as they can simply switch
> randomization off, they're not going to fix it; and as long as it breaks
> Oracle/Emacs/anything, Linus is not going to impose non-disablable,
> non-adjustable randomization.

I believe that Linus is going to apply this one even less likely.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
