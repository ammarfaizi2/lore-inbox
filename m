Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFABGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFABGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFABGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:06:13 -0400
Received: from opersys.com ([64.40.108.71]:3849 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261220AbVFABFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:05:06 -0400
Message-ID: <429D0C13.3000006@opersys.com>
Date: Tue, 31 May 2005 21:14:59 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>, Esben Nielsen <simlo@phys.au.dk>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random>
In-Reply-To: <20050531204544.GU5413@g5.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ removed a lot of interesting stuff ... ]

Andrea Arcangeli wrote:
> The point where preempt-RT enters the hard-RT equation, is only if you need
> syscall execution in realtime (like audio, but audio doesn't need
> hard-RT, so preempt-RT can only do good from an audio standpoint, it
> makes perfect sense that jack is used as argument for preempt-RT). If
> you need syscalls with hard-RT, the whole thing gets an order of
> magnitude more complicated and software becomes involved anyways, so
> then one can just hope that preempt-RT will get everything right and
> that somebody will demonstrate it.

Please have a look at RTAI-fusion. It provides deterministic
replacements for rt-able syscalls _transparently_ to STANDARD
Linux applications. For example, an unmodified Linux application
can get a deterministic nanosleep() via RTAI-fusion. The way
this works, is that rtai-fusion catches the syscalls prior to
them reaching Linux. So even the syscall thing isn't really a
limitation for RTAI anymore.

Philippe would be in a better position to elaborate, but that's
the essentials of it.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
