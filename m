Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSGCQ6j>; Wed, 3 Jul 2002 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSGCQt3>; Wed, 3 Jul 2002 12:49:29 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:56029 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317192AbSGCQsF>; Wed, 3 Jul 2002 12:48:05 -0400
Date: Wed, 3 Jul 2002 05:50:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Werner Almesberger <wa@almesberger.net>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020703035013.GJ474@elf.ucw.cz>
References: <20020702133658.I2295@almesberger.net> <20020702165019.29700@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702165019.29700@smtp.adsl.oleane.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> It's not really just the module information. If I can, say, get
> >> callbacks from something even after I unregister, I may well
> >> have destroyed the data I need to process the callbacks, and
> >> oops or worse.
> >
> >Actually, if module exit synchronizes properly, even the
> >return-after-removal case shouldn't exist, because we'd simply
> >wait for this call to return.
> >
> >Hmm, interesting. Did I just make the whole problem go away,
> >or is travel fatigue playing tricks on my brain ? :-)
> 
> That was one of the solutions proposed by Rusty, that is basically
> waiting for all CPUs to have scheduled upon exit from module_exit
> and before doing the actual removal.

That seems reasonable... lighter version of freeze_processes() I was
thinking about.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
