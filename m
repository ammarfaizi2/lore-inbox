Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267462AbTGHPSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbTGHPSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:18:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24708 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267462AbTGHPRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:17:34 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 08:24:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <3F0A8C5C.1070602@cyberone.com.au>
Message-ID: <Pine.LNX.4.55.0307080821160.4544@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307080213.53203.phillips@arcor.de>
 <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com>
 <200307080307.18018.phillips@arcor.de> <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com>
 <3F0A8C5C.1070602@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Nick Piggin wrote:

> I agree some people have some inflated ideas about a desktop workload,
> but I'd just point out that if your mp3 player was using say 2% CPU,
> it should be able to preempt the make soon after it becomes runnable,
> and not have to wait at the end of the queue. It would become a CPU
> hog itself if you had 48 other processes running though.

This is clearly true, actually even more since player usually suck way
less than 2% of the CPU. If no video is involved, they simply do a write()
to /dev/dsp and then they sync by calling GETOSPACE and sleeping in the
"hope" to be wake up almost in time. I never said that the scheduler
should not be fixed. It definitely has to.



- Davide

