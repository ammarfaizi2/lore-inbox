Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSIAVs5>; Sun, 1 Sep 2002 17:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSIAVs5>; Sun, 1 Sep 2002 17:48:57 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:31617 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318062AbSIAVs5>; Sun, 1 Sep 2002 17:48:57 -0400
Date: Sun, 1 Sep 2002 23:53:23 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problem with the O(1) scheduler in 2.4.19
Message-ID: <Pine.LNX.4.44.0208301822200.2042-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While the O(1) scheduler has performed very well for me in most
situations, I have one big problem with it.  When running a Counter-Strike
game server on Linux 2.4.19 with the sched-2.4.19-rc2-A4 patch applied,
the server process is niced from the default value of 15 (interactive) to
25 (background).  This means that every time crond wakes up or a mail
arrives the game latency becomes extremely bad and the users experience
lag.

The process takes around 70% CPU on these occasions, so I'm surprised that
the task is not considered to be interactive.

This does not happen with stock 2.4.19.  Do you have any ideas why this
regression is happening?

/Tobias

