Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWGYXvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWGYXvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWGYXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:51:11 -0400
Received: from mga07.intel.com ([143.182.124.22]:12372 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964879AbWGYXvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:51:09 -0400
X-IronPort-AV: i="4.07,181,1151910000"; 
   d="scan'208"; a="71093576:sNHT26490842"
Date: Tue, 25 Jul 2006 16:41:25 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       akpm@osdl.org, zippel@linux-m68k.org, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Message-ID: <20060725164125.A15861@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>; from kristen.c.accardi@intel.com on Tue, Jul 25, 2006 at 04:18:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 04:18:54PM -0700, Kristen Carlson Accardi wrote:
>     drivers/pci/hotplug/Kconfig |   17 ++++++++++++++++-
>     1 file changed, 16 insertions(+), 1 deletion(-)
Can;t this be done with just one line change?

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

> 
>     config HOTPLUG_PCI_ACPI
>            tristate "ACPI PCI Hotplug driver"
>    -       depends on ACPI_DOCK && HOTPLUG_PCI
	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
