Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUHMRCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUHMRCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUHMRCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:02:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11668 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266214AbUHMRCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:02:36 -0400
Date: Fri, 13 Aug 2004 13:02:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: James Courtier-Dutton <James@superbug.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Latency profiling.
In-Reply-To: <411CE8DC.9010609@superbug.demon.co.uk>
Message-ID: <Pine.LNX.4.53.0408131254560.25667@chaos>
References: <411CE8DC.9010609@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, James Courtier-Dutton wrote:

> I have been looking, but I cannot find out if anyone has already done
> what I want.
>
> I have a problem that my desktop linux system becomes un-responsive when
> there is a lot of Hard Disc access. I.E. During HD access, the mouse
> fails to move.
>

	Yes.

> I suspect that this is due to a certain kernel process holding onto the
> CPU resources too long without letting the kernel schedule a different
> process.
>

There are no such kernel processes. Linux and other Unixes perform
functions on behalf of the caller. If there is some task hogging
the CPU then `top` will show it.

> I therefore need a kernel profiler that will log every kernel
> schedule/context switch, and if the interval between any switch is
> greater than X, it will write a log entry, telling me which
> process/function/module was holding onto the CPU for too long.
>

Some task, waiting for I/O to complete, will automatically
get the CPU taken away and given to some other task that
is not waiting for I/O to complete.

> I could then use this tool to help me track down exactly where the
> problem is, and therefore hopefully find a fix for it.
>
> Does a tool like this already exist?
>
> James

The problems you describe are most likely caused by your hard-disk
and/or driver. If you have an IDE drive with no DMA capability, you
are stuck. If you have ATA, Fiberchannel, SCSI or something professional
your processes will get CPU time while I/O is occurring.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


