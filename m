Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284436AbRLRSLb>; Tue, 18 Dec 2001 13:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284444AbRLRSLV>; Tue, 18 Dec 2001 13:11:21 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:6920 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284436AbRLRSLG>; Tue, 18 Dec 2001 13:11:06 -0500
Date: Tue, 18 Dec 2001 10:13:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112172014530.2281-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112181011490.1591-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:

> The most likely cause is simply waking up after each sound interrupt: you
> also have a _lot_ of time handling interrupts. Quite frankly, web surfing
> and mp3 playing simply shouldn't use any noticeable amounts of CPU.

It must be noted that wking up a task is going to take two lock operations
( and two unlock ), one in try_to_wakeup() and the other one in schedule().
This double the frequency seen by the lock.



- Davide


