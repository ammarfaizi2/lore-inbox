Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTB0U0R>; Thu, 27 Feb 2003 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTB0U0Q>; Thu, 27 Feb 2003 15:26:16 -0500
Received: from crack.them.org ([65.125.64.184]:54703 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266994AbTB0UZC>;
	Thu, 27 Feb 2003 15:25:02 -0500
Date: Thu, 27 Feb 2003 15:35:12 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030227203512.GA12623@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030227194522.GA10427@nevyn.them.org> <Pine.LNX.4.44.0302271157380.9696-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302271157380.9696-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 12:00:46PM -0800, Linus Torvalds wrote:
> 
> On Thu, 27 Feb 2003, Daniel Jacobowitz wrote:
> > > 
> > > My personal opinion is (and was several years ago when this started
> > > coming up) that a cast (any cast) should do it. But I don't are _what_
> > > it is, as long as it is syntactically sane and isn't limited to special
> > > cases like unions.
> > 
> > Well, if that's all you're asking for, it's easy - I don't know if
> > you'll agree that the syntax is sane, but it's there.  From the GCC 3.3
> > manual:
> > 
> > `may_alias'
> 
> Halleluja. It still leaves us with all other compilers unaccounted for, 
> but yes, this will allow fixing the problem for us in the future.
> 
> Too bad the current gcc-3.3 is apparently not useful for the kernel for
> other reasons right now (ie the inlining issue which is being discussed on
> the gcc lists, and that annoying sign warning), but that may well be 
> resolved by the time it gets released.

We could work around both of these: disable the sign compare warning,
and use check_gcc to set a high number for -finline-limit...

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
