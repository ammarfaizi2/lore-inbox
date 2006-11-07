Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753444AbWKGVlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbWKGVlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbWKGVlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:41:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6413 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1753444AbWKGVlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:41:06 -0500
Date: Tue, 7 Nov 2006 21:26:14 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Message-ID: <20061107212614.GA6730@ucw.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com> <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >The SGI Altix can have 2048 CPUs.
> 
> And does it run one image of Linux? Or more images each 
> on few cpus?
> 
> How do they solve problem with spinlock livelocks?
> 
> If time-spent-outside-spinlock/time-spent-in-spinlock < 
> number-of-cpus, the spinlock livelock may happen --- 
> this condition is not true normally with 2 or 4 cpus, 
> but for that high amount of cpus, there is a danger.

Lets say time-spent-outside-spinlock == time-spent-in-spinlock and
number-of-cpus == 2.

1 < 2 , so it should livelock according to you...

...but afaict this should work okay. Even if spinlocks are very
unfair, as long as time-outside and time-inside comes in big chunks,
it should work.

If you are unlucky, one cpu may stall for a while, but... I see no
livelock.

-- 
Thanks for all the (sleeping) penguins.
