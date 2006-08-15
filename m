Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWHOT0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWHOT0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWHOT0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:26:07 -0400
Received: from dsl3-63-249-91-188.cruzio.com ([63.249.91.188]:61128 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S965227AbWHOT0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:26:06 -0400
Date: Tue, 15 Aug 2006 12:24:27 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200608151924.k7FJORMQ014228@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Daily crashes, incorrect RAID behaviour, but only with 2.6.14 and later
Cc: alan@lxorguk.ukuu.org.uk, carsten.otto@gmail.com, mjt@tls.msk.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otto said:

>My problems continue, even with a new and good power supply.
>1) The system loses a disk about every week, only a hard reboot solves that
...
>Regarding 1)
>The system works normally and suddenly one disk does not respond.
...

I have seen something similar for a few months now (it 
seems). I use 3ware SATA and PATA cards and have 21 total 
drives including two 8 disk RAID6 arrays.

I have noticed that everything works with kernel 2.6.13.4 but
any kernel 2.6.14 or later shows the problem. So you might
experiment and backrev the kernel. For me the problem
happens within a few minutes of bootup.

My theory was that the power supplies (I use 3, 8 disks per
supply) are bad and somehow later kernels get more disks
seeking at the same time and the power dips and the disk
goes offline.

Just another data point and weird guess...

Alan Cox said:

> Rule of thumb (and a good one). If the soft reboot and
> BIOS cannot recover the disk then the disk is the problem. 
> There isn't really anything we can tell the drive to do 
> which should make it take a hike and ignore a reset sequence.

Do you think a bad power supply could lock it up to where 
only a power cycle fixes it?

PS Regarding a possible firmware bug, some of my disks are 
300G Maxtors (though not the model number posted) but I
don't recall if it was only those that went offline...
