Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSC2Xwl>; Fri, 29 Mar 2002 18:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312320AbSC2Xwb>; Fri, 29 Mar 2002 18:52:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:26641 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312316AbSC2XwZ>;
	Fri, 29 Mar 2002 18:52:25 -0500
Subject: Re: Scheduler priorities
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Wessel Dankers <wsl@fruit.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020329214252.GA9974@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Mar 2002 18:52:21 -0500
Message-Id: <1017445941.2940.78.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-29 at 16:42, Pavel Machek wrote:

> On each entry of kernel, promote SCHED_IDLE task to SCHED_NORMAL, and
> demote it at exit. This can be done with 0 overhad on hot paths.

Agreed.

> What's the problem with "promote at enter" approach? Using ptrace
> trick, it can be 0 overhead. [Was that your code that cleverly used
> ptrace?] What is problem with it?

There is no problem with the ptrace approach, it is good - I have
experimented with that solution myself.  There is just a lot more to
SCHED_IDLE than "make the task only run when nothing else wants to" and
even the ptrace solution may involve a bit of work.

	Robert Love

