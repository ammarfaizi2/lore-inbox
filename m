Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbSJ0MoO>; Sun, 27 Oct 2002 07:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbSJ0MoO>; Sun, 27 Oct 2002 07:44:14 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:34007 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S262374AbSJ0MoN>; Sun, 27 Oct 2002 07:44:13 -0500
Date: Sun, 27 Oct 2002 13:50:21 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Vladim?r T?ebick? <guru@cimice.yo.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Swap doesn't work
Message-ID: <20021027125021.GA1578@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Vladim?r T?ebick? <guru@cimice.yo.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <002501c27da9$2524d0f0$4500a8c0@cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501c27da9$2524d0f0$4500a8c0@cybernet.cz>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 12:07:44PM +0100, Vladim?r T?ebick? wrote:
> > Wow. Any of the errors above prevents swap partition from being used.
> > How did you manage to see anything in /proc/swaps?
> > I suggest you do:
> >  swapoff /dev/hda6
> >  badblocks /dev/hda6
> Badblocks finds each time ONE bad block at the end of the partition no
> matter where I create it or how large the partition is. Syslog shows this
> message:
> Oct 27 10:57:45 shunka kernel: attempt to access beyond end of device
> Oct 27 10:57:45 shunka kernel: 03:06: rw=0, want=594376, limit=594373

That's not a badblock. That's an kernel IDE bug. Andre Hedrick and Alan
Cox will love to see this.

> > Look for "SWAP-SPACE" (old swap) or "SWAPSPACE2" (the new one).
> > Just to make sure you've initialized the partition properly.
> > Than turn it on: swapon /dev/hda6; tail /var/log/syslog
> where should I try to find it? ("SWAP-SPACE" | "SWAPSPACE2")

At the beginning. The searching for it doesn't make sense now.

> What mean the problems I (only) once noticed about the signature?

Nothing special. You just have something broken in a particularly
unpredictable way.

