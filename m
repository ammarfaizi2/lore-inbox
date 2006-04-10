Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWDJL2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDJL2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 07:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDJL2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 07:28:32 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:48023 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751140AbWDJL2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 07:28:32 -0400
Date: Mon, 10 Apr 2006 13:28:18 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Message-ID: <20060410112817.GE12896@harddisk-recovery.com>
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 06:16:56PM +0800, Aubrey wrote:
> I've written a framebuffer driver and put it under the folder
> "./drivers/video", it consists of two files" mydriver.c and myfun.S".

Why would you write a driver in assembly in the first place? That makes
it highly unportable, I bet you can't compile your driver for x86 and
ARM from the same source. There are only four drivers in the whole
kernel tree that have an assembly part, but those are so tied to their
platform (Acorn, Amiga) that they aren't portable anyway.

> When I build it into the kernel image, everything is ok.
> But when I build it as module, I got the following error message:
> ===========================================
> aubrey@linux:~/cvs/kernel/uClinux-dist> make V=1
> --------snip---------
> make -f scripts/Makefile.build obj=drivers/video
> make -f scripts/Makefile.build obj=drivers/video/backlight
> make[3]: *** No rule to make target `drivers/video/rgb2ycbcr.c',
> needed by `drivers/video/rgb2ycbcr.o'.  Stop.
> make[2]: *** [drivers/video] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/home/aubrey/cvs/kernel/uClinux-dist/linux-2.6.x'
> make: *** [linux] Error 1
> ===========================================
> 
> Make ask me for ".c" file. But it's an assemble file indeed.
> Is it a bug of kernel script? (I'm using 2.6.16)

I haven't seen your Makefile so I can't see what's wrong, but see
drivers/scsi/arm/Makefile for an example.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
