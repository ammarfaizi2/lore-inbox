Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTH0Bw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbTH0Bw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:52:59 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:7331
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263063AbTH0Bw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:52:56 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.3828.755117.449165@wombat.chubb.wattle.id.au>
Date: Wed, 27 Aug 2003 11:52:52 +1000
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
In-Reply-To: <20030827012914.GB5280@matchmail.com>
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
	<20030826181807.1edb8c48.akpm@osdl.org>
	<20030827012914.GB5280@matchmail.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mike" == Mike Fedyk <mfedyk@matchmail.com> writes:

Mike> On Tue, Aug 26, 2003 at 06:18:07PM -0700, Andrew Morton wrote:
>> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>> >
>> > Currently, the context switch counters reported by getrusage()
>> are > always zero.  The appended patch adds fields to struct
>> task_struct to > count context switches, and adds code to do the
>> counting.
>> >
>> > The patch adds 4 longs to struct task struct, and a single
>> addition to > the fast path in schedule().
>> 
>> OK...  Why is this useful?  A bit of googling doesn't show much
>> interest in it.
>> 
>> What apps should be reporting this info?  /usr/bin/time?

Mike> Voluntary context switches: 0

Mike> How can you have voluntary context switches in a preemptive
Mike> environment?

A voluntary context switch is where a task gives up the processor
(e.g., by going to sleep, or by calling sched_yield()).

An involuntary context switch is where a task is preempted by some
other task.

(Another figure-of-merit might be how many times the process is
interrupted by a hardware interrupt)

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
