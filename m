Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbUKKLTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUKKLTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUKKLN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:13:26 -0500
Received: from [195.135.223.242] ([195.135.223.242]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262212AbUKKLLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:11:39 -0500
Date: Thu, 11 Nov 2004 00:38:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
Message-ID: <20041110233833.GD1099@elf.ucw.cz>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099707007.13834.1969.camel@d845pe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The patch below completely removes 7 functions that were
> > EXPORT_SYMBOL'ed but had exactly zero users in the kernel and makes
> > another one that was previously EXPORT_SYMBOL'ed static.
> > 
> > It also removes another unused global function to completely remove
> > drivers/acpi/hardware/hwtimer.c which contained no function used
> > anywhere in the kernel.
> > 
> > Please comment on whether this patch is correct or whether in-kernel
> > users of these functions are pending.
> > 
> > 
> > diffstat output:
> >  drivers/acpi/acpi_ksyms.c        |    8 -
> >  drivers/acpi/events/evxfevnt.c   |  191 -----------------------------
> >  drivers/acpi/hardware/Makefile   |    2
> >  drivers/acpi/hardware/hwtimer.c  |  200
> > -------------------------------
> >  drivers/acpi/resources/rsxface.c |   52 --------
> >  drivers/acpi/scan.c              |    6
> >  drivers/acpi/utilities/utxface.c |   89 -------------
> >  include/acpi/achware.h           |   17 --
> >  include/acpi/acpi_bus.h          |    1
> >  include/acpi/acpixf.h            |   24 ---
> >  10 files changed, 6 insertions(+), 584 deletions(-)
> 
> No, I can't apply this one as-is.
> Some of these routines are not called now
> simply because Linux/ACPI is evolving and we don't
> yet take advantage of some of the things supported
> by ACPICA core we use.

I believe right thing to do is remove them now, and re-add them later
(if they are ever needed).

Single line patch somewhere which happens to pull whole evxfevnt.c
would be pretty "expensive", but would not certainly look so...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
