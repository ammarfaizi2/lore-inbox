Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132195AbRAOFfJ>; Mon, 15 Jan 2001 00:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132314AbRAOFen>; Mon, 15 Jan 2001 00:34:43 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:60679 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S132140AbRAOFef>;
	Mon, 15 Jan 2001 00:34:35 -0500
Date: Sun, 14 Jan 2001 21:34:27 -0800
From: alex@foogod.com
To: Jordan <jordang@pcc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't build small enough zImage for floppy
Message-ID: <20010114213427.A10734@draco.foogod.com>
In-Reply-To: <3A5F7BA7.B2FF852B@pcc.net> <20010112152032.C5625@draco.foogod.com> <3A604FF7.EF3D9D51@pcc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A604FF7.EF3D9D51@pcc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 06:54:15AM -0600, Jordan wrote:
> alex@foogod.com wrote:
> 
> > I forgot to ask.. when attempting to boot from a floppy, are you using
> > SYSLINUX, or something else?  What version?
> 
> unsure.  I have booted floppies on my machine before which displayed SYSLINUX on
> boot, but the 2.4.0 kernel I compiled (on my Red Hat 6.2 with 2.2.14-5.0 Vaio
> Desktop) and used "make bzdisk" to make the disk, does not display SYSLINUX while
> booting.  It displays
> 
> Loading.........................................
> Uncompressing Linux...
> 
> invalid compressed format (err=21)
> 
> -- System Halted

Ah, this explains it.. the basic bootloader built into the kernel images is 
apparently not compatible with the Z505 (possibly because it doesn't like the 
BIOS emulation done to make the USB floppy look like a traditional floppy 
drive during boot).  I've never attempted this form of booting a kernel 
before, so I hadn't seen this behavior (of course this method also seems to 
have different problems booting on my desktop system, too, so..).  Had you 
managed to make a small enough zImage you would have had the same results.

My advice is to try using SYSLINUX 
(http://www.kernel.org/pub/linux/utils/boot/syslinux/) to load the kernel 
instead of writing it straight to the floppy, as this is known to work on the 
Z505 and is more flexible anyway.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
