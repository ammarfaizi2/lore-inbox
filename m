Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289790AbSBJVd1>; Sun, 10 Feb 2002 16:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289783AbSBJVcy>; Sun, 10 Feb 2002 16:32:54 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:7435 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289789AbSBJVa7>;
	Sun, 10 Feb 2002 16:30:59 -0500
Date: Sun, 10 Feb 2002 00:19:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
        Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] Read-Copy Update 2.5.4-pre2
Message-ID: <20020209231925.GA116@elf.ucw.cz>
In-Reply-To: <20020208234217.A18466@in.ibm.com> <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca> <20020209114818.C19737@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209114818.C19737@in.ibm.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > in lkml in the past. Currently there are several potential 
> > > applications of RCU that are being developed and some of them look 
> > > very promising. Our revamped webpage 
> > 
> > yes, but have you evaluated whether it's noticably better than
> > other forms of locking?  for instance, couldn't your dcache example
> > simply use BR locks?
> 
> First of all, IMO, RCU is not a wholesale replacement for one form of
> locking or another. It provides two things -
> 
> 1. Simplify locking in certain complicated cases - like module
>    unloading or Hotplug CPU support.

I thought that refrigerator mechanism might be handy for hotplug CPU
support -- essentially stop whole userland, do your job, restart
userland... Its part of swsusp.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
