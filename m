Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWAXRFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWAXRFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWAXRFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:05:30 -0500
Received: from xenotime.net ([66.160.160.81]:11485 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030321AbWAXRF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:05:29 -0500
Date: Tue, 24 Jan 2006 09:05:27 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
In-Reply-To: <1138116579.14675.22.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0601240904110.26036@shark.he.net>
References: <43D5CC88.9080207@comcast.net> <1138116579.14675.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006, Alan Cox wrote:

> On Maw, 2006-01-24 at 01:43 -0500, Ed Sweetman wrote:
> > problem.  The problem is that there appears to be two nvidia/amd ata
> > drivers and I'm unsure which I should try using, if i compile both in,
> > which get loaded first (i assume scsi is second to ide) and if i want my
> > pata disks loaded under the new libata drivers, will my cdrom work under
> > them too, or do i still need some sort of regular ide drivers loaded
> > just for cdrom (to use native ata mode for recording access).
>
> The goal of the drivers/scsi/pata_* drivers is to replace drivers/ide in
> its entirity with code using the newer and cleaner libata logic. There
> is still much to do but my SIL680, SiS, Intel MPIIX, AMD and VIA boxes
> are using libata and the additional patch patches still queued.

What is "MPIIX" anyway?

and while I'm looking at the config menu, why do both
Compaq Triflex and Intel PATA MPIIX say (Raving Lunatic)?

> > 1.  Atapi is most definitely not supported by libata, right now.
>
> It works in the -mm tree.
>
> > 4.  moving to pata libata drivers _will_ change the enumeration of your
> > sata devices, it seems that pata is initialized first, so when setting
> > up your fstab entries and grub, you'll have to take into account how
> > many pata devices you have and offset your current sata device names by
> > that amount.
>
> Or use labels. As you move into the world of hot pluggable hardware it
> becomes more and more impractical to guarantee drive ordering by name.
>
> You can mix and match the drivers providing you don't try and load both
> libata and old ide drives for the same chip. Even then it should fail
> correctly with one of them reporting resources unavailable.
>
> In fact I do this all the time when debugging so I've got a stable disk
> for debug work and a devel disk.

-- 
~Randy
