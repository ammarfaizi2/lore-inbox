Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318815AbSICQxj>; Tue, 3 Sep 2002 12:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSICQxi>; Tue, 3 Sep 2002 12:53:38 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:30088 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318815AbSICQxh>; Tue, 3 Sep 2002 12:53:37 -0400
Date: Tue, 3 Sep 2002 18:58:02 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Mark Mielke <mark@mark.mielke.cc>
cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <20020903115837.A10750@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0209031856060.10770-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Mark Mielke wrote:

> I wonder if it does not make sense to just give the process real time
> priority? No scheduler will be excellent in all situations. I would not
> consider a game, or game server, to be a standard application.

If you are talking about SCHED_RR, I think it would lock up the server
since it only sleeps 1 ms which is done as a busy sleep for SCHED_RR
tasks.  The game server would have to be designed to use SCHED_RR in a
sensible way, in that case.  The source code is not availible... :-(

/Tobias

