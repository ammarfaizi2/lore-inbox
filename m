Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275118AbTHAGYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275119AbTHAGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:24:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29117 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S275118AbTHAGYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:24:11 -0400
Date: Fri, 1 Aug 2003 08:23:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linas@austin.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030731175605.A26460@forte.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0308010819510.19862-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003 linas@austin.ibm.com wrote:

> Well, I'm confused by this a bit too, now.  I saw this bug in 2.4 and I
> thought that Andrea was implying that it couldn't happen in 2.6. He
> seemed to be saying that the del_timer_sync() + add_timer() race can
> happen only in 2.4, where add_timer() is running on the 'wrong' cpu
> bacuase it got there through the evil run_all_timers()/TIMER_BH.  Since
> there's no run_all_timers() in 2.6, he seemed to imply that the race
> 'couldn't happen'.  Is he right?

it is correct, but it was me convincing Andrea about this, not the other
way around :-) Pls. re-read the email thread. My point still stands:

>> (in any case, i still think it would be safer to 'upgrade' the
>> add_timer() interface to be SMP-safe and to allow double-adds - but not
>> for any bug reason anymore.)

this should also make backporting easier.

	Ingo


