Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTGGRvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTGGRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:51:12 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:8094 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264201AbTGGRvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:51:11 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 10:58:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Mel Gorman <mel@csn.ul.ie>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307071728.08753.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307071030210.4704@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <Pine.LNX.4.53.0307071408440.5007@skynet>
 <Pine.LNX.4.55.0307070745250.4428@bigblue.dev.mcafeelabs.com>
 <200307071728.08753.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Daniel Phillips wrote:

> That's not correct in this case, because the sound servicing routine is
> realtime, which makes it special.  Furthermore, Zinf is already trying to
> provide the kernel with the hint it needs via PThreads SetPriority but
> because Linux has brain damage - both in the kernel and user space imho - the
> hint isn't accomplishing what it's supposed to.
>
> As I said earlier: trying to detect automagically which threads are realtime
> and which aren't is stupid.  Such policy decisions don't belong in the
> kernel.

Having hacked a little bit with vsound I can say that many sound players
do not use at 100% the buffering the sound card/kernel is able to provide
and they still use 4-8Kb feeding chunks. That require very short timings
to not lose the time.



- Davide

