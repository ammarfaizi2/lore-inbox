Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270878AbTGPK14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270896AbTGPK0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:26:46 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:59626
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S270878AbTGPKZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:25:18 -0400
Date: Wed, 16 Jul 2003 12:19:49 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sean Neakums <sneakums@zork.net>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716101949.GE2684@wind.cocodriloo.com>
References: <6uwueidhdd.fsf@zork.zork.net> <Pine.LNX.4.44.0307161052310.6193-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307161052310.6193-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:55:52AM +0200, Ingo Molnar wrote:
> 
> On Wed, 16 Jul 2003, Sean Neakums wrote:
> 
> > [...] If I keep running 'ps aux' its output does start to become slow
> > again, snapping back to full speed after a few more runs.  Kind of an
> > odd one.
> 
> there was a similar bug in the gnome terminal code, it was a userspace X
> window-refresh/event-qeueing bug/race that was sensitive to scheduler
> timings. So it can go away and come back based on precise timings. Eg. it
> was more likely to happen with antialiasing turned on than off.
> 
> 	Ingo

It always happened to me when I run "make menuconfig" under gnome-terminal on
redhat 9 with 2.5.73. Is it because of busy-waiting on a variable shared
amongst multiple processes/threads? If so, it smells of a bug in the application,
busy-waiting is _BAD_.

Greets, Antonio

-- 

In fact, this is all you need to know to be
a Caveman Database Programmer:

A relational database is a big spreadsheet
that several people can update simultaneously. 

