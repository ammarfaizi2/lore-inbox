Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263093AbRFLTIG>; Tue, 12 Jun 2001 15:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFLTH4>; Tue, 12 Jun 2001 15:07:56 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:5004 "EHLO mx01-a.netapp.com")
	by vger.kernel.org with ESMTP id <S263093AbRFLTHp>;
	Tue, 12 Jun 2001 15:07:45 -0400
Date: Tue, 12 Jun 2001 12:06:40 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: ognen@gene.pbi.nrc.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: threading question
In-Reply-To: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>
Message-ID: <Pine.GSO.4.10.10106121200330.20809-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may sound like flamebait, but its not. Linux threads are basically
just processes that share the same address space. Their performance is
measurably worse than it is on most commercial Unixes and FreeBSD.
They are not, or at least two years ago, were not POSIX compliant
(they behaved badly with respect to signals). The impoverished
implementation of threads is not an accidental oversight, threads are not
looked upon favorably by most of the core linux kernel hackers. A quote
from Larry McVoy's home page attributed to Alan Cox illustrates this
reasonably well: "A computer is a state machine. Threads are for people
who can't program state machines." Sorry for not being more helpful.

		-Kip


On Tue, 12 Jun 2001 ognen@gene.pbi.nrc.ca wrote:

> Hello,
> 
> I am a summer student implementing a multi-threaded version of a very
> popular bioinformatics tool. So far it compiles and runs without problems
> (as far as I can tell ;) on Linux 2.2.x, Sun Solaris, SGI IRIX and Compaq
> OSF/1 running on Alpha. I have ran a lot of timing tests compared to the
> sequential version of the tool on all of these machines (most of them are
> dual-CPU, although I am also running tests on 12-CPU Solaris and 108 CPU
> SGI IRIX). On dual-CPU machines the speedups are as follows: my version
> is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
> 1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
> kernel. Why are the numbers on Linux machines so much lower? It is the
> same multi-threaded code, I am not using any tricks, the code basically
> uses PTHREAD_CREATE_DETACHED and PTHREAD_SCOPE_SYSTEM and the thread stack
> size is set to 8K (but the numbers are the same with larger/smaller stack
> sizes).
> 
> Is there anything I am missing? Is this to be expected due to Linux way of
> handling threads (clone call)? I am just trying to explain the numbers and
> nothing else comes to mind....
> 
> Best regards,
> Ognen Duzlevski
> -- 
> ognen@gene.pbi.nrc.ca
> Plant Biotechnology Institute
> National Research Council of Canada
> Bioinformatics team
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

