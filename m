Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVCOWPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVCOWPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVCOWPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:15:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45278 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261907AbVCOWMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:12:43 -0500
Subject: Re: OOM problems with 2.6.11-rc4
From: Lee Revell <rlrevell@joe-job.com>
To: Sean <seanlkml@sympatico.ca>
Cc: Noah Meyerhans <noahm@csail.mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1027.10.10.10.24.1110923764.squirrel@linux1>
References: <20050315204413.GF20253@csail.mit.edu>
	 <1027.10.10.10.24.1110923764.squirrel@linux1>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 17:12:41 -0500
Message-Id: <1110924762.17931.61.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 16:56 -0500, Sean wrote:
> On Tue, March 15, 2005 3:44 pm, Noah Meyerhans said:
> > The machine in question is a dual Xeon system with 2 GB of RAM, 3.5 GB
> > of swap, and several TB of NFS exported filesystems.  One notable point
> > is that this machine has been running in overcommit mode 2
> > (/proc/sys/vm/overcommit_memory = 2) and the OOM killer is still being
> > triggered, which is allegedly not supposed to be possible according to
> > the kerneltraffic.org document above.  We had been running in overcommit
> > mode 0 until about a month ago, and experienced similar OOM problems
> > then as well.
> 
> We're seeing this on our dual Xeon box too, with 4 GB of RAM and 2GB of
> swap (no NFS) using stock RHEL 4 kernel.   The only thing that seems to
> keep it from happening is setting /proc/sys/vm/vfs_cache_pressure to
> 10000.

I suspect I hit this too on a smaller (UP) machine with 512MB RAM/512MB
swap while stress testing RT stuff with dbench and massively parallel
makes.  The OOM seemed to trigger way before the machine filled up swap.
I dismissed it at the time, but maybe there's something there.

Lee

