Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbUKLE6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUKLE6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 23:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUKLE6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 23:58:25 -0500
Received: from fmr05.intel.com ([134.134.136.6]:8620 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262436AbUKLE6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 23:58:20 -0500
Subject: Re: [2.6 patch] kill acpi_ksyms.c
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041109014021.GB15077@stusta.de>
References: <20041105215021.GF1295@stusta.de>
	 <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de>
	 <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de>
	 <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe>
	 <20041109014021.GB15077@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1100235412.5519.922.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2004 23:56:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Mon, 2004-11-08 at 20:40, Adrian Bunk wrote:
...
> Below is as a preparation a patch that removes acpi_ksyms.c .
> 
> It shouldn't make any practical difference.
> 
> The function acpi_db_user_commands that wasn't available in the whole
> kernel sources was EXPORT_SYMBOL'ed. The patch removes this bogus
> export.
> 
> 
> diffstat output:
>  drivers/acpi/Makefile             |    2
>  drivers/acpi/acpi_ksyms.c         |  165
> ------------------------------
>  drivers/acpi/bus.c                |   10 +
>  drivers/acpi/ec.c                 |    2
>  drivers/acpi/events/evxface.c     |   10 +
>  drivers/acpi/events/evxfevnt.c    |    8 +
>  drivers/acpi/events/evxfregn.c    |    4
>  drivers/acpi/hardware/hwregs.c    |    4
>  drivers/acpi/hardware/hwsleep.c   |    4
>  drivers/acpi/hardware/hwtimer.c   |    5
>  drivers/acpi/namespace/nsxfeval.c |    4
>  drivers/acpi/namespace/nsxfname.c |    4
>  drivers/acpi/namespace/nsxfobj.c  |    5
>  drivers/acpi/osl.c                |   18 +++
>  drivers/acpi/pci_irq.c            |    2
>  drivers/acpi/pci_root.c           |    2
>  drivers/acpi/resources/rsxface.c  |    7 +
>  drivers/acpi/scan.c               |    6 -
>  drivers/acpi/tables/tbconvrt.c    |    2
>  drivers/acpi/tables/tbxface.c     |    3
>  drivers/acpi/tables/tbxfroot.c    |    2
>  drivers/acpi/utilities/utdebug.c  |    7 +
>  drivers/acpi/utilities/utglobal.c |    4
>  drivers/acpi/utilities/utxface.c  |    2
>  drivers/acpi/utils.c              |    4
>  include/acpi/acdebug.h            |    5
>  26 files changed, 112 insertions(+), 179 deletions(-)


