Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264660AbRFYPvE>; Mon, 25 Jun 2001 11:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbRFYPuy>; Mon, 25 Jun 2001 11:50:54 -0400
Received: from mnh-1-17.mv.com ([207.22.10.49]:36357 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264650AbRFYPui>;
	Mon, 25 Jun 2001 11:50:38 -0400
Message-Id: <200106251705.MAA02325@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Bulent Abali" <abali@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Stevenson <mistral@stev.org>
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state 
In-Reply-To: Your message of "Mon, 25 Jun 2001 10:10:38 -0400."
             <OF7B251945.42FE908D-ON85256A76.004C34E9@pok.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Jun 2001 12:05:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

abali@us.ibm.com said:
> I am running in to a problem, seemingly a deadlock situation, where
> almost all the processes end up in the TASK_UNINTERRUPTIBLE state.
> All the process eventually stop responding, including login shell, no
> screen updates, keyboard etc.  Can ping and sysrq key works.   I
> traced the tasks through sysrq-t key.  The processors are in the idle
> state.  Tasks all seem to get stuck in the __wait_on_page or
> __lock_page.

I've seen this under UML, Rik van Riel has seen it on a physical box, and we 
suspect that they're the same problem (i.e. mine isn't a UML-specific bug).

I've done some poking at the problem, but haven't really learned anything 
except that something is locking pages and not unlocking them.  Figuring out 
who that is was going to be my next step.

If anyone is interested in poking around a UML in this state (i.e. you get all 
the niceties of gdb), let me know.  I think I can probably oblige.

				Jeff


