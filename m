Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135276AbREBOM0>; Wed, 2 May 2001 10:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbREBOMP>; Wed, 2 May 2001 10:12:15 -0400
Received: from erasmus.off.net ([64.39.30.25]:21512 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S135276AbREBOMC>;
	Wed, 2 May 2001 10:12:02 -0400
Date: Wed, 2 May 2001 10:12:00 -0400
From: Zach Brown <zab@zabbo.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Riccardi <fabio@chromium.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Smith <x@xman.org>,
        Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
Message-ID: <20010502101200.E28288@erasmus.off.net>
In-Reply-To: <3AEC8562.887CFA72@chromium.com> <Pine.LNX.4.33.0105021047040.3642-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0105021047040.3642-100000@localhost.localdomain>; from mingo@elte.hu on Wed, May 02, 2001 at 10:50:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i think Zach's phhttpd is an important milestone as well, it's the first
> userspace webserver that shows how to use event-based, sigio-based async
> networking IO and sendfile() under Linux. (I believe it had some

*blush*

> performance problems related to sigio queue overflow, these issues might
> be solved in the latest kernels.) The zerocopy enhancements should help
> phhttpd as well.

oh, it has a bunch of problems :)  over-threading created complexity in
the fast path.  It always spends memory on a contiguous header region for
each connection, which may not be valid in the days of zero copy sendmsg.
It does IO in the fast path.  And looking back at it, I'm struck by how
naive most of the code is :) :)

I've always been tempted to go back and take a real swing at a
nice content server, but there's only so many hours in the day, and
apache+thttpd+tux complete the problem space.  If X15 isn't released
with an open license, I may be tempted yet again :)

- z
