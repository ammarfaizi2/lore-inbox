Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRBFBfq>; Mon, 5 Feb 2001 20:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136173AbRBFBfZ>; Mon, 5 Feb 2001 20:35:25 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:17373 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S131276AbRBFBfU>; Mon, 5 Feb 2001 20:35:20 -0500
Date: Tue, 6 Feb 2001 12:37:21 +1100
From: Joel Beach <joelbeach@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: VESA framebuffer changes in 2.4
Message-ID: <20010206123721.A802@kinslayer.wot>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering whether the VESA framebuffer underwent wholesale changes
between 2.2 and 2.4. I use a graphical console (1024x768 @ 8bit colour
depth), and full-screen scrolling performance is *really* bad. When I type
'ls' in a directory with a large amount of files, it becomes really slow.
Under 2.2.18 I have no such problems.

I run my 2.4.1 system in a separate partition, built from scratch, and the
only important difference I can imagine between my 2.2.18 and 2.4.1 configs
is that I use agetty rather than mingetty in 2.4.1.

I can make my scrolling performance in 2.4.1 very good by appending the
following option in lilo.conf:

video=vesa:ywrap,mtrr

This makes scrolling down very fast - as fast if not faster than 2.2.18 -
but scrolling up one line at a time is absolutely horrendous - it seems to
redraw the whole screen. It is easy to test this bu using vi to edit a
file. I know this is probably due to the way that ywrap uses the video
card's memory as a buffer for scrolling down, but why is the behaviour so
different from 2.2.18?

BTW, I use an nvidia GeForce DDR 32MB RAM.  I don't subscribe to the list,
so please CC replies to joelbeach@optushome.com.au

Thanks,

Joel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
