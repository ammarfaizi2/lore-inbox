Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314068AbSDQFfS>; Wed, 17 Apr 2002 01:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSDQFfR>; Wed, 17 Apr 2002 01:35:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34313 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314068AbSDQFfQ>; Wed, 17 Apr 2002 01:35:16 -0400
Date: Tue, 16 Apr 2002 22:34:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mark Mielke <mark@mark.mielke.cc>
cc: Robert Love <rml@tech9.net>, <davidm@hpl.hp.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020417011842.A12455@mark.mielke.cc>
Message-ID: <Pine.LNX.4.33.0204162227530.15675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Apr 2002, Mark Mielke wrote:
> On Tue, Apr 16, 2002 at 08:57:09PM -0400, Robert Love wrote:
> >
> > Because that is what Alpha does?  It seems to me there is no reason for
> > a power-of-two timer value, and using 1024 vs 1000 just makes the math
> > and rounding more difficult.
>
> Only from the perspective of time displayed to a user... :-)

No, it also makes it much easier to convert to/from the standard UNIX time
formats (ie "struct timeval" and "struct timespec") without any surprises,
because a jiffy is exactly representable in both if you have a HZ value
of 100 or 100, but not if your HZ is 1024.

		Linus

