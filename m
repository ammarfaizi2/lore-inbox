Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUJ1Jhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUJ1Jhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbUJ1Jet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:34:49 -0400
Received: from fmr11.intel.com ([192.55.52.31]:17820 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262851AbUJ1Jdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:33:32 -0400
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1098955997.5402.122.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Oct 2004 05:33:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 arch/i386/kernel/apic.c           |    6 
 arch/i386/kernel/dmi_scan.c       |   40 ------
 arch/i386/kernel/mpparse.c        |    2 
 drivers/acpi/Makefile             |    2 
 drivers/acpi/bus.c                |   39 +++++-
 drivers/acpi/events/evmisc.c      |    2 
 drivers/acpi/motherboard.c        |  159 ++++++++++++++++++++++++++
 drivers/acpi/osl.c                |    6 
 drivers/acpi/utilities/utglobal.c |    6 
 include/acpi/acglobal.h           |   37 ++++--
 include/acpi/acpi_drivers.h       |    3 
 include/asm-i386/mpspec.h         |    1 
 init/main.c                       |    6 
 13 files changed, 246 insertions(+), 63 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/10/13 1.1458.1.4)
   [ACPI] If BIOS disabled the LAPIC, believe it by default.
   "lapic" is available to force enabling the LAPIC
   in the event you know more than your BIOS vendor.
   http://bugzilla.kernel.org/show_bug.cgi?id=3238

<len.brown@intel.com> (04/08/25 1.1458.1.3)
   [ACPI] build fix

<len.brown@intel.com> (04/08/24 1.1458.1.2)
   [ACPI] fix build warnings

<len.brown@intel.com> (04/08/24 1.1458.1.1)
   [ACPI] Enter ACPI mode earlier
   Fixes two common boot failures due to buggy SMM BIOS code
   
   SMP boot crash if SMI_CMD=ACPI written from CPU1
   http://bugzilla.kernel.org/show_bug.cgi?id=2941
   
   laptop crash due to LAPIC timer before SMI_CMD=ACPI
   http://bugzilla.kernel.org/show_bug.cgi?id=1269

<len.brown@intel.com> (04/08/13 1.1458)
   set acpi_gbl_leave_wake_gpes_disabled to FALSE for 2.4
   because it would take a backport of big 2.6 changes to make
   this code work and 2.4 doesn't support suspend/resume anyway.

<len.brown@intel.com> (04/08/13 1.1457)
   [ACPI] boot option fixes from 2.6
   "acpi_serialize" "acpi_wake_gpes_always_on" "acpi_osi="
   http://bugzilla.kernel.org/show_bug.cgi?id=2534

<len.brown@intel.com> (04/06/24 1.1359.6.29)
   [ACPI] reserve IOPORTS for ACPI (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2641




