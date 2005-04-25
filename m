Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVDYQiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVDYQiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVDYQgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:36:24 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:25028 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262668AbVDYQeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:34:37 -0400
Date: Mon, 25 Apr 2005 12:34:36 -0400
To: Randy Gardner <lkml@bushytails.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd?  Can burn DVDs, just not read them...
Message-ID: <20050425163436.GA15693@csclub.uwaterloo.ca>
References: <426972E5.4000408@bushytails.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426972E5.4000408@bushytails.net>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 02:55:49PM -0700, Randy Gardner wrote:
> I just bought a shiny new 16x dvd burner (box says IOMagic IDVD16DD, 
> drive says Magicspin 1016IM), and can burn dvds perfectly...  just not 
> read them.
> 
> Tried with both a dvd I burnt and with a purchased factory-made DVD, on 
> two computers, with three different IDE controllers, with no change.
> 
> Under 2.6.8.1, trying to read files off a dvd instantly oopses.  Under 
> 2.6.11.7, reads are very, very slow, pegs the CPU at 100% (with dma 
> on!), and sometimes give errors in the logs.  Under 2.6.12-rc3, reads 
> don't work at all, 100% cpu, always logs errors, dma gets disabled, and 
> typically the box takes a reboot to get it usable after trying to read 
> (box is bogged down; 2 second keyboard delay, etc).  Those are using 
> ide-cd; trying ide-scsi just panics.
> 
> Burning works perfectly; 8x burns use about 3% cpu, with no errors.
> 
> Motherboard in this system is a MSI 694D Pro (dual pentium 3) with Via 
> VT82c686a chipset.  I use pci=noacpi, as acpi causes other problems 
> (most notably two of my PCI slots stop working, even with the board 
> flashed to the latest bios; putting a card in them causes either hangs 
> or nobody cared errors).  Enabling acpi doesn't change the dvd problems. 
>  Tested using both the standard ata/66 controller and the promise 
> PDC20265 ide RAID controller.
> 
> As a test, I drove the drive over to a relative's house, and popped it 
> into her dual-boot system, with a via 82c596b chipset, no acpi at all. 
> under 2.6.11.7, it has the exact same symptoms as on my box.  Under 
> windoze, the drive works flawlessly, and can even read the dvds I burnt 
> under linux with no errors.

Have you checked that the drive is running the latest firmware release
for it?  Bad firmware causes all sorts of problems.

What other device is it sharing the cable with?  Which is master and
which is slave?

Is it a 40 or 80 conductor ide cable?  Most 8x+ DVD writers want an 80
conductor as far as I know (at least to operate at full speed).

Len Sorensen
