Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVCOV7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVCOV7C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVCOV7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:59:02 -0500
Received: from simmts6.bellnexxia.net ([206.47.199.164]:5832 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261903AbVCOV6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:58:54 -0500
Message-ID: <1027.10.10.10.24.1110923764.squirrel@linux1>
In-Reply-To: <20050315204413.GF20253@csail.mit.edu>
References: <20050315204413.GF20253@csail.mit.edu>
Date: Tue, 15 Mar 2005 16:56:04 -0500 (EST)
Subject: Re: OOM problems with 2.6.11-rc4
From: "Sean" <seanlkml@sympatico.ca>
To: "Noah Meyerhans" <noahm@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, March 15, 2005 3:44 pm, Noah Meyerhans said:
> Hello.  We have a server, currently running 2.6.11-rc4, that is
> experiencing similar OOM problems to those described at
> http://groups-beta.google.com/group/fa.linux.kernel/msg/9633559fea029f6e
> and discussed further by several developers here (the summary is at
> http://www.kerneltraffic.org/kernel-traffic/kt20050212_296.html#6)  We
> are running 2.6.11-rc4 because it contains the patches that Andrea
> mentioned in the kerneltraffic link.  The problem was present in 2.6.10
> as well.  We can try newer 2.6 kernels if it helps.
>
> The machine in question is a dual Xeon system with 2 GB of RAM, 3.5 GB
> of swap, and several TB of NFS exported filesystems.  One notable point
> is that this machine has been running in overcommit mode 2
> (/proc/sys/vm/overcommit_memory = 2) and the OOM killer is still being
> triggered, which is allegedly not supposed to be possible according to
> the kerneltraffic.org document above.  We had been running in overcommit
> mode 0 until about a month ago, and experienced similar OOM problems
> then as well.

We're seeing this on our dual Xeon box too, with 4 GB of RAM and 2GB of
swap (no NFS) using stock RHEL 4 kernel.   The only thing that seems to
keep it from happening is setting /proc/sys/vm/vfs_cache_pressure to
10000.

Sean


