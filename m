Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbTAHCaV>; Tue, 7 Jan 2003 21:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267669AbTAHCaV>; Tue, 7 Jan 2003 21:30:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24070 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267662AbTAHCaV>; Tue, 7 Jan 2003 21:30:21 -0500
Date: Tue, 7 Jan 2003 18:33:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: Zack Weinberg <zack@codesourcery.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
In-Reply-To: <20030107172128.A9592@twiddle.net>
Message-ID: <Pine.LNX.4.44.0301071832210.1892-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Jan 2003, Richard Henderson wrote:
> > We're open to better ideas ...
> 
> Something like having dwarf2 unwind information for the
> vsyscall page on the page as well?

What would the unwind info look like? The current BK kernel will put the 
signal return into the vsyscall page, so gdb could pick up the info from 
there. But I have no idea what the unwind info looks like, or how to tell 
gdb about it.

		Linus

