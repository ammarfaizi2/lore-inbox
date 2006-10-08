Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWJHWHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWJHWHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWJHWHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:07:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35501 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932075AbWJHWHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:07:34 -0400
Date: Mon, 9 Oct 2006 00:07:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Message-ID: <20061008220722.GG4152@elf.ucw.cz>
References: <20061006002950.49b25189.maxextreme@gmail.com> <20061008182438.GA4033@ucw.cz> <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com> <20061008191217.GA3788@elf.ucw.cz> <653402b90610081312m32fcf7ecx9929ae9dc4768c17@mail.gmail.com> <20061008211550.GE4152@elf.ucw.cz> <653402b90610081436w34d692ecv2dd9801c451ab490@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653402b90610081436w34d692ecv2dd9801c451ab490@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Yep... but when we have /dev/fbcfag12864b ... do we need
> >/dev/cfag12864bX ? I think it is useless at that point.
> 
> Well, because cfag12864b is the generic one I think it should be in
> the /dev directory (whatever if you use or don't it / whatever if it
> is useless or not).

I do not understand, both /dev/fbcfag12864b and /dev/cfag12864bX are
in /dev/...

What is advantage of /dev/cfag12864bX over /dev/fbcfag12864b ?

(And I guess you should invent better name... /dev/fbaux0?)

> >/dev/fbcfag12864b is very easy to "manipulate by hand" too.
> 
> Yep, IMO we should add a Kconfig option instead of mixing both by
> default (cfag12864b and fbcfag12864b); anyway I think having
> cfag12864b & fbcfag12864b is better than mixing it all in one
> module.

I do not think we need a Kconfig option, and I do not think we need
/dev/cfag12864bX . Just use /dev/fbaux0, always.

> modules as they are now and add the fbcfag12864b later in time: I'm
> waiting them to get into one of the -rcs without more radical changes.

I do not think it is suitable for -rc at this point, and it does not
have chance before 2.6.20-rc1, anyway.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
