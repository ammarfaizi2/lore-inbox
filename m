Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSIZWuS>; Thu, 26 Sep 2002 18:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSIZWuS>; Thu, 26 Sep 2002 18:50:18 -0400
Received: from packet.digeo.com ([12.110.80.53]:56303 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261549AbSIZWuP>;
	Thu, 26 Sep 2002 18:50:15 -0400
Message-ID: <3D939062.9C44B2B8@digeo.com>
Date: Thu, 26 Sep 2002 15:55:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hard lockups running X with 2.5.38-bk4, -bk5 and -mm3
References: <1033078474.1306.43.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 22:55:26.0553 (UTC) FILETIME=[CDC22490:01C265AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> I only recently started testing 2.5.x kernels with X, and have
> immediately run into problems.
> 
> My new test system is a Dell GX110 single PIII, IDE (Intel 82801AA IDE),
> 256MB memory.  The 2.5.38-bk4,5 and -mm3 kernels were SMP (due to
> not having Rusty's cpu_possible fix), non-PREEMPT.
> 
> Running XFree86 4.2.1, I get a hard lockup with the box not responsive
> to pings.  Ssh sessions don't respond and the pointer does not respond
> to mouse movements.  This occurs very soon (2-3 minutes) after starting
> X with 2.5.38-bk4 and -bk5.  I was able to run 2.5.38-mm3 for about 30
> minutes under load (kernel compiles) before a freeze occurred.  I ran
> 2.5.38-mm3 again for about 20 minutes with X and under load before a
> second lockup occurred.  Sorry, nothing logged, and when the freezes
> occur, there is no response to SYSRQ-H,S or B.  SYSRQ-H works as
> expected before the freeze.
> 
> Without running X on this system, no freezes have been observed with any
> of these kernels with the system loaded by running kernel compiles and
> dbench with up to 40 clients.
> 

Me too.  deadlocks on tasklist_lock.  Some fixes went into Linus's
tree a few hours ago, so please retest.
