Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSIOFYy>; Sun, 15 Sep 2002 01:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSIOFYx>; Sun, 15 Sep 2002 01:24:53 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:26765 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317836AbSIOFYw>; Sun, 15 Sep 2002 01:24:52 -0400
Date: Sun, 15 Sep 2002 07:29:30 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug with MD multipath and raid1 on top
In-Reply-To: <20020914230753.GA3781@marowsky-bree.de>
Message-ID: <Pine.LNX.4.44.0209150721270.25780-100000@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.15.0.1; VDF: 6.15.0.7
	 at email has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Lars Marowsky-Bree wrote:

> On 2002-09-14T20:33:07,
>    Oktay Akbal <oktay.akbal@s-tec.de> said:
>
> > I found a very strange effect when using a raid1 on top of multipathing
> > with Kernel 2.4.18 (Suse-version of it) with a 2-Port qlogic HBA
> > connecting two arrays.
>
> Is this with or without the patch I recently posted to linux-kernel?


Since it is the latest official Suse-2.4.18 from SLES I assume this patch
is not included.

> > continues to work. After plugging out the second cable all drives
> > are marked as failed (mdstat), but the raid1 (md2) is still reported
> > as functional with one device (md0) missing.
>
> So far this sounds OK.

All disks are dead. The md0 device is missing. The same should be true for
md1, since there is no difference in setup. Why should the raid1 no report
both mirrors as dead ?

> (Even though the updated md-mp patch will _never_ fail
> the last path but instead return the error to the layer upwards; this protects
> against certain scenarios in 2.4 where a device error can't be distinguished
> from a failed path and we don't want that to lead to an inaccessible device)

How would the failing of all Pathes then be noticed ?

> I will try to reproduce this on Monday. As I don't have the hardware, but
> instead use a loop device (which I can make fail on demand), if I can't
> reproduce it, it might in fact be the FC driver which gets stuck somehow.

This might well be, since I don't found the qlogic-driver very impressing
so far. To use md-multipath the multipathing (failover) functionality from
the driver was disabled.

Oktay Akbal

