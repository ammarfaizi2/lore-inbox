Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDYVcZ>; Wed, 25 Apr 2001 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132615AbRDYVcP>; Wed, 25 Apr 2001 17:32:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132558AbRDYVbz>; Wed, 25 Apr 2001 17:31:55 -0400
Date: Wed, 25 Apr 2001 14:31:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <jt@hpl.hp.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: orinoco_cs & IrDA
In-Reply-To: <20010424113920.B31666@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.31.0104251419002.25484-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Jean Tourrilhes wrote:
>
> 	I've got a question... I would like where to send my driver
> patches...

Probably both me and Alan.

[ General rules follow. Too few people seem to have seen them before ]

Most importantly, when sending patches to me:

 - specify clearly that you really want to see them in the standard
   kernel, and why. I occasionally get patches that just say "this is a
   good idea". I don't apply them. Especially if they are cc'd to somebody
   else too, in which case I pretty much assume that it's a RFC, not a
   "real patch".

 - do NOT send patches in attachements. Send one patch per mail, in
   clear-text under your message, so that I can easily see the patch and
   decide then-and-there whether it looks ok. And if it doesn't look ok,
   and I do a "reply", the patch gets included in the reply so that I can
   point out which part of the patch I dislike.

   Don't worry about sending me five emails. That's FINE. I much prefer
   seeing five consecutive emails from the same person with five distinct
   subject lines and five distinct patches, than seeing one email with
   five attachements to it.

 - if your email system is broken, and you want to send patches as
   attachements to avoid whitspace damage, then please FIX YOUR EMAIL
   SYSTEM INSTEAD.

 - Don't point to web-sites. If I have to move the mouse outside my email
   xterm to work on the email, your email just got ignored.

 - Make your patches one sub-directory under the source tree you're
   working on. In short, your patches should look like something like

	--- clean/fs/inode.c ...
	+++ linux/fs/inode.c ..
	@@ -179,7 +179,7 @@
	...

   so that I can (regardless of where my source tree is) apply them
   with "patch -p1" from my linux top directory. Then I can just do a

	cd v2.4/linux
	patch -p1 < ~/multiple-emails-with-multiple-accepted-patches

   and not have to worry about three patches being based on
   /usr/src/linux, while two others not having a path at all and being
   individual filenames in linux/drivers/net.

 - and finally: re-send. If I had laser-eye surgery the fay you sent the
   patches, I won't have applied them. If I took a day off and spent it
   with the kids at the pool instead, I won't have applied them. If I
   decided that this weekend I'm not going to read email for a change, I
   won't have applied them.

   And when I come back to work a day or two later, I will have several
   hundred other emails to work through. I never go backwards in my
   emails.


