Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbSIXLmd>; Tue, 24 Sep 2002 07:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbSIXLmc>; Tue, 24 Sep 2002 07:42:32 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:40102 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261654AbSIXLmc>; Tue, 24 Sep 2002 07:42:32 -0400
Date: Tue, 24 Sep 2002 13:47:38 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 32bit wraps and USER_HZ [64 bit counters], kernel 2.5.37
In-Reply-To: <200209232208.g8NM8bN05831@fokkensr.vertis.nl>
Message-ID: <Pine.LNX.4.33.0209241342470.4261-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Rolf Fokkens wrote:
> On Monday 23 September 2002 04:36, William Lee Irwin III wrote:
> > -	unsigned long utime, stime, cutime, cstime;
> > -	unsigned long start_time;
> > -	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
> >
> > Hmm. Isn't task_t bloated enough already? I'd rather remove them than
> > make them 64-bit.
> 
> Since nobody else asks this question:
> 
> Do you mean to leave out process statistics?

We don't need to leave out process statistics completely, but per-CPU 
per-process statistics indeed looks like overkill.

Tim

P.S.: Some work with respect to cleaning up interfaces of 32 bit jiffies 
has gone into -dj already, but I'm still waiting for the next -dj release 
to sync up.

