Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLLEeb>; Mon, 11 Dec 2000 23:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQLLEeV>; Mon, 11 Dec 2000 23:34:21 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:27659 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129228AbQLLEeQ>; Mon, 11 Dec 2000 23:34:16 -0500
Date: Mon, 11 Dec 2000 22:03:43 -0600
To: Al Peat <al_kernel@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2fs block to physical block translation
Message-ID: <20001211220343.E3199@cadcamlab.org>
In-Reply-To: <20001212012148.60376.qmail@web10105.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001212012148.60376.qmail@web10105.mail.yahoo.com>; from al_kernel@yahoo.com on Mon, Dec 11, 2000 at 05:21:48PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Al Peat]
> Quick question about blocks:
> 
>   If I assume my hard drive uses 512 blocks, and my
> ext2 filesystem uses 4k blocks, can I assume the
> following formula for translation?
> 
>   physical block # / 8  =  e2fs block #

Not if you have a partition table.  If you take into account the
individual partition offset, I think your formula is ok.

On a floppy (no partition table) you'd be fine.

It's not always that easy, of course.  Think of RAID (logical block
mapping can be a complex formula), LVM (the mapping is stored in a
table in the volume group metadata), CD-ROMs (what exactly do you mean
by "block"...?) and other such.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
