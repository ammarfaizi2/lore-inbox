Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279066AbRJVXKx>; Mon, 22 Oct 2001 19:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279072AbRJVXJf>; Mon, 22 Oct 2001 19:09:35 -0400
Received: from zero.tech9.net ([209.61.188.187]:42506 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279060AbRJVXIn>;
	Mon, 22 Oct 2001 19:08:43 -0400
Subject: Re: [PATCH] updated preempt-kernel
From: Robert Love <rml@tech9.net>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110221532.f9MFWH615801@deathstar.prodigy.com>
In-Reply-To: <200110221532.f9MFWH615801@deathstar.prodigy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 22 Oct 2001 19:08:19 -0400
Message-Id: <1003792101.1496.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-22 at 11:32, bill davidsen wrote:
>   Is this safe to try on SMP again? The one-previous 2.4.12-ac3 patch
> seems stable on a P5-100+48MB RAM, which I use as a test for things
> helping dog-slow systems, did not run well on a BP6 (crashed on first
> login). I didn't report it because I try to have some useful info to
> report and had no time.

Hm, your report of failure on the BP6 is the first I have heard of
that.  I did (re)fix a race in a later release that may solve your
problem.

I would be very interested to see if you can replicate the problem on
2.4.12-ac5 with the corresponding preempt-kernel patch from
http://tech9.net/rml/linux ... I hope not.

>   Also, has this been tested with experimental kernel pcmcia or the real
> pcmcia package? The BP6 is my only non-laptop pcmcia.

You will need to recompile pcmcia, but then it should work.  Dave Hinds
merged specific support for detecting preempt on compile into 3.1.30 ...
but as long as the pcmcia-cs build can find your .config, with
CONFIG_PREEMPT set, you should be OK.

	Robert Love

