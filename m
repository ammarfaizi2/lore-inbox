Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSGZSEO>; Fri, 26 Jul 2002 14:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317949AbSGZSEO>; Fri, 26 Jul 2002 14:04:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:12928 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S317944AbSGZSEN>; Fri, 26 Jul 2002 14:04:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 26 Jul 2002 11:09:31 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: davidm@hpl.hp.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: performance experiment
In-Reply-To: <200207261746.g6QHkjUp005023@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0207261107140.1561-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, David Mosberger wrote:

> Below is a patch that implements an alternate version of the core-loop
> of do_select().  I'm interested in hearing how the two versions
> (original and new) compare on various architectures.  The new loop
> happens to perform better on ia64 and I suspect the same will be true
> for most RISC platforms.  It wouldn't surprise me if the new loop
> performed better even on some instances of x86.  I suspect on older
> x86s (e.g., 80486), the old loop does better.  If someone is running
> Linux on a Transmeta Crusoe chip, I'd be *very* interested in hearing
> how the two loops perform there.
>
> Here is what I'm proposing to do: if a couple of people are willing to
> try out the patch below, I'll collect the results and post a summary.
> To make sure we're comparing apples to apples, I'd like to suggest to
> run LMbench 2 with and without the patch below.  Then send me the
> select results from the raw results file.  For example, you would run
> lmbench like so:
>
> 	$ make rerun
>
> Then look at the results file, which is stored in
> results/CONFIG/HOSTNAME.N.  For example, on a Pentium III machine
> called "adler", the results of the first run would be stored in
>
> 	results/i686-pc-linux-gnu/adler.0
>
> I'd prefer if you sent me the complete result files, but if you don't
> want to do that, it should be good enough to mail me the first and
> second line of the file, all the lines starting with "Select", and a
> description of the machine you were testing (CPU type, clock speed,
> chipset, memory size, and compiler version would be ideal).  For the
> above example, the lines of interest would be:

i posted a 95% matching patch about one year ago but it fell inside the
Alan drop basket :-) basically Alan requested perf numbers that i did not
have time to supply. glad you did them ...



- Davide


