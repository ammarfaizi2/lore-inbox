Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEYGFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 02:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTEYGFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 02:05:10 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:61926 "EHLO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261352AbTEYGFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 02:05:09 -0400
Date: Sun, 25 May 2003 15:18:16 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Robert Creager <Robert_Creager@LogicalChaos.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with virtually no buffer usage in 2.4.21mdk kernel
Message-Id: <20030525151816.4a433953.bharada@coral.ocn.ne.jp>
In-Reply-To: <20030524223320.7c1ac413.Robert_Creager@LogicalChaos.org>
References: <20030524223320.7c1ac413.Robert_Creager@LogicalChaos.org>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003 22:33:20 -0600
Robert Creager <Robert_Creager@LogicalChaos.org> wrote:

> My apparent problem is I'm seeing virtually no buffer usage, as checked from
> /proc/meminfo.  The system has been up for 11 days, with heavy dB and file
> access activity (Gb's worth per day), yet the buffer usage never budges.  Am
> I missing something fundamental, have I boffed the kernel build, or is there
> a problem?  I would appreciate any pointers.
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  2119151616 2068426752 50724864        0    90112 1888358400
> Swap: 2089177088 70832128 2018344960
> MemTotal:      2069484 kB
> MemFree:         49536 kB
> MemShared:           0 kB
> Buffers:            88 kB
> Cached:        1823808 kB
> SwapCached:      20292 kB
> Active:        1209640 kB
> Inactive:       712324 kB
> HighTotal:     1179136 kB
> HighFree:         2044 kB
> LowTotal:       890348 kB
> LowFree:         47492 kB
> SwapTotal:     2040212 kB
> SwapFree:      1971040 kB

Count the columns - the '0' is for shared memory, not buffers.
As for why shared memory shows as zero, that's in the FAQ:

 http://www.tux.org/lkml/#s14-3

