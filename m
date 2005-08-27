Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVH0MiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVH0MiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVH0MiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:38:09 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:7254 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030372AbVH0MiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:38:08 -0400
Subject: Re: Linux 2.6 context switching and posix threads performance
	question
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <aec8d6fc050827053047b1b667@mail.gmail.com>
References: <20050827121158.GA18406@oepkgtn.mshome.net>
	 <1125145582.20161.62.camel@twins>
	 <aec8d6fc050827053047b1b667@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 27 Aug 2005 14:38:02 +0200
Message-Id: <1125146282.20161.69.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Group replies work best with mailing lists.

On Sat, 2005-08-27 at 14:30 +0200, Mateusz Berezecki wrote:
> On 8/27/05, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Well the obvious question is: what kernel version and which thread
> > library?
> 
>   Ah, sorry I just forgot to put this info 
> 
> Linux blade1 2.6.12 #1 SMP Tue Jul 26 08:43:57 GMT 2005 i686 Intel(R)
> Xeon(TM) CPU 3.06GHz GenuineIntel GNU/Linux
> 
> the cpu is with HT so Linux thinks there are 4 cpus on board
>   
> > 
> > 2.4 with LinuxThreads might have severe problems. However 2.6 with NPTL
> > should be able to handle it, IIRC Igno once did a million threads with
_Ingo_ Molnar that is; I really should have gotten those 4 letters in
the right order by now, humble appologies.

> > that combination just to show that it worked ;-).
> 
>   Yes, but how about switching contexts and the performance impact?
> Will it slowdown the whole system or just result in low or medium
> overhead?.
> These threads are meant to be running an intensive network connection
> and possibly analysing the dataflow and maybe filtering some stuff.
> Each thread doing the same task.

I think it should work; however I'm not the most qualified to answer
this.



-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

