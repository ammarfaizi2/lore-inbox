Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSJOGw1>; Tue, 15 Oct 2002 02:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbSJOGw1>; Tue, 15 Oct 2002 02:52:27 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5124 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263143AbSJOGw1>;
	Tue, 15 Oct 2002 02:52:27 -0400
Date: Mon, 14 Oct 2002 18:52:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Hu Gang <hugang@soulinfo.com>, linux-kernel@vger.kernel.org
Subject: Re: patch for 2.5.42. 2/2
Message-ID: <20021014185202.C585@elf.ucw.cz>
References: <20021013112019.496010fc.hugang@soulinfo.com> <Pine.LNX.4.44L.0210130133070.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210130133070.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- linux-2.5.42/drivers/net/3c59x.c	Sat Oct 12 21:25:00 2002
> > +++ linux-2.5.42-suspend/drivers/net/3c59x.c	Sat Oct 12 21:20:48 2002
> 
> > +#ifdef CONFIG_PM
> > +	int in_suspend;
> > +#endif
> 
> This looks like a serious design mistake.  Surely it would be
> better to just have the network layer stop operations when the
> system is going into suspend, instead of having to modify 100
> individual network drivers ?

Whole userland is stopped at that point. That should mean that new
requests can not come.

OTOH packet from the network *can* come, and higher levels can not do
much with that. [They could ifconfig down the network interface... But
that can have sideefects we don't want to see...]

								Pavel
-- 
When do you have heart between your knees?
