Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbREQJdz>; Thu, 17 May 2001 05:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261383AbREQJdq>; Thu, 17 May 2001 05:33:46 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:8709 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261382AbREQJdb>;
	Thu, 17 May 2001 05:33:31 -0400
Message-ID: <20010517113330.A9270@win.tue.nl>
Date: Thu, 17 May 2001 11:33:30 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca> <E150B5B-0004fs-00@the-village.bc.nu> <200105162358.f4GNwll13400@vindaloo.ras.ucalgary.ca> <3B032ACD.E1998F82@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B032ACD.E1998F82@mandrakesoft.com>; from Jeff Garzik on Wed, May 16, 2001 at 09:35:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 09:35:09PM -0400, Jeff Garzik wrote:

> To inject a bit of concrete into this discussion, I note that block
> devices with dynamically assigned don't work with CONFIG_DEVFS and
> devfs=only.  Block devices -require- majors currently, due to those
> !@#!@# arrays.  However, devfs_register_blkdev always returns zero when
> devfs=only, even if its a block device and a dynamic major is requested.

Jeff, this is a non-issue.
These arrays you talk about are removed in a simple edit session -
I did it a handful of times - there is no problem there whatsoever.

What you are talking about is kernel-internal. We are free to do
whatever we like inside the kernel, and we have full information.
The only question is how to transmit device identity across the
kernel space/user space boundary.

Andries


[And my solution is to use cookies - 64-bit opaque numbers that
carry no information, and are generated at random by the kernel,
but with the properties: (i) things that have a device number
today keep this number, (ii) the random generation is such that
whenever possible chances are good that after a reboot the same
device will have the same number.]
