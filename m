Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWBNN3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWBNN3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWBNN3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:29:12 -0500
Received: from solarneutrino.net ([66.199.224.43]:63752 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1161050AbWBNN3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:29:12 -0500
Date: Tue, 14 Feb 2006 08:29:04 -0500
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-ID: <20060214132904.GI16566@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com> <20060213213929.GG16566@tau.solarneutrino.net> <20060213214956.GH16566@tau.solarneutrino.net> <20060214085446.GH3209@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060214085446.GH3209@harddisk-recovery.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:54:47AM +0100, Erik Mouw wrote:
> On Mon, Feb 13, 2006 at 04:49:57PM -0500, Ryan Richter wrote:
> > On Mon, Feb 13, 2006 at 04:39:29PM -0500, ryan wrote:
> > > It runs Debian Sarge for AMD64.  I have lots of other machines, but only
> > > this one gets the reboots.  None of the others have SCSI, and none are
> > > dual-CPU with memory on both nodes, just to name two obvious things
> > > different on this machine.
> > 
> > Thinking about this some more...  My home desktop also is a dual opteron
> > with memory on both nodes and SCSI, but it hasn't had any reboots.  The
> > machine with the reboot trouble uses RAID5+LVM, unlike my desktop.  Also
> > it's an NFS server, but I have another machine (single-cpu pentium 4, no
> > SCSI etc.) that's an NFS server without reboots.  But none of the other
> > machines have RAID or LVM.
> 
> We recently had such an issue with a dual AMD64 machine rebooting at
> mke2fs. It turned out it was a faulty power supply. After we changed
> the power supply, everything ran smooth again.
> 
> You could start to test by powering your drives from an old AT-style
> power supply leaving more "juice" for the main board and CPUs.

It's possible, but I doubt it.  More often than not, the reboot happens
when the machine is completely idle - in fact I can't remember a single
time when it wasn't idle.  I just spent a couple months debugging a
SCSI-tape crash, and I ran the backups a lot and had lots of RAID
resyncs and it *never* rebooted during either of these events.  Anyway
it has quite a large 2+1 redundant power supply, and, like I said, we
routinely had 3+ months of uptime with older kernels.

During the years I've had this machine, I've experienced at least 10-15
strange kernel bugs that only happened on this machine.  Each and every
time I was *convinced* that the hardware was at fault (and people on the
mailing list suggested it) until either a kernel came out that fixed the
problem or a kernel developer positively identified it as a kernel
problem and eventually fixed it.  This machine just seems to be a magnet
for kernel bugs.

Thanks,
-ryan
