Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUHaTgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUHaTgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUHaTcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:32:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:46753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269046AbUHaT3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:29:46 -0400
Date: Tue, 31 Aug 2004 12:27:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: CONFIG_ACPI totally broken (2.6.9-rc1-mm2)
Message-Id: <20040831122756.675eaa86.akpm@osdl.org>
In-Reply-To: <233310000.1093979634@flay>
References: <231570000.1093979338@flay>
	<233310000.1093979634@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > OK, not only does it not compile in -mm2, you also can't disable it.
> 
> The exact same config file works fine in -mm1 ... it's just the -mm2
> one that's broken.
>  
> > Moreover, if you try you get this:
> > 
> > scripts/kconfig/mconf arch/i386/Kconfig
> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_AC
> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K7_ACPI
> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K8_ACPI
> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_EC
> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_SPEEDSTEP_CENTRINO_ACPI
> > Warning! Found recursive dependency: DRM_I830 DRM_I915 DRM_I830

Yeah, that one.  I bugged Len the other day, but perhaps he's
out of town or something.

> > larry:~/linux/2.6.9-rc1-mm2# egrep '(HT|MMCONFIG|HPET)' .config
> ># CONFIG_HPET_TIMER is not set
> ># CONFIG_X86_HT is not set
> ># CONFIG_PCI_GOMMCONFIG is not set
> ># CONFIG_HPET is not set
> > 
> > larry:~/linux/2.6.9-rc1-mm2# grep ACPI .config
> ># Power management options (ACPI, APM)
> ># ACPI (Advanced Configuration and Power Interface) Support
> > CONFIG_ACPI=y
> ># CONFIG_ACPI_AC is not set
> ># CONFIG_ACPI_BATTERY is not set
> ># CONFIG_ACPI_BUTTON is not set
> ># CONFIG_ACPI_FAN is not set
> ># CONFIG_ACPI_PROCESSOR is not set
> ># CONFIG_ACPI_ASUS is not set
> ># CONFIG_ACPI_TOSHIBA is not set
> ># CONFIG_ACPI_DEBUG is not set
> > CONFIG_ACPI_EC=y
> > CONFIG_ACPI_PCI=y
> > 
> > How the hell do you turn this stuff off?
> > 
> > M.
