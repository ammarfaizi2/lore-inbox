Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSCLXIk>; Tue, 12 Mar 2002 18:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSCLXIa>; Tue, 12 Mar 2002 18:08:30 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:3848 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S288071AbSCLXIT>;
	Tue, 12 Mar 2002 18:08:19 -0500
Date: Tue, 12 Mar 2002 01:44:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
Message-ID: <20020312014408.C37@toy.ucw.cz>
In-Reply-To: <3C8CDA0D.7020703@evision-ventures.com> <E16kT8L-00014f-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16kT8L-00014f-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 11, 2002 at 04:58:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Because its standards compliant. It wasnt written by a half clued wannabe
> who has never read the manuals and can do nothing but call people who have
> a "liar". And a standards compliant implementation does all the right power
> management commands. Win 98 didnt quite get it right and you'll find one
> of the updates addresses IDE problems. Ironically fixing the same flush
> cache and shut down politely problem you plan to break in Linux

He is not breaking anything.

Just now linux will happily suspend in the middle of read command, then
wake up, get spurious interrupt, say "I'm happy read finished", and corrupt
data. What's there is first step in getting it right, and more steps are
needed.

NOTICE NOTICE NOTICE: unless you are using S3/S4, that change is a NOP. On
2.4.18 you can't use S3/S4, so it is definitely NOP for you. Will not eat
your data.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

