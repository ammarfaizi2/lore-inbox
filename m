Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVAQU4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVAQU4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVAQU4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:56:44 -0500
Received: from dialin-160-45.tor.primus.ca ([216.254.160.45]:13696 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262890AbVAQU4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:56:35 -0500
Date: Mon, 17 Jan 2005 15:55:19 -0500
From: William Park <opengeometry@yahoo.ca>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Thomas Zehetbauer <thomasz@hostmaster.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage on SMP?
Message-ID: <20050117205519.GA2277@node1.opengeometry.net>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Thomas Zehetbauer <thomasz@hostmaster.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1105982247.21895.26.camel@hostmaster.org> <200501171826.33496.rjw@sisk.pl> <20050117194615.GA2028@node1.opengeometry.net> <41EC1993.2030105@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC1993.2030105@grupopie.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 08:01:23PM +0000, Paulo Marques wrote:
> William Park wrote:
> >On Mon, Jan 17, 2005 at 06:26:33PM +0100, Rafael J. Wysocki wrote:
> >
> >>On Monday, 17 of January 2005 18:17, Thomas Zehetbauer wrote:
> >>
> >>>Hi,
> >>>
> >>>can anyone confirm that writing to usb-storage devices is working
> >>>on SMP systems?
> >>
> >>Generally, it is.  Recently, I've written some stuff to a USB
> >>pendrive (using 2.6.10-ac7 or -ac9).
> >
> >
> >Same here with Abit VP6 dual-P3 and 2.6.10.  It shows up as /dev/sda,
> >and I can do anything that I would do with normal harddisk.
> >
> >But, I still can't boot from it. :/  I can now mount it as root
> >filesystem, but I can't load the kernel from USB key drive.
> 
> huh?? Who's mounting the root filesystem, then :) ?
> 
> If you mean that you can't get the BIOS to load the kernel for you, and 
> you're loading the kernel from a floppy or something, you should know 
> that some BIOS are pretty selective about what they consider a valid 
> boot partition.

Hee, hee... yes, for now I boot from floppy first, then mount /dev/sda1
as root filesystem.  I, of course, want to get rid of the floppy.  My
motherboard is Mercury PVCLE266M-L with VIA C3 Samuel 2 cpu integrated
on the board.  It has tons of boot device options, and detects my USB
key (SanDisk Cruzer Mini 256MB) as "USB RMD-FDD" and not as some kind of
harddisk.  I think that's the problem: motherboard thinks it's floppy,
and LILO thinks it's SCSI harddisk (/dev/sda).

> 
> I recommend that you use fdisk to set up one partition as FAT16 type
> (even if you use another filesystem later), and make the partition
> active. You might need to write a proper MBR on the pen also (IIRC
> LILO as an option to do this).
> 
> You might also need to pass a special "disk=/dev/sda bios=0x80" (or
> something like that) option in your lilo.conf file, but that depends
> how far in the boot process you're hanging.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
