Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135886AbRASEXj>; Thu, 18 Jan 2001 23:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135775AbRASEX3>; Thu, 18 Jan 2001 23:23:29 -0500
Received: from dewey.lib.ci.phoenix.az.us ([148.167.132.200]:20622 "EHLO
	dewey.lib.ci.phoenix.az.us") by vger.kernel.org with ESMTP
	id <S135456AbRASEXQ>; Thu, 18 Jan 2001 23:23:16 -0500
Date: Thu, 18 Jan 2001 21:23:10 -0700 (MST)
From: Paul Hancock <phancock@lib.ci.phoenix.az.us>
To: <linux-kernel@vger.kernel.org>
Subject: Network response time issue
Message-ID: <Pine.LNX.4.30.0101182051210.30915-100000@ariseth.lib.ci.phoenix.az.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am investigating a web site response time issue that one of our patrons
is having. After ruling out the obvious, I ran a tcpdump, and compared the
packet trace to other web sessions that had reasonable response time, and
found that the session that was having problems had a mss of 536, while
most of the tcp sessions used a mss of 1460.

When I upgraded the kernel from 2.4.0-test12 to 2.4.0, response seemed to
improve slightly.  Nonetheless, I'm still seeing the same basic behavior:
a burst of traffic, followed by a period of silence.  I'm not an expert at
analyzing packet traces, but it looks like the server is having to do a
lot of re-transmits.  The user states that other sites come up fine,
including another web server that shares the WAN link with us.

Am I possibly looking at a kernel networking issue?  What other things
should I be looking at/for?

Thanks.

		-- Paul (phancock@lib.ci.phoenix.az.us)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
