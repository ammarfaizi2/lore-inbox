Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbRGSQ3o>; Thu, 19 Jul 2001 12:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264998AbRGSQ3e>; Thu, 19 Jul 2001 12:29:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24328 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264624AbRGSQ3X>; Thu, 19 Jul 2001 12:29:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Inclusion of zoned inactive/free shortage patch
Date: Thu, 19 Jul 2001 18:33:26 +0200
X-Mailer: KMail [version 1.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0107181555181.1237-100000@penguin.transmeta.com> <0107190142450I.12129@starship>
In-Reply-To: <0107190142450I.12129@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <01071918332601.00317@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 19 July 2001 01:42, Daniel Phillips wrote:
> Yes.  The inactive shortage needs to be a function of the length of
> the inactive_dirty queue rather than just the amount that free pages
> is less than some fixed minimum.

Oops, it already is, good :-]

> The target length of the
> inactive_dirty queue in turn can be a function of the global free
> shortage (which is where the minimum free numbers get used)

ditto, it's already that way...

> and the transfer rate of the disk(s).

This we don't do, and afaics, this is the only way to get stability
across a really wide range of loads, and on system configurations we 
can't possibly pre-tune for.

> Again, experimental - without careful
> work a feedback mechanism like this could oscillate wildly.  It's
> most probably the way forward in the long run though.
>
> --
> Daniel
