Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267082AbUFZKpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267082AbUFZKpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 06:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267084AbUFZKpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 06:45:00 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:5127 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S267082AbUFZKo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 06:44:58 -0400
Date: Sat, 26 Jun 2004 12:44:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: andyb@island.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
Message-ID: <20040626104455.GC5526@pclin040.win.tue.nl>
References: <1088216934.40dcdf66edd1d@webmail.island.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088216934.40dcdf66edd1d@webmail.island.net>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 07:28:54PM -0700, andyb@island.net wrote:

> Having partition table troubles here with 2.6.7 on hdc:  unknown partition table.
> 
> Using 2.6.6 kernel, hdc is handled just fine, partitions are visible.
> The boot drive is hda,  drive hdc is for other optional mount points.
> 
> hdc: QUANTUM FIREBALL CR8.4A, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: max request size: 128KiB
> hdc: 16514064 sectors (8455 MB) w/418KiB Cache, CHS=16383/16/63
>  hdc: unknown partition table
> 
> It's been said in this thread that the kernel no longer guesses a geometry;
> it's also been said elsewhere that the kernel doesn't use CHS at all.
> What do I put on the kernel parameter line to give a define geometry?

Well, I suppose whatever geometry you invent will make no difference at all.
Roughly speaking, Linux does not use any geometry.

Also, the geometry change you refer to is old, not something that happened
during 2.6.

Since reading the partition table is the very first thing that happens
on the disk, any kind of IDE problem will cause problems reading the pt

Check whether you can read that disk using dd.
Check that fdisk still can read the table on that disk.
Go back to 2.6.6 and check that the pt table is still OK.
Check what type it is, and that your 2.6.7 kernel still has
configured that type.

