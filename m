Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271943AbTG2RzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271845AbTG2RxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:53:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52616 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271941AbTG2Rve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:51:34 -0400
Date: Tue, 29 Jul 2003 13:54:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: James Simmons <jsimmons@infradead.org>
cc: Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.53.0307291338260.6166@chaos>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, James Simmons wrote:

>
> > Yes. This is f*ing absurb. A default that kills the screen and the
> > requirement to send some @!_$%!@$ sequences to turn it off. This
> > is absolute crap, absolutely positively, with no possible justification
> > whatsoever. If I made an ioctl, it will probably be rejected.........
>
> Welcome to the world of ESC sequences. These are terminal standards. Sorry.
>

No. There are no ANSI, nor DEC nor AT&T nor IRIS, nor IBM, nor any
other terminals that have screen-blanking capabilities. These are
the inventions of later-date emulations. If my DEC VT-220 screen
went blank I would need to have it serviced.

This is a PC invention that was adopted by Linux. It's very poor
design to have screen blanking enabled as the default. It's a
feature that should be enabled if wanted, not forced.

If you are not on-site within 10 minutes of having a remote
system fail, you can't see what's on the screen when you
plug in your monitor because the console driver has dutifully
blanked the screen. And, you can write escape sequences from
a task that doesn't exist. If `init` or whatever substitutes
for it fails to execute, unless you are watching, or can observe
the result before the screen blanks, you can't see what happened.
It is very poor design.

If the machine had blanking disabled by default, then the
usual SYS-V startup scripts could execute setterm to enable
it IFF it was wanted.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

