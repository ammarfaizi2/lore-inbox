Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWF1WYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWF1WYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWF1WYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:24:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44244 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751604AbWF1WYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:24:33 -0400
Date: Thu, 29 Jun 2006 00:24:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@kde.org>
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm)
Message-ID: <20060628222417.GA27526@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606280118.23270.sebas@kde.org> <20060628195316.GB18039@elf.ucw.cz> <200606290019.17298.sebas@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606290019.17298.sebas@kde.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, can I get some details? Like how much memory does system have,
> > what stress test causes the failure?
> 
> The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB usually 
> made swsusp a problem. I'd need to close apps then to be able to
> suspend.

I'm pretty sure I do suspending with most of RAM full. You have
big-enough swap partition, right?

> Using suspend2 fixes that for me. I can even decide how much memory I want 
> suspended, the rest will be reliably discarded. I did a benchmark on two 
> similar machines swsusp: would take 45 seconds until resume (that's about the 
> same time it takes it to boot normally) suspend2 would take 25 seconds (and 
> have warm caches as a bonus). Not having a progress indicator also doesn't 
> really help.

Set console loglevel (see Doc*/power/swsusp.txt), and you should get
some progress. But yes, swsusp is slow; uswsusp should be about the
same speed as suspend2.

> Another thing I really like about suspend2 is that I can easily set it up so 
> it goes into S3 after writing the image. It would resume much faster then, 
> and in case it runs out of battery, I can still 'normally' resume from disk. 
> That's incredibly useful, especially since not all devices are known to 
> completely switch off during S3, and resuming from S3 is generally known to 
> cause problems. I've yet to see suspend2 failing though.

> Is such a disk-backed hibernate also possible with (u)swsusp?

We call it s2both and yes, it is supported.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
