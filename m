Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284854AbRLEXrI>; Wed, 5 Dec 2001 18:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284851AbRLEXqw>; Wed, 5 Dec 2001 18:46:52 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34474 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284854AbRLEXqa>;
	Wed, 5 Dec 2001 18:46:30 -0500
Date: Wed, 5 Dec 2001 15:46:18 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
Message-ID: <20011205154618.B24407@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011205135851.D1193@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0112051539130.1644-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112051539130.1644-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Wed, Dec 05, 2001 at 03:44:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 03:44:42PM -0800, Davide Libenzi wrote:
> Anyway me too have verified an increased latency with sched_yield() test
> and next days I'm going to try the real one with the cycle counter
> sampler.
> I've a suspect, but i've to see the disassembly of schedule() before
> talking :)

One thing to note is that possible acquisition of the runqueue
lock was reintroduced in sys_sched_yield().  From looking at
the code, it seems the purpose was to ?add fairness? in the case
of multiple yielders.  Is that correct Ingo?

-- 
Mike
