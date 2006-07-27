Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWG0A04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWG0A04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWG0A04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:26:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35300 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751833AbWG0A0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:26:55 -0400
Date: Thu, 27 Jul 2006 02:23:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
In-Reply-To: <20060726103226.69aa79c1.kristen.c.accardi@intel.com>
Message-ID: <Pine.LNX.4.64.0607270218190.6761@scrub.home>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
 <20060725164125.A15861@unix-os.sc.intel.com> <20060726103226.69aa79c1.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 26 Jul 2006, Kristen Carlson Accardi wrote:

>  config HOTPLUG_PCI_ACPI
>  	tristate "ACPI PCI Hotplug driver"
> -	depends on ACPI_DOCK && HOTPLUG_PCI
> +	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
>  	help

If you keep the HOTPLUG_PCI separate, it won't break the menu, e.g. 
((!ACPI_DOCK && ACPI) || ACPI_DOCK) && HOTPLUG_PCI
BTW most of this file could be put into a "if HOTPLUG_PCI" group, so all 
the HOTPLUG_PCI dependencies don't have to be repeated.

bye, Roman
