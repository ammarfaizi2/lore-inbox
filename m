Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWCVFWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWCVFWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWCVFWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:22:44 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:52414 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750772AbWCVFWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:22:44 -0500
Message-ID: <4420DF21.8060700@bigpond.net.au>
Date: Wed, 22 Mar 2006 16:22:41 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 22 Mar 2006 05:22:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, it's being mirrored out right now, the git tree should already be all 
> there, the tar-file and patches are still uploading.
> 
> Not a lot of changes since -rc6, but there's various random one-liners 
> here and there (a number of Coverity bugs found, for example), and there 
> are small MIPS and PowerPC updates.
> 
> Appended is the shortlog from 2.6.16-rc6, the full log (from 2.6.15) is on 
> the web/ftp-sites. 
> 
> It looks like both Fedora and SuSE end up using a kernel that is pretty 
> close to this 2.6.16 release, so let's all hope it's good. Give it a good 
> testing, please,

I've just noticed some strange error messages that were printed during 
boot but don't seem to have any adverse effects when running.

Mar 22 16:10:31 heathwren kernel: ACPI: PM-Timer IO Port: 0x1008
Mar 22 16:10:31 heathwren kernel: ACPI: LAPIC (acpi_id[0x00] 
lapic_id[0x00] enabled)
Mar 22 16:10:31 heathwren kernel: Processor #0 15:3 APIC version 20

### First CPU seen.

Mar 22 16:10:31 heathwren kernel: ACPI: LAPIC (acpi_id[0x01] 
lapic_id[0x01] enabled)
Mar 22 16:10:31 heathwren kernel: Processor #1 15:3 APIC version 20

### Second CPU seen.

Mar 22 16:10:31 heathwren kernel: ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl 
lint[0x1])
Mar 22 16:10:31 heathwren kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl 
lint[0x1])
Mar 22 16:10:31 heathwren kernel: ACPI: IOAPIC (id[0x02] 
address[0xfec00000] gsi_base[0])
Mar 22 16:10:31 heathwren kernel: IOAPIC[0]: apic_id 2, version 20, 
address 0xfec00000, GSI 0-23
Mar 22 16:10:31 heathwren kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 
global_irq 2 dfl dfl)
Mar 22 16:10:31 heathwren kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 
global_irq 9 dfl dfl)
Mar 22 16:10:31 heathwren kernel: Enabling APIC mode:  Flat.  Using 1 
I/O APICs
Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and 
CONFIG_X86_PC cannot handle it.

### No more CPUs seen but something in there thinks there's more than 8 
of them.

Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or 
CONFIG_X86_BIGSMP.
Mar 22 16:10:31 heathwren kernel: Using ACPI (MADT) for SMP 
configuration information

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
