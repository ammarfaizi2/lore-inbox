Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267669AbTAHDYK>; Tue, 7 Jan 2003 22:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267675AbTAHDYK>; Tue, 7 Jan 2003 22:24:10 -0500
Received: from crack.them.org ([65.125.64.184]:743 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267669AbTAHDYJ>;
	Tue, 7 Jan 2003 22:24:09 -0500
Date: Tue, 7 Jan 2003 22:32:45 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Zack Weinberg <zack@codesourcery.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Set TIF_IRET in more places
Message-ID: <20030108033245.GA780@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Richard Henderson <rth@twiddle.net>,
	Zack Weinberg <zack@codesourcery.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <20030107172128.A9592@twiddle.net> <Pine.LNX.4.44.0301071832210.1892-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301071832210.1892-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 06:33:48PM -0800, Linus Torvalds wrote:
> 
> On Tue, 7 Jan 2003, Richard Henderson wrote:
> > > We're open to better ideas ...
> > 
> > Something like having dwarf2 unwind information for the
> > vsyscall page on the page as well?
> 
> What would the unwind info look like? The current BK kernel will put the 
> signal return into the vsyscall page, so gdb could pick up the info from 
> there. But I have no idea what the unwind info looks like, or how to tell 
> gdb about it.

Right now you can't, since GDB won't use the unwind info anyway; but
Richard is probably talking about MD_FALLBACK_FRAME_STATE_FOR, which is
used for exception handling unwinding instead of debugging unwinding.

Someday soon I hope to have GDB properly using this info, too.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
