Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUGUKOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUGUKOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 06:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUGUKOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 06:14:37 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:17560 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S266487AbUGUKOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 06:14:33 -0400
Date: Wed, 21 Jul 2004 12:14:10 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721101410.GA26447@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721000348.39dd3716.akpm@osdl.org>
X-Operating-System: Linux 2.6.7-bk20 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ shorter CC: list, this is neither audio nor voluntary preempt related ]

On Wed, 21 Jul 2004 00:03:48 -0700, Andrew Morton wrote:
> > (I modified the patch by hand to apply on this kernel, as
> > 2.6.8-rc2 disables my network card).
> 
> eh?  That's a rather more serious problem.  Does the via-rhine.c from
> 2.6.8-rc1-mm1 work OK if you move it into 2.6.8-rc2?

As I mentioned previously on this list, I noticed the problem first when
I moved to 2.6.7-bk20, but when I tried to investigate, it disappeared
and never came back (thus, my summary is largely based on reports by
others). I attributed it to some intermittent hardware problem until
someone else reported it (see lkml thread: "via-rhine breaks with recent
Linus kernels : probe of 0000:00:09.0").

The problem started in mainline between 2.6.7 and 2.6.7-bk20. It does not
exist in the -mm series which contains a later version of via-rhine. IOW,
updating mainline to the latest version of via-rhine would presumably
fix the problem but it might introduce new problems and we'd never know
what the bug was and if it was actually fixed or just masked.

I hate having via-rhine broken in mainline, but I'm busy with other
stuff and I can't reproduce the problem anymore, so basically I am
waiting to hear back from Jesper Juhl who volunteered to find the patch
that makes the difference between mainline and -mm.

Roger
