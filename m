Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289309AbSAPB4I>; Tue, 15 Jan 2002 20:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289290AbSAPBz7>; Tue, 15 Jan 2002 20:55:59 -0500
Received: from zero.tech9.net ([209.61.188.187]:19208 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289309AbSAPBzr>;
	Tue, 15 Jan 2002 20:55:47 -0500
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Ed Tomlinson <tomlins@cam.org>, Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201160343230.30495-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201160343230.30495-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 20:59:08 -0500
Message-Id: <1011146349.8756.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 21:48, Ingo Molnar wrote:

> there is a way: renicing. Either use nice +19 on the compilation job or
> use nice -5 on the 'known good' tasks. Perhaps we should allow a nice
> decrease of up to -5 from the default level - and things like KDE or Gnome
> could renice interactive tasks, while things like compilation jobs would
> run on the default priority.

This isn't a bad idea, as long as we don't use it as a crutch or
excuse.  That is, answer scheduling problems with "properly nice your
tasks" -- the scheduler should be smart enough, to some degree.

FWIW, Solaris actually implements a completely different scheduling
policy, SCHED_INTERACT or something.  It is for windowed tasks in X --
they get a large interactivity bonus.

	Robert Love

