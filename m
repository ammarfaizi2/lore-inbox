Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271886AbTG2QOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271889AbTG2QOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:14:51 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:52696 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S271886AbTG2QOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:14:48 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Timothy Miller <miller@techsource.com>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Wed, 30 Jul 2003 11:17:07 -0500
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, ed.sweetman@wmich.edu,
       eugene.teo@eugeneteo.net, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307300946.41674.phillips@arcor.de> <3F26957E.7040204@techsource.com>
In-Reply-To: <3F26957E.7040204@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301117.08273.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 10:40, Timothy Miller wrote:
> IF it's possible to intelligently determine interactivity and other such
> things, and lots of impressive progress is being made in that area, then
> that is definately preferable.

But it's not possible to determine realtimeness automatically, as far as I 
know.

> ...It might help to have an API for real-time processes that is accessible
> by non-root tasks.  If a task sets itself to real-time, its scheduling
> is more predictable, but it gets a shorter timeslice (perhaps) so that
> being real-time doesn't adversely impact the system when abused.

That's precisely what Davide's SCHED_SOFTRR is and does.

> The nice thing about the smart schedulers is that (a) no one has to
> change their apps (although they can tweak to cooperate better), and (b)
> future apps will behave well without us having to anticipate anything.

On the other hand, you want to avoid messing up the kernel just because some 
app is broken.  While it's not always possible to avoid changing apps to fix 
them, in the case of audio apps on Linux at this point in time, it most 
certainly is.

Regards,

Daniel

