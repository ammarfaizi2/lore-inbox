Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWEVBGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWEVBGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEVBGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:06:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18320 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932324AbWEVBGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:06:49 -0400
Date: Mon, 22 May 2006 03:06:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
Message-ID: <20060522010606.GC25434@elf.ucw.cz>
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446F3483.40208@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 20-05-06 11:23:47, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> > On Fri, 2006-05-19 at 21:00 -0400, John Richard Moser wrote:
> >> Any comments on this one?
> >>
> >> I'm trying to control the stack and heap randomization via command-line
> >> parameters. 
> > 
> > why? this doesn't really sound like something that needs to be tunable
> > to that extend; either it's on or it's off (which is tunable already),
> > the exact amount should just be the right value. While I often disagree
> > with the gnome desktop guys, they have some point when they say that
> > if you can get it right you shouldn't provide a knob.
> 
> This is a "One Size Fits All" argument.
> 
> Oracle breaks with 256M stack/mmap() randomization, so does Linus' mail
> client.  That's why we have 8M stack and 1M mmap().
> 
> On the other hand, some things[1][2][3] may give us the undesirable
> situation where-- even on an x86-64 with real NX-bit love-- there's an
> executable stack.  The stack randomization in this case can likely be
> weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
> (there's a zillion of these, like inc %eax) up to 4096 bytes.  This
> leaves 1 success case for every 2047 fail cases.

Maybe we can add more bits of randomness when there's enough address
space -- like in x86-64 case?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
