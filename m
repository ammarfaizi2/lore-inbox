Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263399AbTC2ICl>; Sat, 29 Mar 2003 03:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263400AbTC2ICl>; Sat, 29 Mar 2003 03:02:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22741 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S263399AbTC2ICX>;
	Sat, 29 Mar 2003 03:02:23 -0500
Date: Sat, 29 Mar 2003 09:13:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: David Mansfield <lkml@dm.cobite.com>
Cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: very poor performance in 2.5.66[-mm1]
In-Reply-To: <Pine.LNX.4.44.0303281641320.11928-100000@admin>
Message-ID: <Pine.LNX.4.44.0303290911500.3834-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Mar 2003, David Mansfield wrote:

> Yes. gnome-terminal is godawful slow on RHAT 8.0 (it does Xrender
> alpha-channel crap for every character to get the anti-aliasing).  But I
> think the problem has to do with the pipe/pty wakeups.  After 'ls'
> writes a line to the pty, it seems as though the gnome-terminal is being
> woken up (even though 'ls' has more to write), it's generating the
> Xrender X-command and sending it to X.  X is waking up and rendering it
> (which forces a complete update of the screen).

this is a known bug in vte, fixed in the rawhide vte package. (you might
need to upgrade other packages as well.) Eg. try another, non-gnome-vte
based terminal, such as xterm or konsole, it wont show this problem.

	Ingo

