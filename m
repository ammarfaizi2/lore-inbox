Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbRF1RVF>; Thu, 28 Jun 2001 13:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbRF1RU4>; Thu, 28 Jun 2001 13:20:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57614 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266043AbRF1RUv>; Thu, 28 Jun 2001 13:20:51 -0400
Subject: Re: Cosmetic JFFS patch.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 28 Jun 2001 18:14:15 +0100 (BST)
Cc: patrick@dreker.de (Patrick Dreker), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dwmw2@infradead.org (David Woodhouse), jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com> from "Linus Torvalds" at Jun 28, 2001 10:05:22 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FfMt-0007Ht-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Things like version strings etc sound useful, but the fact is that the
> only _real_ problem it has ever solved for anybody is when somebody thinks
> they install a new kernel, and forgets to run "lilo" or something. But
> even that information you really get from a simple "uname -a".

For device drivers it tends to be very useful because people often mix and 
match a base kernel and older/newer drivers. But it can certainly be
KERN_VERSION which is KERN_DEBUG type level

> Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
> that we have quota version "dquot_6.4.0"? No. Do we want to get the

Actually that one matters. Its important to tell people they have broken
quota code and should do something about it ;)
<runs>

> If people care about version printing, it (a) only makes sense for modules
> and (b) should therefore maybe be done by the module loader. And modules
> already have the MODULE_DESCRIPTION() thing, so they should NOT printk it
> on their own.  modprobe can do it if it wants to.

Q: Would it be worth making the module author/version strings survive in
a non modular build but stuffed into their own section so you can pull them
out with some magic that we'd include in 'REPORTING-BUGS'

> Authors willing to start sending me patches?

For the networking credit for the university - nope. Its hard to quantify what
it gained the university but it isnt something to throw away lightly. Its
as real in its nonfinancial way as reiserfs is important financially to 
Hans and that he is known to be its author.

I've no idea what the position on vendor copyright printk messgaes is, 
certainly if they are copyright strings and count as such I think you need
to discuss the matter with the boards of the companies concerned.

Alan

