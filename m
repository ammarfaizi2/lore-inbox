Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTHYIGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTHYIGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:06:43 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:4881 "EHLO smtp.uc3m.es")
	by vger.kernel.org with ESMTP id S261496AbTHYIGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:06:39 -0400
Date: Mon, 25 Aug 2003 10:06:33 +0200
Message-Id: <200308250806.h7P86X413480@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Cc: Stephan von Krawczynski <skraw@ithnet.com>
X-Newsgroups: linux.kernel
In-Reply-To: <nKwX.1yy.17@gated-at.bofh.it>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <nKwX.1yy.17@gated-at.bofh.it> you wrote:
> On Sun, 24 Aug 2003 00:13:15 +0900
> TeJun Huh <tejun@aratech.co.kr> wrote:
>>  The race conditions I'm mentioning in this thread are not likely to
>> cause real troubles.  The first one does not make any difference on
>> x86, and AFAIK bh isn't used extensively anymore so the second one
>> isn't very relevant either.  Only the race condition mentioned in the
>> other thread is of relvance if there is any :-(.

> Are you sure? bh is used in fs subtree to my knowledge ...

Would someone care to spemd a moment to tell me what the spin_lock_bh
does that spin_lock alone does not do?  (not just "local_bh_disable",
pleasse :-).  I am chasing SMP oopses for filesystems mounted on nbd
which only seem to happen in association with high memory stress (and
possibly "high memory"), and I suspect I am going to be interested by
the answer.

There is no commentary that I can find in the source, beyond the
assembler code in local_bh_enable().

Peter
