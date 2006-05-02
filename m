Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWEBFCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWEBFCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWEBFCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:02:12 -0400
Received: from xenotime.net ([66.160.160.81]:37858 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932361AbWEBFCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:02:11 -0400
Date: Mon, 1 May 2006 22:04:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
Message-Id: <20060501220432.02bf8680.rdunlap@xenotime.net>
In-Reply-To: <20060502042108.GD5691@widomaker.com>
References: <1143510828.1792.353.camel@mindpipe>
	<20060327195905.7f666cb5.akpm@osdl.org>
	<20060405144716.GA10353@widomaker.com>
	<443B69BE.6060601@tlinx.org>
	<20060502042108.GD5691@widomaker.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 00:21:08 -0400 Charles Shannon Hendrix wrote:

> Tue, 11 Apr 2006 @ 01:33 -0700, Linda Walsh said:
> 
> >    Hmmm, not to be contrary, but I have a 1GB system that refuses to swap
> > during large file i/o operations.  For the first time in a *long* time,
> > I read someone's suggestion to increase swappiness -- I did, to 75 or 80,
> > (I've booted since then, so it's back to 60 and no swap usage) and some of
> > the programs that rarely run actually swapped.  It was great!  I finally had
> > more memory for file i/o operations.
> 
> It's great if you actually need the file data that gets stored.
> 
> >    Maybe you are telling the system to "feel free" to use swap by having a
> > large swap file?  
> 
> I don't believe that matters, and certainly doesn't seem to affect my
> own system.
> 
> If I use a smaller swap file, I just run out faster.
> 
> Is your experience different?
> 
> > I agree.  Try getting rid of your swap file entirely -- your system
> > will still run unless you are overloading memory, but you have a Gig.
> > How much do you need to keep in memory?  Sure, if/when I get a 4-way
> > CPU (I have a 2-cpu setup now), I might go up to 4G, but I might be
> > running multiple virtual machines too!
> 
> Sure it will run, but I *want* swap to be used to remove unused
> programs.
> 
> My current problem is that *useful* program code is being swapped out and
> being replaced by *useless* cached file data.
> 
> >    You might try the "cfq" block i/o algorithm.  Then you can
> > ionice down the disk priority of background processes (though you need
> > to be root to reduce ionice levels at this point, unlike cpu nice).
> 
> I've not seen ionice.

It's hidden^w embedded in Documentation/block/ioprio.txt ...

---
~Randy
