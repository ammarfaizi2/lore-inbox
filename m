Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283488AbRLTKHk>; Thu, 20 Dec 2001 05:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283430AbRLTKHZ>; Thu, 20 Dec 2001 05:07:25 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:32517 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S283244AbRLTKGi>;
	Thu, 20 Dec 2001 05:06:38 -0500
Date: Wed, 19 Dec 2001 23:16:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>, anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5
Message-ID: <20011219231619.A120@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.40.0112081824210.1019-100000@blue1.dev.mcafeelabs.com> <E16D6l9-00073R-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16D6l9-00073R-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Using the scheduler i'm working on and setting a trigger load level of 2,
> > as soon as the idle is scheduled it'll go to grab the task waiting on the
> > other cpu and it'll make it running.
> 
> That rapidly gets you thrashing around as I suspect you've found.
> 
> I'm currently using the following rule in wake up
> 
> 	if(current->mm->runnable > 0)	/* One already running ? */
> 		cpu = current->mm->last_cpu;

Is this really a win?

I mean, if I have two tasks that can run from L2 cache, I want them on
different physical CPUs even if they share current->mm, no?
								Pavel

-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
