Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271617AbRHZXR4>; Sun, 26 Aug 2001 19:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271619AbRHZXRr>; Sun, 26 Aug 2001 19:17:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63749 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271617AbRHZXR2>; Sun, 26 Aug 2001 19:17:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 01:24:23 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, pcg@goof.com,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108261651080.5646-100000@imladris.rielhome.conectiva> <20010826200133Z16190-32385+242@humbolt.nl.linux.org> <20010826233343.A6193@flint.arm.linux.org.uk>
In-Reply-To: <20010826233343.A6193@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826231743Z16325-32383+1526@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 12:33 am, Russell King wrote:
> Of the 8192 pages in his system, there are 4687 anonymous pages like the
> above, 466 slab pages, 636 reserved pages, 376 unused pages (for reserved
> allocation) and 2000 ramdisk pages.  That leaves 27 pages, which are the
> 26 inactive clean pages (from the above), plus one page cache page.
> 
> Feel free to use this information to formulate new strategies on improving
> the VM.
> 
> [note that it takes around 1 minute to get 32MB-worth of information out
> of a serial console at 38400 baud.  You don't want to do this on GB boxes].

This is a nice dump format.  One thing that would be very helpful is the page 
executable flag, another would be the writable flag.  The 4687 anonymous 
pages are the elephant under the rug, but we don't know how they break down 
between executable (evictable) and otherwise.

--
Daniel
