Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbSLGGH1>; Sat, 7 Dec 2002 01:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbSLGGH1>; Sat, 7 Dec 2002 01:07:27 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:39297
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267731AbSLGGHZ>; Sat, 7 Dec 2002 01:07:25 -0500
Subject: Re: [BENCHMARK] max bomb segment tuning with read latency 2 patch
	in  contest
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF18D38.F493636C@digeo.com>
References: <200212071620.05503.conman@kolivas.net>
	 <3DF18D38.F493636C@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1039241701.2855.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 07 Dec 2002 00:15:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 23:55, Andrew Morton wrote:
[...]
> If the SMP machine is using scsi then that tends to make the elevator
> changes less effective.  Because the disk sort-of has its own internal
> elevator which in my testing on a Fujitsu disk has the same ill-advised
> design as the kernel's elevator: it treats reads and writes in a similar
> manner.
> 
> Setting the tag depth to zero helps heaps.

Command tag queue? As in the compile time option? Or do you mean queue
depth?(or are they the same)

> But as you're interested in `desktop responsiveness' you should be
> mostly testing against IDE disks.  Their behavour tends to be quite
> different.
> 
> If you can turn on write caching on the SCSI disks that would change
> the picture too.

Just for clarity, What about for something like FC attached storage
Where the controllers enforce cache policies on a "per volume" basis?
Would that == the same thing? 



--The GrandMaster
