Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTBOV5L>; Sat, 15 Feb 2003 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTBOV5L>; Sat, 15 Feb 2003 16:57:11 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:41664 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S265201AbTBOV5K>; Sat, 15 Feb 2003 16:57:10 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200302152207.XAA09202@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
To: zwane@holomorphy.com (Zwane Mwaikambo)
Date: Sat, 15 Feb 2003 23:07:01 +0100 (MET)
Cc: weigand@immd1.informatik.uni-erlangen.de (Ulrich Weigand),
       linux-kernel@vger.kernel.org (Linux Kernel),
       schwidefsky@de.ibm.com (Martin Schwidefsky)
In-Reply-To: <Pine.LNX.4.50.0302151351580.16012-100000@montezuma.mastecende.com> from "Zwane Mwaikambo" at Feb 15, 2003 02:01:06 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> This could be achieved if s390 (or if we had a generic one, this is 
> another story...) had a for_each_cpu type iterator, which would also 
> cover aforementioned mask &= cpu_online_map issue, but as an aside, it is 
> harder to track down lockups from things like IPIs to invalid cpus than a busy loop 
> waiting for num_cpus.

I'm not sure I understand what you mean here.  In any case, at least
on S/390, doing a SIGP to an invalid CPU will simply get you an
'not operational' indication (condition code 3), so in fact the
only problem *is* the busy loop on num_cpus ...

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
