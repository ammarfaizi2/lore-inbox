Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287539AbSABNUe>; Wed, 2 Jan 2002 08:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287462AbSABNU0>; Wed, 2 Jan 2002 08:20:26 -0500
Received: from web1.oops-gmbh.de ([212.36.232.3]:57610 "EHLO
	sabine.freising-pop.de") by vger.kernel.org with ESMTP
	id <S287454AbSABNUM>; Wed, 2 Jan 2002 08:20:12 -0500
Message-ID: <3C33071A.EB4943E8@sirius-cafe.de>
Date: Wed, 02 Jan 2002 14:11:55 +0100
From: Martin Knoblauch <knobi@sirius-cafe.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-), Freising
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: hauan@cmu.edu
Subject: Re: smp cputime issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> smp cputime issues
> 
> 
> hello,
> 
>   we are encountering some weird timing behaviour on our linux cluster.
> 
>   specifically: when running 2 copies of selected programs on a
>   dual-cpu system, the cputime reported for each process is up to 25%
>   higher than when the processes are run on their own. however, if running
>   two different jobs on the same machine, both complete with a cputime
>   equal to when run individually. sample timing output attached.
> 
>   profiling confirms that everything slows down approximately to scale.
>   the results reproduce on a range of different machines (see below).
> 
> additional specifications:
>   - kernel version 2.4.16 (with apic enabled)
>   - chipsets: apollo pro 133, apollo pro 266,
>               intel i860, serverworks LE
>   - all jobs requires less than 1/10 of physical memory
>   - no significant disk i/o takes place
>   - timing with dtime(), /usr/bin/time and shell built-in time
>   - this behavior is NOT seen for all applications. the worst
>     "offender" spends most of its time doing linear algebra.
> 
>   ideas or info-pointers appreciated. more specs available on request.
> 

 two points. First for clarification - do you see the effects also on
elapsed time? Or do you say that the CPU time reporting is screwed?

 Second - you mention that you see the effect mainly on linear algebra
stuff. Could it be that you are memory bandwidth limited if you run two
of them together? Are you using Intel CPUs (my guess) which have the FSB
concept that may make memory bandwidth scaling a problem, or AMD Athlons
which use the Alpha/EV6 bus and should be a bit more friendly.

 Finally, how big is "1/10th of physical" memory? What kind of memory.

Martin
-- 
+-----------------------------------------------------+
|Martin Knoblauch                                     |
|-----------------------------------------------------|
|http://www.knobisoft.de/cats                         |
|-----------------------------------------------------|
|e-mail: knobi@knobisoft.de                           |
+-----------------------------------------------------+
