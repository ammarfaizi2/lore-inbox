Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTARXhv>; Sat, 18 Jan 2003 18:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTARXhu>; Sat, 18 Jan 2003 18:37:50 -0500
Received: from [195.39.74.230] ([195.39.74.230]:896 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265211AbTARXhu>;
	Sat, 18 Jan 2003 18:37:50 -0500
Date: Sun, 19 Jan 2003 00:44:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.5.59: Input subsystem initialised really late
Message-ID: <20030119004447.A359@ucw.cz>
References: <E18ZwH5-0007ks-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E18ZwH5-0007ks-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Jan 18, 2003 at 04:56:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 04:56:51PM +0000, Russell King wrote:

> It appears to be impossible to get a SysRQ-T dump out of a kernel which
> has hung during (eg) the SCSI initialisation with 2.5.
> 
> Unlike previous 2.4 kernels, the keyboard is no longer initialised until
> fairly late - after many of the other drivers have initialised.
> Unfortunately, this means that it is quite difficult to debug these hangs
> (we'll leave discussion about in-kernel debuggers for another time!)
> 
> Can we initialise the input subsystem earlier (eg, after pci bus
> initialisation, before disks etc) so that we do have the ability to use
> the SysRQ features?

I think this should be possible, yes.

-- 
Vojtech Pavlik
SuSE Labs
