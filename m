Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRCPRY7>; Fri, 16 Mar 2001 12:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130618AbRCPRYt>; Fri, 16 Mar 2001 12:24:49 -0500
Received: from [216.151.155.121] ([216.151.155.121]:20233 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129595AbRCPRYf>; Fri, 16 Mar 2001 12:24:35 -0500
To: Sane_Purushottam@emc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: fork and pthreads
In-Reply-To: <93F527C91A6ED411AFE10050040665D0560664@corpusmx1.us.dg.com>
From: Doug McNaught <doug@wireboard.com>
Date: 16 Mar 2001 12:23:15 -0500
In-Reply-To: Sane_Purushottam@emc.com's message of "Fri, 16 Mar 2001 11:34:04 -0500"
Message-ID: <m3r8zxfx18.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sane_Purushottam@emc.com writes:

> I am having a strange problem.
> 
> I have a big daemon program to which I am trying to add multi-threading.
> 
> At the begining, after some sanity check, this program does a double fork to
> create a deamon.
> 
> After that it listens for the client on the port. Whenever the client
> connects, it creates a new thread using
> pthread-create.
> 
> The problem is, the thread (main thread) calling pthread-create hangs
> indefinetely in __sigsuspend. The newly created thread however, runs
> normally to completion.

Just a guess--are you calling setsid() to establish a new session?
Omitting this *might* cause signal-delivery problems in pthreads.

-Doug
