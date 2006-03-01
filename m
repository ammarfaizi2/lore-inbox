Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWCAJL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWCAJL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 04:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWCAJL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 04:11:29 -0500
Received: from trinity.fluff.org ([212.13.204.133]:22928 "EHLO
	trinity.fluff.org") by vger.kernel.org with ESMTP id S964887AbWCAJL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 04:11:28 -0500
Date: Wed, 1 Mar 2006 09:10:35 +0000
From: Ben Dooks <ben-linux-arm@fluff.org>
To: Koen Martens <linuxarm@metro.cx>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] s3c2412 support
Message-ID: <20060301091035.GB26072@trinity.fluff.org>
References: <44045B98.8010405@metro.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44045B98.8010405@metro.cx>
User-Agent: Mutt/1.3.28i
X-Disclaimer: These are my views alone.
X-URL: http://www.fluff.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:18:00PM +0100, Koen Martens wrote:
> From: Koen Martens <kmartens@sonologic.nl>
> 
> Changes are:
> - Added s3c2412-specific files to arch/arm/mach-s3c2410
> - Added s3c2412 detection to arch/arm/mach-s3c2410/cpu.c
> - Added CONFIG_CPU_S3C2412
> - Added s3c2412 specific registers and register addresses to
>  various regs-*.h files in include/asm-arm/arch-s3c2410

It would help to split these emails into smaller chunks than all the files
so that comments could be with the chunks that it goes with.

Kconfig.diff	- fine, no problems here
Makefile.diff	- going to have to remove those #s at somepoint
regs-clock.diff - didn't need to add s3c2412_get_pll, same as s3c2410_get_pll 
regs-gpio.diff	- group the s3c2412 changes together into larger #ifdefs
regs-irq.diff	- looks fine
regs-rtc.diff	- two sets of changes here? 2410 and 2412 additions
s3c2412_c.diff	- looks fine
s3c2412_h.diff	- looks fine

cpu.diff:

the 2412 is an ARM926EJS, so I'd expect the core-ID accessed
via the co-processor registers to be diffeernt, so this could give
the indication of what sort of CPU to try.

this also seems to have the S3C2442 ID patch from the patch-q in it,
please be careful about merging patches like that.

> All changes are preliminary, final documentation is not yet available
> from samsung. We did test on actual hardware, but outside the linux
> kernel (due to limited number of actual chips we have available and
> lack of proper PCB with serial lines exported).

[snip]

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

