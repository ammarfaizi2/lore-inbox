Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUDSNME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbUDSNMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:12:03 -0400
Received: from elma.elma.fi ([192.89.233.77]:30094 "EHLO elma.elma.fi")
	by vger.kernel.org with ESMTP id S264377AbUDSNL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:11:59 -0400
Date: Mon, 19 Apr 2004 16:11:57 +0300 (EETDST)
From: Antti Lankila <alankila@elma.net>
To: linux-kernel@vger.kernel.org
Subject: re: elevator=as, or actually gpm doesn't get time from scheduler???
Message-ID: <Pine.A41.4.58.0404191609060.42820@tokka.elma.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In response to Nick Piggin's:

> The only other problems I can think of that you might be
> having are chipset problems, or CPU scheduler problems.
> Which reminds me, do you have your X server at nice 0?

X has been reniced to zero. But hey! I was doing "cat /dev/psaux" when mouse
stopped moving in X, and I _did_ see data coming from /dev/psaux! So this is
a major update to my understanding of the problem.

But make no mistake, I have been doing this cat /dev/psaux test earlier and
at that time I did _not_ see chars coming out of psaux when the mouse
stopped. That is why I thought I had established that the problem is in the
kernel. I must retest this on the other machines involved when I get to
their consoles next week. I can not explain why this time psaux appears to
work regardless of the userland mouse stall, so for now I must assume some
other factor confused the cat /dev/psaux test at that time.

My X reads gpmdata, so perhaps that's the problem? I now undercut gpm in
order to examine the situation, and my system behaves _perfectly_ as far as
I can see. The mouse issues are all gone. (gpm is still running in the
background, X just reads psaux directly. As I have understood, this is
possible in 2.6 while in 2.4 it caused a problem for multiple readers.)

I progress from now by removing gpm on all my systems.  There's still the
issue what gpm (or maybe kernel's scheduler) is doing wrong, I suppose.
Nevertheless, gpm is virtually useless for me and has so far caused far more
grief than its utility has ever been worth.

I'm sorry for having wasted your time with this.

Antti
