Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266994AbTGGM6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266998AbTGGM6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:58:43 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:55488 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S266994AbTGGM6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:58:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Mon, 7 Jul 2003 23:14:18 +1000
User-Agent: KMail/1.5.2
Cc: Nick Sanders <sandersn@btinternet.com>, Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200307070317.11246.kernel@kolivas.org> <200307071151.12553.sandersn@btinternet.com> <200307071343.26318.m.c.p@wolk-project.de>
In-Reply-To: <200307071343.26318.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307072314.18258.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003 22:19, Marc-Christian Petersen wrote:
> On Monday 07 July 2003 12:51, Nick Sanders wrote:
>
> Hi Con, Hi Andrew,
>
> > > Thanks to Felipe who picked this up I was able to find the one bug
> > > causing me grief. The idle detection code was allowing the sleep_avg to
> > > get to ridiculously high levels. This is corrected in the following
> > > replacement O3int patch. Note this fixes the mozilla issue too. Kick
> > > arse!!
> >
> > Just booted with patch-O3int-0307071315 on top of 2.5.74-mm2 and the
> > mouse stuttering under high CPU load has gone and no audio skipping.
> > Truly brilliant work
> > Thank you
> > Nick
>
> Hmm, this becomes better and better, but it's still not perfect [tm].

Thanks for feedback. I will keep working on it while I still have ideas and 
direction based on the feedback. 

> - An Xterm needs ~30 seconds to open up while "make -j16 bzImage modules"
> - An Xterm needs ~15 seconds to open up while "make -j8 bzImage modules"
> - XMMS does _not_ skip mp3's while above.
> - Kmail is almost unusable while above (stops for about 5 secs every 15-20
>   secs). KMail is also very slow while the machine is doing nothing.
> - X runs with nice 0, prio 15 (nice -11 is prio 4, does not make
> difference)

Noted; and considered the next major hurdle (was also the most notable 
complaint from Mike).

Con

