Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTGGMGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266945AbTGGMGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:06:17 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:17413 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264935AbTGGMGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:06:16 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Mon, 7 Jul 2003 14:19:57 +0200
User-Agent: KMail/1.5.2
References: <200307070317.11246.kernel@kolivas.org> <200307071319.57511.kernel@kolivas.org> <200307071151.12553.sandersn@btinternet.com>
In-Reply-To: <200307071151.12553.sandersn@btinternet.com>
Cc: Nick Sanders <sandersn@btinternet.com>, Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307071343.26318.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 12:51, Nick Sanders wrote:

Hi Con, Hi Andrew,

> > Thanks to Felipe who picked this up I was able to find the one bug
> > causing me grief. The idle detection code was allowing the sleep_avg to
> > get to ridiculously high levels. This is corrected in the following
> > replacement O3int patch. Note this fixes the mozilla issue too. Kick
> > arse!!
> Just booted with patch-O3int-0307071315 on top of 2.5.74-mm2 and the mouse
> stuttering under high CPU load has gone and no audio skipping.
> Truly brilliant work
> Thank you
> Nick
Hmm, this becomes better and better, but it's still not perfect [tm].

- An Xterm needs ~30 seconds to open up while "make -j16 bzImage modules"
- An Xterm needs ~15 seconds to open up while "make -j8 bzImage modules"
- XMMS does _not_ skip mp3's while above.
- Kmail is almost unusable while above (stops for about 5 secs every 15-20
  secs). KMail is also very slow while the machine is doing nothing.
- X runs with nice 0, prio 15 (nice -11 is prio 4, does not make difference)

Over all, the whole system seems in a ~snail mode.

Andrew, two things:

1. I'll test it with high job numbers, because it _must_ be possible to use
   that w/o any stops of xmms music, w/o X running like a dog etc.
2. I use anticipatory scheduler for sure. Best I've ever seen, never had
   any problems. :)

ciao, Marc

