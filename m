Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263360AbTCNPtC>; Fri, 14 Mar 2003 10:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTCNPtC>; Fri, 14 Mar 2003 10:49:02 -0500
Received: from segfault.kiev.ua ([193.193.193.4]:59917 "EHLO segfault.kiev.ua")
	by vger.kernel.org with ESMTP id <S263360AbTCNPtB>;
	Fri, 14 Mar 2003 10:49:01 -0500
Date: Fri, 14 Mar 2003 17:59:48 +0200
From: Valentin Nechayev <netch@netch.kiev.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030314155947.GD13106@netch.kiev.ua>
Reply-To: netch@netch.kiev.ua
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311142447.GA14931@bjl1.jlokier.co.uk.lucky.linux.kernel>
X-42: On
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Tue, Mar 11, 2003 at 14:27:50, jamie wrote about "Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...": 

> Actually I think _this_ is cleanest: A three-way flag per registered
> fd interest saying whether to:
> 
> 	1. Report 0->1 edges for this interest.  (Initial 1 counts as an event).
> 	2. Continually report 1 levels for this interest.
> 	3. One-shot, report the first time 1 is noted and unregister.
> 
> ET poll is equivalent to 1.  LT poll is equivalent to 2.  dnotify's
> one-shot mode is equivalent to 3.

kqueue can do all three variants (1st with EV_CLEAR, 3rd with EV_ONESHOT).

So, result of this whole epoll work is trivially predictable - Linux will have
analog of "overbloated" and "poorly designed" kqueue, but more poor
and with incompatible interface, adding its own stone to hell of
different APIs. Congratulations.

Linus was true: Linux is just for fun, not for work.

I say nothing bad for the real work to implement it. But the person who said
"Do poor, do incompatible, but do our own" should be blamed. You know him.


-netch-
