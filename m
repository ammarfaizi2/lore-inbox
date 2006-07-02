Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWGBAib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWGBAib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 20:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWGBAib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 20:38:31 -0400
Received: from thunk.org ([69.25.196.29]:22934 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964893AbWGBAia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 20:38:30 -0400
Date: Sat, 1 Jul 2006 20:38:15 -0400
From: Theodore Tso <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Bailey <jbailey@ubuntu.com>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060702003815.GB15375@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jeff Bailey <jbailey@ubuntu.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Roman Zippel <zippel@linux-m68k.org>, klibc@zytor.com,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org> <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org> <20060702000528.GA15375@thunk.org> <44A7108D.6090204@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A7108D.6090204@zytor.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 05:17:17PM -0700, H. Peter Anvin wrote:
> One of the criticisms I've gotten for klibc has been why I have included 
> dash and a whole bunch of shell utilities when they're not used by the 
> default kernel build.  It certainly hasn't been just to prove a point; 
> as a matter of fact, getting dash to build correctly under Kbuild proved 
> to be surprisingly difficult.  However, by making sure that one can 
> *easily* pull together an interactive environment -- even if one didn't 
> have one from the start -- one has more readily access to a debuggable 
> environment.

Well, I wouldn't be one of those folks.  In fact, how big is dash and
some select set of shell utilities?  If they aren't that big, it might
make sense to include them all the time so that a simple command-line
option on boot is all that's necessary in order to break into a
pre-kinit interactive shell.  That would make the resulting system
more debuggable by definition.  Then all we will would have to do is
make sure the distro's use the kernel-supplied kinit solution, instead
of rolling their own non-standard version.

						- Ted
