Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286399AbRLTVe5>; Thu, 20 Dec 2001 16:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRLTVes>; Thu, 20 Dec 2001 16:34:48 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:26637 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S286395AbRLTVeh>;
	Thu, 20 Dec 2001 16:34:37 -0500
Date: Thu, 20 Dec 2001 20:36:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
Message-ID: <20011220203630.A204@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.40.0112091647360.996-100000@blue1.dev.mcafeelabs.com> <E16DF39-00008w-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16DF39-00008w-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Alan, you're mixing switch mm costs with cache image reload ones.
> > Note that equal mm does not mean matching cache image, at all.
> 
> They are often close to the same thing. Take a look at the constraints
> on virtually cached processors like the ARM where they _are_ the same thing.
> 
> Equal mm for cpu sucking tasks often means equal cache image. On the

Really?

I'd guess that if cpu-bound software wants to use clone(CLONE_VM) to
gain some performance, it should better work "mostly" in different
memory areas on different cpus... But I could be wrong.

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
