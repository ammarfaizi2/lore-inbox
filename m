Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292272AbSBYVC5>; Mon, 25 Feb 2002 16:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292273AbSBYVCs>; Mon, 25 Feb 2002 16:02:48 -0500
Received: from mustard.heime.net ([194.234.65.222]:7853 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292272AbSBYVCg>; Mon, 25 Feb 2002 16:02:36 -0500
Date: Mon, 25 Feb 2002 22:01:47 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <jakob@unthought.net>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202251020430.8317-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.30.0202252158061.17713-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Will this driver shut off the watchdog when /dev/watchdog is closed, or
> > does it require an explicit shutdown message like Jakob Oestergaard's
> > sbc60xxwdt driver?
>
> Depends on wether CONFIG_WATCHDOG_NOWAYOUT is specified.

problem is - I want to be able to explicitly close it, like Jakob's
variant is. Isn't this a functionality everyone would like?

Think about it - like - if a server of some reason uses long time to
umount its filesystems. Would it be a good thing if the server just
reboots in the middle of a umount? I think not. I beleive Jakob's solution
is quite a bit better, and it shouldn't be _too_ hard to add those extra
lines of code.

Btw: I'm implementing Jakob's way on the softdog ... patch coming later

roy

--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

