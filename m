Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284134AbRLMPFh>; Thu, 13 Dec 2001 10:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRLMPFR>; Thu, 13 Dec 2001 10:05:17 -0500
Received: from mustard.heime.net ([194.234.65.222]:58846 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284090AbRLMPFQ>; Thu, 13 Dec 2001 10:05:16 -0500
Date: Thu, 13 Dec 2001 16:04:34 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] RAID sub system / tux
In-Reply-To: <Pine.LNX.4.33.0112130954410.13419-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112131558510.26038-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After testing this for a while, I'm quite sure there's some kind of bug
> > that locks up I/O under heavy traffic.
>
> there's definitely no problem with heavy load on one stream,
> or with multistream load and default readahead settings.
> (I certianly have tested the former, and the latter is tested
> by all the dbench scores you see here).  I'm guessing you'd
> see no lockup if you removed the readahead.  though it's also worth
> asking: have you memtest86's the cpu/ram?  and can you cause the
> lock with single-threaded bonnie?  also, do you have highmem on?

I have highmem turned off.

By using default readahead (124), starting the 50 streams, killing them,
and restarting them, I reproduced the problem. I rebooted the server
before this.

I haven't memtest86'd the hardware, but I will. I still beleive this is an
OS problem - not hardware

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

