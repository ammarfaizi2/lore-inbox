Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSGOSjF>; Mon, 15 Jul 2002 14:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSGOSjE>; Mon, 15 Jul 2002 14:39:04 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:38148 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317587AbSGOSjB>; Mon, 15 Jul 2002 14:39:01 -0400
Date: Mon, 15 Jul 2002 20:41:49 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [sparc32] reserve nocache based on RAM size
Message-ID: <20020715184149.GA18980@louise.pinerecords.com>
References: <200207151333.g6FDXF001511@devserv.devel.redhat.com> <20020715143525.B27814@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020715143525.B27814@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 41 days, 7:22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Tomas Szepe <szepe@pinerecords.com>
> > Newsgroups: rhat.general.linux-kernel
> > Date: Sun, 14 Jul 2002 17:38:05 +0200
> 
> > Since there's no official sparc32 maintainer, I'm sending this patch
> > directly to you. It has now been tested in various configurations
> > (released in the default Aurora 0.3 kernel) and appears to be causing
> > no undesired side effects.
> 
> Would you mind to send me 3-4 /proc/meminfos and /proc/cpuinfos
> from your Aurora boxes with this patch, preferably after some uptime?

At the moment, I've only got one box up:

$ uname -r
2.4.19-pre10
$ uptime
  8:39pm  up 41 days, 10:33,  5 users,  load average: 0.00, 0.00, 0.00
$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  157298688 145948672 11350016        0 41795584 48705536
Swap: 234864640 24662016 210202624
MemTotal:       153612 kB
MemFree:         11084 kB
MemShared:           0 kB
Buffers:         40816 kB
Cached:          42640 kB
SwapCached:       4924 kB
Active:          40752 kB
Inactive:        67556 kB
HighTotal:       64828 kB
HighFree:         4472 kB
LowTotal:        88784 kB
LowFree:          6612 kB
SwapTotal:      229360 kB
SwapFree:       205276 kB
$ cat /proc/cpuinfo 
cpu             : Texas Instruments, Inc. - SuperSparc-(II)
fpu             : SuperSparc on-chip FPU
promlib         : Version 3 Revision 2
prom            : 2.22
type            : sun4m
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 74.75
Cpu1Bogo        : 59.80
MMU type        : TI Viking/MXCC
contexts        : 65536
nocache total   : 3145728
nocache used    : 998656
CPU0            : online
CPU1            : online

> Also, did you think about a deadlock-free runtime resizing of the
> nocache memory? I did not even bother with boot-time resizing,
> because run-time resizing sounds doable and certainly nobler.

Not yet, sounds like a good idea, though. I'll certainly have
a look at it later on.

T.
