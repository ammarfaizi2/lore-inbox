Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUIWQ3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUIWQ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIWQ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:29:12 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:6529 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266345AbUIWQ1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:27:03 -0400
Date: Fri, 24 Sep 2004 01:23:01 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, tokunaga.keiich@jp.fujitsu.com
Subject: [PATCH][0/4] NUMA node handling support for ACPI container driver
Message-Id: <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20040920094719.H14208@unix-os.sc.intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	<20040920094719.H14208@unix-os.sc.intel.com>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 09:47:19 -0700, Keshavamurthy Anil S wrote:
> Changes from previous release:
> 1) Typo fix- ACPI004 to ACPI0004
> 2) Added depends on EXPERIMENTAL in Kconfig file
> 
> ---
> Name:container_drv.patch
> Status: Tested on 2.6.9-rc1
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Depends:	
> Version: applies on 2.6.9-rc1
> Description:
> This is the very early version on the Container driver which supports
> hotplug notifications on ACPI0004, PNP0A05 and PNP0A06 devices.
> 	Changes from previous release:
> 	1) Mergerd the typo fix patch which changes "ACPI004" to "ACPI0004"
> ---

I have made a patchset to add 'NUMA node handling support' to
your patchset.  If a container that is identical to NUMA node is
hotplugged, this handles NUMA related stuffs.  For instance,
creating/deleting sysfs directories and files of node, data structures,
and etc...

  - numa_hp_base.patch
  - numa_hp_ia64.patch
  - acpi_numa_hp.patch
  - container_for_numa.patch

Status: Tested on 2.6.9-rc2 including your patchset posted earlier.

Thanks,
Keiichiro Tokunaga
