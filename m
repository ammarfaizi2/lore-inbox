Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317377AbSFCMNx>; Mon, 3 Jun 2002 08:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317382AbSFCMNw>; Mon, 3 Jun 2002 08:13:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20237 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317377AbSFCMNv>; Mon, 3 Jun 2002 08:13:51 -0400
Date: Mon, 3 Jun 2002 14:13:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend.c: This is broken, fixme
Message-ID: <20020603121352.GA22241@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020603095507.GA3030@elf.ucw.cz> <20020603110816.GI820@suse.de> <20020603113221.GA17228@atrey.karlin.mff.cuni.cz> <20020603113548.GB21035@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm alone at the system at that point. All user tasks are stopped and
> > I'm only thread running. There's noone that could submit requests at
> > that point.
> 
> Ok, then at least the very last point I made can be disregarded.
> However... ->
> 
> > In such case, killing #error is right solution, right?
> 
> Not at all. The tq_disk/blk_run_queues() semantics are the same, they
> will only start i/o (which may not even be right when you run it) and
> that is it. When all i/o is completed is not known.

Is there some way to wait for all I/O to compelte? How do we do that
on system shutdown?
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
