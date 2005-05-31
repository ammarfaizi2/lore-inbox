Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVEaRXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVEaRXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVEaRVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:21:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24595
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261941AbVEaRLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:11:54 -0400
Date: Tue, 31 May 2005 19:11:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
Subject: Re: RT patch acceptance
Message-ID: <20050531171143.GS5413@g5.random>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk> <1117556283.2569.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117556283.2569.26.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 12:18:03PM -0400, Steven Rostedt wrote:
> Later, while working at Lockheed, we had WindRiver over and they would
> only give a small broken down (basically all features removed) OS that
> Lockheed would be responsible for testing.
> 
> When someone mentions Hard-RT, this is what I think about.  These are

I think testing is the wrong word. The code should be demonstrated to be
correct, and to do so it must be stripped down and as simple as
possible. Then the more testing the better to verify it's all right, but
people shouldn't depend _only_ on huge testing. Probably linux is too
big anyway for those usages, but certainly one needs a guarantee of
hard-RT for those usages that preempt-RT sure can't provide (while
nanokernel/RTAI could at least in theory provide it, assuming rest of
linux itself has no bugs and no memory corruption/deadlocks leading to a
full system crash).
