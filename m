Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTB0Tw5>; Thu, 27 Feb 2003 14:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTB0Tw5>; Thu, 27 Feb 2003 14:52:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21264 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266839AbTB0Tw4>; Thu, 27 Feb 2003 14:52:56 -0500
Date: Thu, 27 Feb 2003 12:00:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid compilation without -fno-strict-aliasing
In-Reply-To: <20030227194522.GA10427@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0302271157380.9696-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Feb 2003, Daniel Jacobowitz wrote:
> > 
> > My personal opinion is (and was several years ago when this started
> > coming up) that a cast (any cast) should do it. But I don't are _what_
> > it is, as long as it is syntactically sane and isn't limited to special
> > cases like unions.
> 
> Well, if that's all you're asking for, it's easy - I don't know if
> you'll agree that the syntax is sane, but it's there.  From the GCC 3.3
> manual:
> 
> `may_alias'

Halleluja. It still leaves us with all other compilers unaccounted for, 
but yes, this will allow fixing the problem for us in the future.

Too bad the current gcc-3.3 is apparently not useful for the kernel for
other reasons right now (ie the inlining issue which is being discussed on
the gcc lists, and that annoying sign warning), but that may well be 
resolved by the time it gets released.

			Linus

