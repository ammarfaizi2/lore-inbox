Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUI0LvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUI0LvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUI0LvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:51:18 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14998 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266748AbUI0LvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:51:08 -0400
Date: Mon, 27 Sep 2004 20:47:12 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
In-reply-to: <20040924163632.C27778@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, alex.williamson@hp.com,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <20040927204712.703a20bd.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920093819.E14208@unix-os.sc.intel.com>
 <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
 <1095864779.6105.3.camel@tdi>
 <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com>
 <20040924163632.C27778@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004 16:36:32 -0700 Keshavamurthy Anil S wrote:
> On Thu, Sep 23, 2004 at 02:10:31AM +0900, Keiichiro Tokunaga wrote:
> > On Wed, 22 Sep 2004 08:52:59 -0600, Alex Williamson wrote:
> > > On Wed, 2004-09-22 at 22:15 +0900, Keiichiro Tokunaga wrote:
> > > > 
> > > > I would like to suggest introducing a new function 'acpi_get_pxm()'
> > > > since other drivers might need it in the future.  Acutally, ACPI container
> > > > hotplug will be using it soon.
> > > > 
> > > > Here is a patch creating the function.
> > > > 
> > > 
> > >    Nice, I have a couple I/O locality patches that could be simplified
> 
> Here is the revised patch which now fixes the all issues that were discussed.
> 	- Now defines and uses acpi_get_pxm
> 	- small bugfix "change __initdata to __devinitdata for pxm_to_nid_map varable

Thanks for your work!  But, you might forget to merge the small bugfix
patch.  See the diffstat below.  The target file of small bugfix is
include/asm-ia64/acpi.h, but it didn't show up below:)

>  linux-2.6.9-rc2-askeshav/arch/i386/kernel/acpi/boot.c |   22 +++
>  linux-2.6.9-rc2-askeshav/arch/ia64/kernel/acpi.c      |  107 +++++++++++++++++-
>  linux-2.6.9-rc2-askeshav/drivers/acpi/numa.c          |   19 +++
>  linux-2.6.9-rc2-askeshav/include/linux/acpi.h         |   14 ++
>  4 files changed, 159 insertions(+), 3 deletions(-)

Thanks,
Keiichiro Tokunaga
