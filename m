Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUHXVMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUHXVMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268357AbUHXVLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:11:00 -0400
Received: from web13921.mail.yahoo.com ([66.163.176.46]:18275 "HELO
	web13921.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268328AbUHXVKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:10:40 -0400
Message-ID: <20040824211141.13585.qmail@web13921.mail.yahoo.com>
Date: Tue, 24 Aug 2004 14:11:41 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41229ED8.3050304@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Williams <pwil3058@bigpond.net.au> wrote:

> Could you try it in "pb" mode with both max_ia_bonus and max_tpt_bonus 
> set to zero?  That will disable all "priority" fiddling and tasks should 
> just round robin at a priority determined solely by their "nice" value 
> and since (according to your earlier mail) all the daemons have the same 
> "nice" value they should just round robin with each other.


Hi, I tried the latest  V-5.0 patch over 2.6.8.1 in these conditions with the
actual server subsystem, and I get components timeouts :(
I also ran the watchdog script on the box while running the test, and saw
deltas of around 3 seconds every few hours:

Tue Aug 24 03:02:13 PDT 2004
>>>>>>> delta = 3
Tue Aug 24 05:50:14 PDT 2004
>>>>>>> delta = 3
Tue Aug 24 09:05:24 PDT 2004
>>>>>>> delta = 4
Tue Aug 24 09:06:20 PDT 2004
>>>>>>> delta = 4
Tue Aug 24 09:36:22 PDT 2004
>>>>>>> delta = 3
Tue Aug 24 10:20:16 PDT 2004
>>>>>>> delta = 3
Tue Aug 24 13:28:19 PDT 2004
>>>>>>> delta = 3

Could I do something more useful than just displaying those deltas? Maybe I
could dump the process list in some way, or enable some debugging code in the
kernel to find out what is going on?

Thanks

Nicolas

=====
------------------------------------------------------------
video meliora proboque deteriora sequor
------------------------------------------------------------
