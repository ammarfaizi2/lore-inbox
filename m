Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263989AbRFTLfM>; Wed, 20 Jun 2001 07:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264331AbRFTLfD>; Wed, 20 Jun 2001 07:35:03 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:24580 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S263989AbRFTLet>;
	Wed, 20 Jun 2001 07:34:49 -0400
Message-ID: <20010619124627.A202@bug.ucw.cz>
Date: Tue, 19 Jun 2001 12:46:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
In-Reply-To: <20010615152306.B37@toy.ucw.cz> <20010618222131.A26018@paranoidfreak.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010618222131.A26018@paranoidfreak.co.uk>; from Simon Huggins on Mon, Jun 18, 2001 at 10:21:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Roger> It does if you are running on a laptop. Then you do not want
> > > Roger> the pages go out all the time. Disk has gone too sleep, needs
> > > Roger> to start to write a few pages, stays idle for a while, goes to
> > > Roger> sleep, a few more pages, ...
> > > That could be handled by a metric which says if the disk is spun
> > > down, wait until there is more memory pressure before writing.  But
> > > if the disk is spinning, we don't care, you should start writing out
> > > buffers at some low rate to keep the pressure from rising too
> > > rapidly.  
> > Notice that write is not free (in terms of power) even if disk is
> > spinning.  Seeks (etc) also take some power. And think about
> > flashcards. It certainly is cheaper tha spinning disk up but still not
> > free.
> 
> Isn't this why noflushd exists or is this an evil thing that shouldn't
> ever be used and will eventually eat my disks for breakfast?

It would eat your flash for breakfast. You know, flash memories have
no spinning parts, so there's nothing to spin down.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
