Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130986AbQKJM6K>; Fri, 10 Nov 2000 07:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130890AbQKJM5v>; Fri, 10 Nov 2000 07:57:51 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:24227 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130986AbQKJM5K>; Fri, 10 Nov 2000 07:57:10 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: Paul Jakma <paulj@itg.ie>, Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Message-ID: <80256993.0047077C.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 10 Nov 2000 11:41:09 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> That being said, the real problem with the GKHI is that as Al said, it
> does expose internal kernel interfaces --- and the Linux kernel
> development community as a whole refuses to be bound by such interfaces,
> sometimes even during a stable kernel series.

I'm not sure that GKHI exposes any more interfaces than embedding a patch
directly into the kernel would.

It has the potential to to make patches easier to re-work for different
kernel versions, and to enable development maintence and fixing of the
patch to be done independently of a kernel build. And it also has the
potential of helping with co-existence. If for example the RAS community
could agree on a number of hooks (I'm thinking here of crash dump, trace,
dprobes and maybe KDB as well) then you'd probably find a good may on them
using then same hooks. The modifications to the kernel would be minimal and
the user would be left an easy means of installing a co-existing subset of
the offerings supported by hooks.

An example: DProbes is down to three hooks - that's three lines of code in
the kernel + three lines in ksyms.c

Patching DProbes onto any custom kernel is a doddle.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
