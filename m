Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUIXEsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUIXEsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUIXEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:48:42 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32161 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267720AbUIXEsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:48:37 -0400
Date: Fri, 24 Sep 2004 13:44:49 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [PATCH][4/4] Add NUMA node handling to the container driver
In-reply-to: <41534989.3070001@kolumbus.fi>
To: Mika Penttil_ <mika.penttila@kolumbus.fi>
Cc: tokunaga.keiich@jp.fujitsu.com, anil.s.keshavamurthy@intel.com,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <20040924134449.7d4041f3.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094719.H14208@unix-os.sc.intel.com>
 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
 <20040924013642.00003b08.tokunaga.keiich@jp.fujitsu.com>
 <41534989.3070001@kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Keiichiro Tokunaga wrote:
> 
> >Name: container_for_numa.patch
> >Status: Tested on 2.6.9-rc2
> >Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> >Description:
> >Add NUMA node handling to the container driver.
> >
> >Thanks,
> >Keiichiro Tokunaga
> >---
> >@@ -198,6 +208,7 @@ container_device_add(struct acpi_device 
> > 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
> > 		return_VALUE(-ENODEV);
> > 	}
> >+	container_numa_add((*device)->handle);
> >  
> >
> Maybe that should be :
> 
> container_numa_add(phandle);
>  
> instead? Device is the child at this point.

Thanks for looking!

A container's handle needs to be passed to the function here.
The (*device)->handle is the handle.  So there is no problem.
The phandle is just used for acpi_bus_add().

Thanks,
Keiichiro Tokunaga
