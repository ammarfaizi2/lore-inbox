Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRCEOhe>; Mon, 5 Mar 2001 09:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRCEOhZ>; Mon, 5 Mar 2001 09:37:25 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:50653 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129309AbRCEOhN>; Mon, 5 Mar 2001 09:37:13 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: <linux-fbdev-devel@sourceforge.net>, Cort Dougan <cort@fsmlabs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatches] removal of console_lock
Date: Mon, 5 Mar 2001 15:36:54 +0100
Message-Id: <19350128080838.10672@mailhost.mipsys.com>
In-Reply-To: <3AA38E05.549BCF95@uow.edu.au>
In-Reply-To: <3AA38E05.549BCF95@uow.edu.au>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Cort Dougan wrote:
>> 
>> I still get huge over-runs with fbdev (much improved, though).
>
>If you're referring to scheduling overruns then yes, you will
>still see monstrous ones.  We're still spending great lengths of
>time in the kernel, only now we're doing it with interrupts
>enabled.  We can still block all tasks for half a second at a time.

Well, at least having interrupts enabled is really nice for us on PPC
since we have this nasty chip (the PMU) that don't like at all beeing
interrupted for a long time in the middle of a message exchange.
It has caused endless trouble in the past and still, occasionally, when
you set your powerbook display bit depth to 32 and don't enable HW 
acceleration in the fbdev driver.

I hope your patch will be merged in as soon as possible :) I'll do some
tests here.

Ben.

