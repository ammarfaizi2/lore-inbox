Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTAPTsC>; Thu, 16 Jan 2003 14:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTAPTsC>; Thu, 16 Jan 2003 14:48:02 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:4756 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267238AbTAPTsA>;
	Thu, 16 Jan 2003 14:48:00 -0500
Date: Thu, 16 Jan 2003 20:56:53 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jim Houston <jim.houston@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE OnTrack remap for 2.5.58
Message-ID: <20030116195653.GA22359@win.tue.nl>
References: <200301161814.h0GIEbb02258@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301161814.h0GIEbb02258@linux.local>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 01:14:37PM -0500, Jim Houston wrote:

> I'm running a Seagate 80 GB disk in an old Pentium Pro dual processor.
> I installed the current Redhat (phoebe) beta, and it works fine until
> I try to boot a 2.5.58 kernel.  It fails to mount the root disk because
> the disk has been setup with OnTrack remaping.  I didn't do anything
> to ask for this remapping.  Perhaps Seagate is shipping with this pre-
> installed?
> 
> I went back and looked through the patches and found that the remapping
> support was removed in patch-2.5.30.  The comments in the mailing list
> suggest that it belonged in user space.  I have not found code/instructions
> on how to do this.  Since then, most of IDE code has been reverted to the
> 2.4 versions but not this bit.
> 
> The attached patch is just the bit of code which was removed in 2.5.30
> with the obvious changes needed to make it work in a 2.5.58 kernel.
> I have a dream of upgrading my test machine to something clean and modern
> unpolluted by backwards compatible cruft.  Until then, this bit of code
> doesn't seem too bad.

My point of view:
(i) We must not carry this geometry nonsense forward in all
eternity. It is superfluous today. Get rid of it.
(ii) So, the automatic remapping is killed.
Most likely, there will be some people that still have old machines where
this remapping is necessary. Then there are two possible responses:
(iia) Don't run the latest kernel on an old cruft setup. Or,
(iib) Use boot parameters.

So, I am waiting a little, but if there is sufficient demand
we must have boot parameters that ask for an OnTrack remapping.

Concerning your particular case, I expect that you'll find that
your remapping is entirely superfluous.

If you like low level fiddling, boot from a floppy, e.g. tomsrtbt,
adapt the partition table and reboot. Now all should be well,
both under old and under new kernels. No data loss.

If you don't know how to fiddle, boot from a floppy, wipe the MBR
using dd if=/dev/zero, and reinstall. All data is lost.

Many intermediate approaches are possible.
We can discuss details in case you are interested.

Andries
aeb@cwi.nl

