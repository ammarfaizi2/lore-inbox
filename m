Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278908AbRKIA36>; Thu, 8 Nov 2001 19:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278924AbRKIA3k>; Thu, 8 Nov 2001 19:29:40 -0500
Received: from [208.129.208.52] ([208.129.208.52]:9220 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278890AbRKIA3X>;
	Thu, 8 Nov 2001 19:29:23 -0500
Date: Thu, 8 Nov 2001 16:37:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <20011108153749.A14468@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0111081632400.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Mike Fedyk wrote:

> Ingo's patch in effect lowers the number of jiffies taken per second in the
> scheduler (by making each task use several jiffies).
>
> Davide's patch can take the default scheduler (even Ingo's enhanced
> scheduler) and make it per processor, with his extra layer of scheduling
> between individual processors.

Don't mix things :)
We're talking only about the CpuHistory token of the scheduler proposed here:

http://www.xmailserver.org/linux-patches/mss.html

This is a bigger ( and not yet complete ) change on the SMP scheduler
behavior, while it keeps the scheduler that runs on each CPU the same.
I'm currently working on different balancing methods to keep the proposed
scheduler fair well balanced without spinning tasks "too much"(tm).




- Davide


