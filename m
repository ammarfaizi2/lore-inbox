Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280718AbRKJUtg>; Sat, 10 Nov 2001 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280719AbRKJUt0>; Sat, 10 Nov 2001 15:49:26 -0500
Received: from [216.151.155.121] ([216.151.155.121]:23813 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S280718AbRKJUtQ>; Sat, 10 Nov 2001 15:49:16 -0500
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <Pine.LNX.4.21.0111102030150.12260-100000@Consulate.UFP.CX>
From: Doug McNaught <doug@wireboard.com>
Date: 10 Nov 2001 15:49:01 -0500
In-Reply-To: Riley Williams's message of "Sat, 10 Nov 2001 20:35:34 +0000 (GMT)"
Message-ID: <m3g07mpd1e.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.cx> writes:

> Hi Pavel.
> 
> > It ... just is not that way. Kernel + modules run at ring 0,
> > userland at ring 3.
> 
> I know that much. I was just curious whether there was any particular
> reason why it was that way.

Well, Unix has historically run on systems with at most two processor
privilege levels, "user" and "supervisor"; ie, you're either in user
or kernel mode.

ix86 is one of the few Linux platforms that offers more than two
levels, so having modules run in an in-between level would be a
portability headache as well as a lot of work.

Certainly not impossible, but you'd need to create task gates or
whatever they're called at every point where modules called into the
kernel (and vice versa as well I think).  Might be a serious
performance hit...

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
