Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbUKYCrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUKYCrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbUKYCpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:45:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59405 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262933AbUKYCpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:45:07 -0500
Date: Wed, 24 Nov 2004 19:44:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Daniel_Weigert@adp.com
Cc: jpiszcz@lucidpixels.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 SCSI driver compile error w/gcc-3.4.2.
Message-ID: <20041124184459.GE19873@stusta.de>
References: <2D1DF9BA9166D61188F30002B3A6E15318E4D826@ROSEEXCHMA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D1DF9BA9166D61188F30002B3A6E15318E4D826@ROSEEXCHMA>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 01:35:37PM -0500, Daniel_Weigert@adp.com wrote:
> >> SNIP <<
> 
> >> root@p500b:/usr/src/linux# make modules
> >>   CHK     include/linux/version.h
> >> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
> >>   CC [M]  drivers/scsi/cpqfcTScontrol.o
> >> drivers/scsi/cpqfcTScontrol.c:609:2: #error This is too much stack
> >> drivers/scsi/cpqfcTScontrol.c:721:2: #error This is too much stack
> >> make[2]: *** [drivers/scsi/cpqfcTScontrol.o] Error 1
> >>...
> 
> >> SNIP << 
> > It's known that some drivers do not compile and marked in the Kconfig 
> > files. But if you choose to try to compile them anyway, they don't 
> > compile.
> > cu
> >Adrian
> 
> The problem that I have with this, isn't that the driver is broken (it works
> under 2.4), It isn't labeled as broken in the menuconfig, if you choose the
> option to include the dubious drivers. Unfortunately, I do need this

It's marked as BROKEN, and if you choose the option to enable broken 
drivers, you are offered to compile broken drivers.

> particular driver and hope someone steps up to the plate to take care of it.

If this is the only problem in this driver, the fix wasn't too hard.
But considering how long this problem is unfixed, the driver doesn't 
seem to be in a good shape...

> Dan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

