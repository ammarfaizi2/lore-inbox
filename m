Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbTC1Ucg>; Fri, 28 Mar 2003 15:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263133AbTC1Ucg>; Fri, 28 Mar 2003 15:32:36 -0500
Received: from [12.47.58.223] ([12.47.58.223]:29798 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263132AbTC1Ucf>; Fri, 28 Mar 2003 15:32:35 -0500
Date: Fri, 28 Mar 2003 12:44:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: very poor performance in 2.5.66[-mm1]
Message-Id: <20030328124451.2d09bd33.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303281247480.11928-100000@admin>
References: <Pine.LNX.4.44.0303281247480.11928-100000@admin>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 20:43:45.0577 (UTC) FILETIME=[BA012190:01C2F56A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield <lkml@dm.cobite.com> wrote:
>
> 
> Hi list.
> 
> After all of the rave reviews about the interactivity fixes (both regular 
> and I/O scheduler related), I decided to give the 2.5.latest a try on my 
> desktop machine (system described below)
> 
> I started X, everything seemed fine, maybe a bit faster.  I opened a 
> 'gnome-terminal' and typed 'ls -ltr'.  Wow, it was 20x slower.
> 
> Here are the timings for 'ls -ltr':
> 
> 2.5.66-mm1:      'ls -ltr'         31 seconds
> 2.5.66-mm1:      'ls -ltr | cat'   2 seconds
> 2.4.18-rhlatest: 'ls -ltr'         1.14 seconds

How many files were there?

My /usr/bin contains 3168 files.  An `ls -ltr' in gnome-terminal takes 9.6
seconds.  In rxvt it takes 0.5 seconds.  That's an 850MHz P3.

So gnome-terminal appears to be a pretty slow application.  My guess would be
that something in the 2.5 kernel has exposed a marginality or an outright
bug in it.

It would be interesting to edit include/asm-i386/param.h and set HZ to 100.

