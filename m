Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273626AbRJEUhS>; Fri, 5 Oct 2001 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRJEUg6>; Fri, 5 Oct 2001 16:36:58 -0400
Received: from quechua.inka.de ([212.227.14.2]:26120 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S272074AbRJEUgr>;
	Fri, 5 Oct 2001 16:36:47 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: <3BBDD37D.56D7B359@isg.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15pbid-0007fi-00@calista.inka.de>
Date: Fri, 05 Oct 2001 22:37:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BBDD37D.56D7B359@isg.de> you wrote:
> Without a proper pselect() implementation (the one in glibc is just
> a mock-up that doesn't prevent the race condition) I'm currently
> unable to come up with a good idea on how to wait on both types
> of events.

Isnt select() returning with EINTR?

> A somewhat bizarre solution would be to have the process create
> a pipe-pair, select on the reading end, and let the signal-handler
> write a byte to the pipe - but this has at least the drawback
> you always spoil one "select-cycle" for each signal you get

Well, you can use the pipe instead of the signal. What kind of signal do you
try to trap? Looks like you want to do critical high load stuff with a
signal.

Greetings
Bernd
