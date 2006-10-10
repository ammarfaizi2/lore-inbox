Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWJJKhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWJJKhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWJJKhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:37:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38589 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751425AbWJJKhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:37:37 -0400
Date: Tue, 10 Oct 2006 12:37:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Message-ID: <20061010103723.GC31598@elf.ucw.cz>
References: <20061006002950.49b25189.maxextreme@gmail.com> <20061008182438.GA4033@ucw.cz> <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com> <20061008191217.GA3788@elf.ucw.cz> <653402b90610081312m32fcf7ecx9929ae9dc4768c17@mail.gmail.com> <20061008211550.GE4152@elf.ucw.cz> <653402b90610081436w34d692ecv2dd9801c451ab490@mail.gmail.com> <20061008220722.GG4152@elf.ucw.cz> <653402b90610081545n51cdfbcej469990279f6d018c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653402b90610081545n51cdfbcej469990279f6d018c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >What is advantage of /dev/cfag12864bX over /dev/fbcfag12864b ?
> >
> >(And I guess you should invent better name... /dev/fbaux0?)
> >
> >
> >I do not think we need a Kconfig option, and I do not think we need
> >/dev/cfag12864bX . Just use /dev/fbaux0, always.
> >
> 
> One is the pure device, the other one is the framebuffer device. I
> think having both is better than just one. There is no advantage, they
> are different.

No, having two different interfaces when one would be enough is
stupid.

Face it... you are writing driver for framebuffer. (Small, slow,
black&white, but still framebuffer).

> Maybe someone doesn't need any of the framebuffer advantages and just
> wants to write to it directly, for better performance, for example:
> The LCD needs to change 8 pixels (1 byte) every write, if you modify a
> single pixel at the framebuffer device you will write more times than
> you need for the same result (right? I'm not sure of this); the LCD
> is

Wrong, I think you only need to change 1bit, so framebuffer device
actually performs better.

> >I do not think it is suitable for -rc at this point, and it does not
> >have chance before 2.6.20-rc1, anyway.
> 
> No? Why not? Time is not a problem, I would want to know why are you
> saying that.

Bad user<->kernel interface is good enough reason for the patch not to
be merged anywhere.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
