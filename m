Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVKCI0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVKCI0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVKCI0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:26:23 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60342 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750953AbVKCI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:26:23 -0500
Date: Thu, 3 Nov 2005 09:26:05 +0100 (CET)
From: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
X-X-Sender: sylvain@localhost.localdomain
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, <Simon.Derr@bull.net>,
       <Sylvain.Jeaugey@bull.net>, Paul Jackson <pj@sgi.com>
Subject: Re: cpuset - question
In-Reply-To: <6278d2220511020935g6f88d15bp5f1e3bc692c55fe8@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0511030915290.30226-100000@localhost.localdomain>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/11/2005 09:40:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/11/2005 09:40:27,
	Serialize complete at 03/11/2005 09:40:27
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To come back to Randy's original question ...

Cpusets are not - in my view - designed to display the NUMA architecture.
/sys already does this very well (example of a 16 way machine) :
$ ls /sys/devices/system/node/node*
/sys/devices/system/node/node0:
cpu0  cpu1  cpu2  cpu3  cpumap  distance  meminfo  numastat
 
/sys/devices/system/node/node1:
cpu4  cpu5  cpu6  cpu7  cpumap  distance  meminfo  numastat
 
/sys/devices/system/node/node2:
cpu10  cpu11  cpu8  cpu9  cpumap  distance  meminfo  numastat
 
/sys/devices/system/node/node3:
cpu12  cpu13  cpu14  cpu15  cpumap  distance  meminfo  numastat

I think sysfs remains the best way to view your NUMA nodes.

Sylvain

On Wed, 2 Nov 2005, Daniel J Blueman wrote:

> I'm not sure of the true answer; it is likely that CPUSETS was
> designed in the 2.4 timeframe and compatibility was preferred over the
> clean sysfs interface.
> 
> I've CC'd the authors.
> 
> Dan
> 
> On 11/2/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Wed, 2 Nov 2005, Daniel J Blueman wrote:
> > >
> > > Janos,
> > >
> > > You can see what valid memory nodes are available from the top-level
> > > cpuset directory:
> > >
> > > # cat /dev/cpuset/mems
> > > 0 1 2 3
> > >
> > > If you were to be running on a NUMA-capable system, you'd also want to
> > > ensure page interleaving was disabled in the BIOS/pre-boot firmware
> > > too.
> >
> > Just for info, why is this in /dev at all, instead of, say,
> > /sys ??
> >
> > --
> > ~Randy
> ___
> Daniel J Blueman
> 




