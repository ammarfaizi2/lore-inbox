Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTADVKc>; Sat, 4 Jan 2003 16:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTADVKc>; Sat, 4 Jan 2003 16:10:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:12997 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261689AbTADVKa>;
	Sat, 4 Jan 2003 16:10:30 -0500
Message-ID: <3E174FBB.9065575A@digeo.com>
Date: Sat, 04 Jan 2003 13:18:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Barnhart <sbarn03@softhome.net>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.54-mm3
References: <3E16A2B6.A741AE17@digeo.com> <pan.2003.01.04.15.47.43.915841@softhome.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2003 21:18:57.0196 (UTC) FILETIME=[E4575EC0:01C2B436]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Barnhart wrote:
> 
> On Sat, 04 Jan 2003 01:00:38 +0000, Andrew Morton wrote:
> 
> > Filesystem mount and unmount is a problem.  Probably, this will not be
> > addressed.  People who have specialised latency requirements should avoid
> > using automounters and those gadgets which poll CDROMs for insertion events.
> 
> That stinks...it don't work in .54 and I'd likem to have my automounter
> functioning again. Oh well it *is* 2.5.

autofsv4 has been working fine across the 2.5 series.  You'll need to
send a (much) better report.

> > This work has broken the shared pagetable patch - it touches the same code
> > in many places.   I shall put Humpty together again, but will not be
> > including it for some time.  This is because there may be bugs in this
> > patch series which are accidentally fixed in the shared pagetable patch. So
> > shared pagetables will be reintegrated when these changes have had sufficient
> > testing.
> 
> Also for some reason I always have to do a "touch /fastboot" and boot in
> rw mode to boot the kernel. The kernel fails on remouting fs in r-w mode.

Many more details are needed.  Sufficient for a developer to be able to
reproduce the problem.

> X also don't work saying /dev/agpgart don't exist even though it does and
> I saw it. agpgart module is loaded..maybe it would work as built into the
> kernel? .config attached.

You could try statically linking it, yes.  More details are needed,
such as a description of what hardware you have and what driver you're
using.
