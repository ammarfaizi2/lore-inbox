Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVIAPFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVIAPFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbVIAPE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:04:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46517 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965183AbVIAPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:04:55 -0400
Date: Wed, 31 Aug 2005 20:20:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050831182050.GC703@openzaurus.ucw.cz>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830145602.GN8515@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830145602.GN8515@g5.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [..] combined 
> > with an automatic oops/panic/bug-report this would be _very_ useful I think.
> 
> That would be nice addition IMHO. It'll be more complex since it'll
> involve netconsole dumping and passing the klive session to the kernel
> somehow (userland would be too unreliable to push the oops to the
> server). The worst part is that oops dumping might expose random kernel
> data (it could contain ssh keys as well), so I would either need to
> purify the stack/code/register lines making the oops quite useless, or
> not to show it at all (and only to show the count of the oopses
> publically). A parameter could be used to tell the kernel if the whole
> oops should be sent to the klive server or if only the notification an
> oops should be sent (without sending the payload with potentially
> sensitive data inside).

Well, you could remove everything that is not valid kernel text from backtrace.

That should make ssh keys non-issue and still provide usefull information.

Oh and you probably want to somehow identify modified kernels.
Otherwise if I do some development on 2.3.4-foo5, you'll get many oopsen
caused by my development code... it is getting complex.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

