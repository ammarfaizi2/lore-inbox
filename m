Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJAQAz>; Tue, 1 Oct 2002 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261923AbSJAQAC>; Tue, 1 Oct 2002 12:00:02 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:47515 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262124AbSJAP71>;
	Tue, 1 Oct 2002 11:59:27 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@arcor.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Date: Tue, 1 Oct 2002 18:05:15 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva> <E17w6Mc-0005p6-00@starship> <20020930160434.Q13755@bitchcake.off.net>
In-Reply-To: <20020930160434.Q13755@bitchcake.off.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17wPWO-0005up-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 22:04, Zach Brown wrote:
> but really, I think these are DOA.

No argument there.

> having to define a single magical
> structure member makes these more trouble than they're worth.  I've come
> to prefer wli's 'struct list' approach.  It has the added benefit of
> actually being sanely implementable with shared code, something
> ridiculously low memory setups might appreciate.

Have you tried it in a real program?  I have.  It's not nice to use.
My original response to Bill:

> > How's this look?
> 
> Unfortunately, not good.  You get code like:
> 
>         foo = (struct mylist *) slist_pop((slist *) &somelist->next);
>
> So type safety goes out the window, and you gain some niceness in the
> definition in exchange for ugliness in usage, the wrong tradeoff imho.

Single linked lists are so simple - just write the darn code out in
full.  Yes, the fact that you can't sanely generalize these things shows
that C as a language falls a few cards short of a full deck, but we knew
that.  It makes nice kernels, it does not make art.

-- 
Daniel

