Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUCFGd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 01:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUCFGd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 01:33:27 -0500
Received: from fmr99.intel.com ([192.55.52.32]:46725 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261603AbUCFGdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 01:33:24 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1078554761.12998.3197.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Mar 2004 01:32:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040220-2.4.26.diff.gz

This will update the following files:

 Documentation/Configure.help        |    8 --
 Documentation/kernel-parameters.txt |    2 
 MAINTAINERS                         |    2 
 arch/i386/kernel/acpi.c             |    9 +--
 arch/i386/kernel/mpparse.c          |   11 ++--
 arch/i386/kernel/setup.c            |    5 +
 arch/x86_64/kernel/acpi.c           |   10 +--
 arch/x86_64/kernel/e820.c           |    6 ++
 arch/x86_64/kernel/mpparse.c        |   11 ++--
 drivers/acpi/executer/exfldio.c     |    7 +-
 drivers/acpi/hardware/hwgpe.c       |    8 ++
 drivers/acpi/hardware/hwregs.c      |    6 +-
 drivers/acpi/hardware/hwsleep.c     |   66 +++++++++++++++++++++---
 drivers/acpi/namespace/nseval.c     |    4 -
 drivers/acpi/namespace/nsutils.c    |    6 +-
 drivers/acpi/namespace/nsxfname.c   |    7 ++
 drivers/acpi/pci_link.c             |    2 
 drivers/acpi/resources/rsxface.c    |   18 ++++++
 drivers/acpi/system.c               |   10 ++-
 drivers/acpi/utilities/uteval.c     |   60 +++++++++++++++++++++
 drivers/acpi/utilities/utglobal.c   |    7 ++
 include/acpi/acconfig.h             |    2 
 include/acpi/acglobal.h             |   25 ++++-----
 include/acpi/actypes.h              |    3 -
 include/acpi/acutils.h              |    4 +
 include/asm-i386/acpi.h             |    1 
 include/asm-ia64/acpi.h             |    2 
 include/asm-x86_64/acpi.h           |    1 
 28 files changed, 233 insertions(+), 70 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/06 1.1331)
   [ACPI] fix ia64 build error (Bjorn Helgaas)

<len.brown@intel.com> (04/02/27 1.1063.46.78)
   [ACPI] ACPICA 20040220 from Bob Moore
   
   Implemented execution of _SxD methods for Device objects in the
   GetObjectInfo interface.
   
   Fixed calls to _SST method to pass the correct arguments.
   
   Added a call to _SST on wake to restore to "working" state.
   
   Check for End-Of-Buffer failure case in the WalkResources interface.
   
   Integrated fix for 64-bit alignment issue in acglobal.h by moving two
   structures to the beginning of the file.
   
   After wake, clear GPE status register(s) before enabling GPEs.
   
   After wake, clear/enable power button.
   (Perhaps we should clear/enable all fixed events upon wake.)
   
   Fixed a couple of possible memory leaks in the Namespace manager.

<len.brown@intel.com> (04/02/27 1.1063.46.77)
   [ACPI] include CONFIG_ACPI_RELAXED_AML code always
     add acpi=strict option to disable platform workarounds

<len.brown@intel.com> (04/02/26 1.1321.1.1)
   [ACPI] delete unnecessary dmesg lines, fix spelling

<len.brown@intel.com> (04/02/25 1.1063.46.76)
   [ACPI] interrupt over-ride for nforce from Maciej W. Rozycki

<len.brown@intel.com> (04/02/25 1.1063.46.75)
   ACPI URL update




