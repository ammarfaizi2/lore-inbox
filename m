Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUIAAcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUIAAcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbUIAAaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:30:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:45055 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269054AbUHaTmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:42:15 -0400
Date: Tue, 31 Aug 2004 12:41:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: CONFIG_ACPI totally broken (2.6.9-rc1-mm2)
Message-ID: <235850000.1093981311@flay>
In-Reply-To: <20040831122756.675eaa86.akpm@osdl.org>
References: <231570000.1093979338@flay><233310000.1093979634@flay> <20040831122756.675eaa86.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > OK, not only does it not compile in -mm2, you also can't disable it.
>> 
>> The exact same config file works fine in -mm1 ... it's just the -mm2
>> one that's broken.

OK, removing all the "select ACPI" statements from arch/i386/Kconfig
fixes it ... but all of the things that those were under were already
disabled. So I think it might be a Kconfig bug.
  
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq

should demonstrate it well.

>> > Moreover, if you try you get this:
>> > 
>> > scripts/kconfig/mconf arch/i386/Kconfig
>> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_AC
>> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K7_ACPI
>> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K8_ACPI
>> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_EC
>> > Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_SPEEDSTEP_CENTRINO_ACPI
>> > Warning! Found recursive dependency: DRM_I830 DRM_I915 DRM_I830
> 
> Yeah, that one.  I bugged Len the other day, but perhaps he's
> out of town or something.

Nah, he's talking to me on IRC, so he can't escape ;-)
