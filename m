Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSAVEqF>; Mon, 21 Jan 2002 23:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289149AbSAVEpz>; Mon, 21 Jan 2002 23:45:55 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:4880 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287565AbSAVEpn>; Mon, 21 Jan 2002 23:45:43 -0500
Date: Tue, 22 Jan 2002 15:45:49 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: akeys@post.cis.smu.edu, partha@us.ibm.com, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Subject: Re: Performance Results for Ingo's O(1)-scheduler
Message-Id: <20020122154549.7decbeb9.rusty@rustcorp.com.au>
In-Reply-To: <200201212016.29055.bodnar42@phalynx.dhs.org>
In-Reply-To: <OF4544D2BC.16B7A12D-ON85256B48.00817250@raleigh.ibm.com>
	<20020122035540.ZUVU10199.rwcrmhc53.attbi.com@there>
	<200201212016.29055.bodnar42@phalynx.dhs.org>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002 20:16:28 -0800
Ryan Cumming <bodnar42@phalynx.dhs.org> wrote:

> On January 21, 2002 19:55, Adam Keys wrote:
> > I'm curious about the performance of the 4-way and 8-way systems.  I know
> > nothing about this benchmark.  IIRC correctly it simulates chat clients
> > connecting to a server and talking to each other.  Is it a CPU, memory, or
> > disk bound benchmark?  What is causing the 4-way machines to be only 2x the
> > performance of the 1-way machine and the 8-way machines to be < 3x the
> > performance?  Is the system bus the limiting factor on those machines?
> 
> Memory bus, lock contention, syncronization issues. SMP really isn't as 
> magical as people think after the overhead is taken in to account.

Volcanomark is a Java(TM) chatroom benchmark: multiple rooms, where for each
room, every input from a client generates a write to every other client
(think broadcast storm).

chat (which is a C version of Volcanomark) is useful for testing, as is
hackbench2 (which is cut down to just exhibit the runqueue problem, and
doesn't even use threads).

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
