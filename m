Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbTA3Qwc>; Thu, 30 Jan 2003 11:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbTA3Qwc>; Thu, 30 Jan 2003 11:52:32 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:25304 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S267562AbTA3Qwb>; Thu, 30 Jan 2003 11:52:31 -0500
Date: Thu, 30 Jan 2003 09:01:50 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: Praveen Ray <praveen.ray@crcnet1.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timer interrupts on HP machines
In-Reply-To: <200301300934.54201.praveen.ray@crcnet1.com>
Message-ID: <Pine.LNX.4.44.0301300859340.22492-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Praveen-

We have a few LT6000r servers as well, and have the same problem on all 
2.4 kernels -- this happens when your MP spec is set to 1.1 in the BIOS. 
Change it to 1.4 and you should be okay.

The other common problem on these guys is the CPU speed misdetect, which 
causes the kernel to think your CPU is roughly 2x as fast as it really is. 
The solution to that one is to unplug and replug the power cords (even a 
power-off doesn't fix it, go figure).

Hope that helps.

-Matt

On Thu, 30 Jan 2003, Praveen Ray wrote:

> We have few HP (LPR NetServers and LT6000) which run 2.4.18  (from RedHat 8.0) 
> . The problem is that sometimes the time interrupts stop coming - i.e. the 
> (time) counts in /proc/interrupts stop getting incremented! When this 
> happens, the date on the system falls behind, 'sleep' calls stop working and 
> basically machine becomes unusable.Has anyone else encountered this problem? 
> Is it an HP issue?
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

