Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbRGXN5E>; Tue, 24 Jul 2001 09:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbRGXN4z>; Tue, 24 Jul 2001 09:56:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14865 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267537AbRGXN4q>; Tue, 24 Jul 2001 09:56:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation
Date: Tue, 24 Jul 2001 14:57:20 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01071815464209.12129@starship> <01072122255100.02679@starship> <3B5B6311.C8F8094E@eyal.emu.id.au>
In-Reply-To: <3B5B6311.C8F8094E@eyal.emu.id.au>
MIME-Version: 1.0
Message-Id: <01072414572008.00301@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday 23 July 2001 01:34, Eyal Lebedinsky wrote:
> Daniel Phillips wrote:
> > Yes, I tested almost all of them to see how well they worked my
> > directory index application.  There are really only two criterea:
> >
> >   1) How random is the hash
> >   2) How efficient is it
> >
> > My testing was hardly what you would call rigorous.  Basically,
> > what I do is hash a lot of very unrandom strings and see how
> > uniform the
>
> Actually, to measure the randomness you need to measure the
> randomness of the output in the face of non-random input.

This is exactly what I do.

> Most well constructed
> hash functions perform well when the strings are random, however real
> world data (e.g. directory contntent) is not random at all.

I think you meant to say there, "even many poorly constructed hash
functions perform well when..."

> Efficiency should measure both space and time resources. If it should
> work in a multithreaded situation then another level of complexity is
> added.

Sure, I could have added "how big is it".  For me, that's just 
another kind of efficiency.  Writing the code so it's reentrant is 
just good practice.  There is no excuse whatsoever for not doing
that for something simple like a hash function, even if you
yourself never expect to run two copies concurrently.

--
Daniel
