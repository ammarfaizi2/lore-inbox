Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWEEQMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWEEQMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWEEQMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:12:34 -0400
Received: from albireo.ucw.cz ([84.242.87.5]:55171 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751593AbWEEQMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:12:33 -0400
Date: Fri, 5 May 2006 18:12:34 +0200
From: Martin Mares <mj@ucw.cz>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       dtor_core@ameritech.net, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <mj+md-20060505.160404.7633.albireo@ucw.cz>
References: <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz> <20060505154638.GE22870@redhat.com> <mj+md-20060505.154834.7444.albireo@ucw.cz> <20060505160009.GB25883@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505160009.GB25883@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  > Why do you think these are false positives? They usually report real
>  > problems.
> 
> Did you read my earlier posts?
> Users are seeing this *during boot*, before they've even pressed *ANY* keys.
> They're seeing it after pressing a *single* key.

If it is so (sorry for catching the thread in the middle), then it means
that there is either a bug in the keyboard driver, which should be fixed,
or a bug in the keyboard controller, which can have other side-effects
and so it should be at least reported.

> How on earth is "too many keys pressed" a useful message in this context?

I am not telling that the message has to stay intact -- it should be reworded
and rate-limited, but not hidden.

> Yes, maybe their keyboard is crap, but what is the user to do?
> Go buy a new laptop because someone else has a utopian view on how hardware should be?

No, just notice that his hardware is buggy and that it's probably a harmless
bug -- like we already do in many other cases (e.g., the 3Com drivers sometime
tell the user that his card has broken DMA, so it's going to use PIO instead).

> When a user can't do *anything* about it, it's useless, and serves
> as nothing but a cause for concern. "Oh no, is my laptop dying?".

If it's not a laptop, they can do.

When I am considering a keyboard to buy and I see this message, I usually
choose a different one immediately, because it often means that the keyboard
will react badly to fast typing.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A student who changes the course of history is probably taking an exam.
