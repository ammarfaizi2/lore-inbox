Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRHTTc7>; Mon, 20 Aug 2001 15:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRHTTct>; Mon, 20 Aug 2001 15:32:49 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:17161 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S268867AbRHTTci> convert rfc822-to-8bit; Mon, 20 Aug 2001 15:32:38 -0400
Date: Mon, 20 Aug 2001 21:30:05 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Theodore Tso <tytso@mit.edu>,
        David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <3B8124C4.7A4275B9@nortelnetworks.com>
Message-ID: <20010820205357.S323-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Aug 2001, Chris Friesen wrote:

> Alex Bligh - linux-kernel wrote:
>
> > An alternative approach to all of this, perhaps, would be to use extremely
> > finely grained timers (if they exist), in which case more bits of entropy
> > could perhaps be derived per sample, and perhaps sample them on
> > more operations. I don't know what the finest resolution timer we have
> > is, but I'd have thought people would be happier using ANY existing
> > mechanism (including network IRQs) if the timer resolution was (say)
> > 1 nanosecond.
>
> Why don't we also switch to a cryptographically secure algorithm for
> /dev/urandom?  Then we could seed it with a value from /dev/random and we would
> have a known number of cryptographically secure pseudorandom values.  Once we
> reach the end of the png cycle, we could re-seed it with another value from
> /dev/random.
>
> Would this be a valid solution, or am I totally off my rocker?

The latter, unless you only want to protect against lame attackers :-)

Given the knowledge of the seed and the algorithm used, everything gets
fully deterministic for an attacker -> enthropy _zero_.

For example, let an attacker observe enough of your magic random data in
order to guess the algorithm, and a whole prng cycle will only contain as
many random bits as the number of bits of the seed value for this
attacker.

> Chris

  Gérard.


