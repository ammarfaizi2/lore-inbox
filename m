Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRLVKpw>; Sat, 22 Dec 2001 05:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286756AbRLVKpm>; Sat, 22 Dec 2001 05:45:42 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:4883 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S273261AbRLVKpd>;
	Sat, 22 Dec 2001 05:45:33 -0500
Date: Fri, 21 Dec 2001 20:21:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler queue implementation ...
Message-ID: <20011221202113.D415@elf.ucw.cz>
In-Reply-To: <20011220203630.A204@elf.ucw.cz> <E16HT2l-0000oP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16HT2l-0000oP-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > I'd guess that if cpu-bound software wants to use clone(CLONE_VM) to
> > gain some performance, it should better work "mostly" in different
> > memory areas on different cpus... But I could be wrong.
> 
> Lots of people use shared mm objects and threads for things like UI
> rather

But ... UI performance should not matter much. And that is *abuse* of
threads.

> than just for cpu hogging. If they have multiple cpu hogs doing that then
> they want punishing (or better yet sending a copy of a document on
> caches)

If I have a raytracer, and want to explore 8 cpus, how do I do that?
Separate scene into 8 pieces, make sure no r/w data are shared, and
clone(CLONE_VM). Are there other ways? [I do not know if people are
really doing it like that. *I* would do it that way. Is it bad?]

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
