Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262287AbRERJeJ>; Fri, 18 May 2001 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRERJd7>; Fri, 18 May 2001 05:33:59 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:18074 "HELO
	corb.mc.mpls.visi.com") by vger.kernel.org with SMTP
	id <S262287AbRERJdx>; Fri, 18 May 2001 05:33:53 -0400
Message-ID: <3B04E694.34FA158F@steinerpoint.com>
Date: Fri, 18 May 2001 04:08:36 -0500
From: Al Borchers <alborchers@steinerpoint.com>
Reply-To: alborchers@steinerpoint.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu,
        Peter Berger <pberger@brimson.com>
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
In-Reply-To: <E150fYc-0006qG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> So I stuck my justify this change to Ted hat on. And failed.
> 
> For one the cleanest way to handle all the locking is to propogate the other
> locking fix styles into both the ldisc and serial drivers. At least for 2.4

If I understand you right, the plan is to leave tty_open unchanged (it calls
driver close on failed driver open) and try to fix ldisc and serial driver
races as much as possible.  Correct?

Where is an example of the "other locking fix styles" that you and Ted want
to apply to the serial drivers?

> The advantage of doing that is that modules that do play with use counts will
> not do anything worse than they do now, and will remain fully compatible.

Leaving tty_open unchanged does have compatibility going for it.

> The ldisc race is also real and completely unfixed right now.

I would be interested to try to figure this out and fix it--can you give
me more of an idea of what the problem is?

-- Al
