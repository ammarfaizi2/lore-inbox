Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTLORFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTLORFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:05:30 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:29454 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263843AbTLORFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:05:23 -0500
Date: Mon, 15 Dec 2003 18:05:17 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple partition not detected with 2.6
Message-ID: <20031215170517.GA12267@win.tue.nl>
References: <20031215141746.GA27006@joebar.freealter.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215141746.GA27006@joebar.freealter.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 03:17:46PM +0100, Ludovic Drolez wrote:

> I have one computer which has two partitions per disk.
> This partition is seen by a 2.4.xx kernel (knoppix) but
> not by a 2.6.0t7 kernel.
> 
> When booting the knoppix, dmesg says:
> 
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
> hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
> ide-cd: passing drive hde to ide-scsi emulation.
> Partition check:
> hda: [PTBL] [9729/255/63] hda1 hda2
> hdc: [PTBL] [9729/255/63] hdc1 hdc2
> 
> 
> But the 2.6.0t7 does not see the partition table. 
> Other disks are properly recognized, so it seems to
> be a problem with [PTBL] and 2.6 ...

The [PTBL] part just says that this 2.4 kernel first concluded to
a 155061/16/63 geometry but then saw the partition table and
changed it mind to 9729/255/63.
It is unrelated to partition recognition.

Check that your kernel was compiled without CONFIG_PARTITION_ADVANCED,
or, in case you selected advanced, has CONFIG_MSDOS_PARTITION selected.

If it is something else, come back (and show fdisk output).

