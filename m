Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTGHVHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267652AbTGHVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:07:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:65184 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264208AbTGHVHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:07:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 14:13:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Guillaume Chazarain <gfc@altern.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Interactivity bits
In-Reply-To: <JFNL84UTSKFOJFDFD9D8GBF2WICKG.3f0b25af@monpc>
Message-ID: <Pine.LNX.4.55.0307081409580.4792@bigblue.dev.mcafeelabs.com>
References: <JFNL84UTSKFOJFDFD9D8GBF2WICKG.3f0b25af@monpc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Guillaume Chazarain wrote:

> Hello,
>
> Currently the interactive points a process can have are in a [-5, 5] range,
> that is, 25% of the [0, 39] range. Two reasons are mentionned:
>
> 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
> 2) nice -20 CPU hogs do not get preempted by nice 0 tasks.
>
> But, using 50% of the range, instead of 25% the interactivity points are better
> spread and both rules are still respected.  Having a larger range for
> interactivity points it's easier to choose between two interactive tasks.
>
> So, why not changing PRIO_BONUS_RATIO to 50 instead of 25?
> Actually it should be in the [45, 49] range to maximize the bonus points
> range and satisfy both rules due to integer arithmetic.

I believe these are the bits that broke the scheduler, that was working
fine during the very first shots in 2.5. IIRC Ingo was hit by ppl
complains about those 'nice' rules and he had to fix it. It'd be
interesting bring back a more generous interactive bonus and see how the
scheduler behave.



- Davide

