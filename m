Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284177AbRLFUGK>; Thu, 6 Dec 2001 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284164AbRLFUGE>; Thu, 6 Dec 2001 15:06:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55496 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283924AbRLFUFn>;
	Thu, 6 Dec 2001 15:05:43 -0500
Date: Thu, 6 Dec 2001 23:03:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <Pine.LNX.4.40.0112061021080.1603-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0112062301070.24309-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Dec 2001, Davide Libenzi wrote:

> What about decreasing counter by 1 for each sched_yield() call ?

we did that in earlier kernels - it's not really the right thing to do, as
calling yield() does not mean we are willing to give up a *timeslice*. It
only means that right now we are not able to proceed.

	Ingo


