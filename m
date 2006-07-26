Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWGZMMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWGZMMB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWGZMMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:12:00 -0400
Received: from mga06.intel.com ([134.134.136.21]:53258 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750719AbWGZML7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:11:59 -0400
X-IronPort-AV: i="4.07,183,1151910000"; 
   d="scan'208"; a="104792358:sNHT29333514"
Date: Wed, 26 Jul 2006 05:02:17 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       akpm@osdl.org, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       greg@kroah.com, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Message-ID: <20060726050217.A20441@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com> <20060725164125.A15861@unix-os.sc.intel.com> <Pine.LNX.4.58.0607251711020.15622@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0607251711020.15622@shark.he.net>; from rdunlap@xenotime.net on Tue, Jul 25, 2006 at 05:13:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 05:13:31PM -0700, Randy.Dunlap wrote:
> On Tue, 25 Jul 2006, Keshavamurthy Anil S wrote:
> 
> > On Tue, Jul 25, 2006 at 04:18:54PM -0700, Kristen Carlson Accardi wrote:
> > >     drivers/pci/hotplug/Kconfig |   17 ++++++++++++++++-
> > >     1 file changed, 16 insertions(+), 1 deletion(-)
> > Can;t this be done with just one line change?
> 
> The first attempted patch was something like:
> 
> 	depends on HOTPLUG_PCI && ACPI_DOCK!=n
> 
> but that is not legal kconfig language.
> Did you have something else in mind?

Yup, already mentioned in my first email.
Please see below which is just one line change
and acheives the same as your 17 line change patch.

> > >    -       depends on ACPI_DOCK && HOTPLUG_PCI
> > 	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)

-Anil
