Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUKFCLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUKFCLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 21:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUKFCLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 21:11:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:30676 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261295AbUKFCLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 21:11:19 -0500
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041105215021.GF1295@stusta.de>
References: <20041105215021.GF1295@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1099707007.13834.1969.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Nov 2004 21:10:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 16:50, Adrian Bunk wrote:
> The patch below completely removes 7 functions that were
> EXPORT_SYMBOL'ed but had exactly zero users in the kernel and makes
> another one that was previously EXPORT_SYMBOL'ed static.
> 
> It also removes another unused global function to completely remove
> drivers/acpi/hardware/hwtimer.c which contained no function used
> anywhere in the kernel.
> 
> Please comment on whether this patch is correct or whether in-kernel
> users of these functions are pending.
> 
> 
> diffstat output:
>  drivers/acpi/acpi_ksyms.c        |    8 -
>  drivers/acpi/events/evxfevnt.c   |  191 -----------------------------
>  drivers/acpi/hardware/Makefile   |    2
>  drivers/acpi/hardware/hwtimer.c  |  200
> -------------------------------
>  drivers/acpi/resources/rsxface.c |   52 --------
>  drivers/acpi/scan.c              |    6
>  drivers/acpi/utilities/utxface.c |   89 -------------
>  include/acpi/achware.h           |   17 --
>  include/acpi/acpi_bus.h          |    1
>  include/acpi/acpixf.h            |   24 ---
>  10 files changed, 6 insertions(+), 584 deletions(-)

No, I can't apply this one as-is.
Some of these routines are not called now
simply because Linux/ACPI is evolving and we don't
yet take advantage of some of the things supported
by ACPICA core we use.

thanks,
-Len


