Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbTGHAWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266276AbTGHAWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:22:18 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:12708 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266270AbTGHAWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:22:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 17:29:13 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307080213.53203.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307072107.09855.phillips@arcor.de>
 <Pine.LNX.4.55.0307071202450.4704@bigblue.dev.mcafeelabs.com>
 <200307080213.53203.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Daniel Phillips wrote:

> On Tuesday 08 July 2003 00:03, Davide Libenzi wrote:
> > > > Try to play with SNDCTL_DSP_SETFRAGMENT. Last time I checked the kernel
> > > > let you set a dma buf for 0.5 up to 1 sec of play (upper limited by
> > > > 64Kb). Feeding the sound card with 4Kb writes will make you skip after
> > > > about 50ms CPU blackout at 44KHz 16 bit. RealPlayer uses 16Kb feeding
> > > > chunks that makes it able to sustain up to 200ms of blackout.
> > >
> > > That's just fiddling, it doesn't deal with the basic problem.  Anyway,
> > > big buffers have their own annoyances.  Have you tried the graphic
> > > equalizer in xmms lately?  A one second lag on slider adjustment is not
> > > nice.
> >
> > That's not fiddling. It is tuning your app so that it won't require
> > realtime when it is not needed.
>
> But realtime is needed, because there is a deadline for each buffer-fill.

Yes, in theory it is needed since you have to meet a deadline. But if
you program you timings such that your deadline is 400-500ms it is really
hard to lose it against one of 50-100ms.


- Davide

