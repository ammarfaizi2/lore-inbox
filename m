Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWHWN5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWHWN5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHWN5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:57:07 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:57027 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932235AbWHWN5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:57:05 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Aug 2006 15:56:47 +0200
MIME-Version: 1.0
Subject: unexpected kernel messages for Sun Fire X4100 (NUMA Opteron 64bit) with SLES10
Message-ID: <44EC7AC0.12128.6635514@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.06.0+V=4.06+U=2.07.138+R=05 June 2006+T=125821@20060823.135407Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please add myself to CC: as I'm not subscribed to this list.
I'm currently evaluating Novell/SUSE Enterprise Server 10 (SLES10) on a Sun Fire 
X4100.
That machine basically features two Dual-Core AMD Opteron CPUs with 8GB RAM each. 
I'm running the latest SLES10 kernel (2.6.16.21-0.15-smp #1 SMP Tue Jul 25 
15:28:49 UTC 2006 x86_64 x86_64 x86_64 GNU/Linux) and the latest firmware for the 
hardware (Sun seems not to produce a lot of those however: The Service Processor 
still runs with "Linux version 2.4.22").

There are some kernel messages that either seem to indicate a problem with Sun's 
hardware/firmware or the Linux kernel. Even after querying Google for advice, I 
could only solve one of the problems ("Aperture from northbridge cpu 0 too small 
(32MB)").

[Solved one]
  <4>Checking aperture...
  <4>CPU 0: aperture @ 10000000 size 32 MB
  <4>Aperture from northbridge cpu 0 too small (32 MB)
  <4>No AGP bridge found
  <4>Your BIOS doesn't leave a aperture memory hole
  <4>Please enable the IOMMU option in the BIOS setup
  <4>This costs you 64 MB of RAM
  <4>Mapping aperture over 65536 KB of RAM @ 4000000


So here I come showing the remaining messages, seeking for advice from the 
experts:

[#1]
  <4>PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
  <4>PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
  <4>PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
  <4>PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
  <4>hpet_acpi_add: no address or irqs in _CRS

The BIOS Version (MP spec rev 1.4; SMBIOS Version: 2.3; Vendor: "American 
Megatrends Inc."; Version: "080010"; Date: "08/10/2005") is "2.53". I have no idea 
what the messages are about.

[#2]
  <6>shpchp: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
  <3>shpchp: shpc_init: cannot reserve MMIO region
  <6>shpchp: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
  <3>shpchp: shpc_init: cannot reserve MMIO region
  <6>shpchp: Standard Hot Plug PCI Controller Driver version: 0.4

The device in question seems to be a "00:01.0 PCI bridge: Advanced Micro Devices 
[AMD] AMD-8131 PCI-X Bridge (rev 13)" (no add-on PCI cards installed).

[#3]
  <6>powernow-k8: Found 4 AMD Athlon 64 / Opteron processors (version 1.60.2)
  <3>powernow-k8: MP systems not supported by PSB BIOS structure
  <3>powernow-k8: MP systems not supported by PSB BIOS structure
  <3>powernow-k8: MP systems not supported by PSB BIOS structure
  <3>powernow-k8: MP systems not supported by PSB BIOS structure

The CPUs are (shortened):
processor       : 3
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : Dual Core AMD Opteron(tm) Processor 285
stepping        : 2
cpu MHz         : 2592.705

and the BIOS supports MPS Revision 1.4 with "PowerNow" being enabled in BIOS. I 
was hoping powersaving would work (as it does on my private Athlon 64 X2).

Regards,
Ulrich

