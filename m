Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRIYTom>; Tue, 25 Sep 2001 15:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273294AbRIYToZ>; Tue, 25 Sep 2001 15:44:25 -0400
Received: from [194.213.32.137] ([194.213.32.137]:9476 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273261AbRIYToJ>;
	Tue, 25 Sep 2001 15:44:09 -0400
Message-ID: <20010925005033.A137@bug.ucw.cz>
Date: Tue, 25 Sep 2001 00:50:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <m1iteegag6.fsf@frodo.biederman.org> <E15jpRy-0003yt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15jpRy-0003yt-00@the-village.bc.nu>; from Alan Cox on Wed, Sep 19, 2001 at 11:04:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So my suggestion was to look at getting anonymous pages backed by what
> > amounts to a shared memory segment.  In that vein.  By using an extent
> > based data structure we can get the cost down under the current 8 bits
> > per page that we have for the swap counts, and make allocating swap
> > pages faster.  And we want to cluster related swap pages anyway so
> > an extent based system is a natural fit.
> 
> Much of this goes away if you get rid of both the swap and anonymous page
> special cases. Back anonymous pages with the "whoops everything I write here
> vanishes mysteriously" file system and swap with a swapfs

What exactly is anonymous memory? I thought it is what you do when you
want to malloc(), but you want to back that up by swap, not /dev/null.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
