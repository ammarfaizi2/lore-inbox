Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUFGQl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUFGQl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUFGQl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:41:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31492 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264923AbUFGQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:41:52 -0400
Date: Mon, 7 Jun 2004 17:41:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Greg Weeks <greg.weeks@timesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] jffs2 aligment problems
Message-ID: <20040607174147.I28526@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
References: <40C484F9.20504@timesys.com> <200406071736.53101.tglx@linutronix.de> <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org>; from torvalds@osdl.org on Mon, Jun 07, 2004 at 09:03:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 09:03:07AM -0700, Linus Torvalds wrote:
> On Mon, 7 Jun 2004, Thomas Gleixner wrote:
> >
> > On Monday 07 June 2004 17:08, Greg Weeks wrote:
> > > This fixed some jffs2 alignment problems we saw on an IXP425 based
> > > XScale board. I just got pinged that I was supposed to post this patch
> > > in case anyone else finds it usefull. This was against a modified 2.4.19
> > > kernel.
> > 
> > Enable CONFIG_ALIGNMENT_TRAP instead of tweaking the code. 
> > JFFS2 / MTD must be allowed to do unaligned access
> 
> Wrong.
> 
> Pleas fix jffs2 to use the proper "get_unaligned()"/"put_unaligned()"
> instead.
> 
> Emulating unaligned accesses with traps (even even the architecture
> supports it, which isn't universally true) is _stupid_ when we have
> perfectly well-defined macros for them that do it faster and are
> _designed_ for this.
> 
> On architectures where it doesn't matter, the macros just do the access,
> so it's not like you're slowing anything down.
> 
> 		Linus

I'll let you have a bun fight with dwmw2 and networking people over
this.  I'm standing well clear. 8)

[Added dwmw2 and dropped linux-arm-kernel]

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
