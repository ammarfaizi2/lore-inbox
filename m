Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265515AbUEVAcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUEVAcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265482AbUEUX77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:59:59 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39613 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265126AbUEUXep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:34:45 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1085033656.12352.486.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 May 2004 15:12:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.7

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.7/acpi-20040326-2.6.7.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c       |   42 +++++++++++++++++--------
 arch/i386/kernel/mpparse.c         |    8 ++--
 arch/i386/mach-es7000/es7000plat.c |   24 ++++++++++++++
 arch/ia64/kernel/acpi.c            |   41 ++++++++++++++++--------
 arch/x86_64/kernel/io_apic.c       |    2 -
 drivers/acpi/ac.c                  |    3 +
 drivers/acpi/acpi_ksyms.c          |    2 -
 drivers/acpi/asus_acpi.c           |   26 ++++++++++++++-
 drivers/acpi/battery.c             |    7 ++++
 drivers/acpi/bus.c                 |    8 ++++
 drivers/acpi/button.c              |   19 +++++------
 drivers/acpi/ec.c                  |    6 +++
 drivers/acpi/events/evxface.c      |   27 ++++++++++++++++
 drivers/acpi/fan.c                 |    2 +
 drivers/acpi/osl.c                 |   16 ++++++++-
 drivers/acpi/power.c               |    2 +
 drivers/acpi/scan.c                |   18 ++--------
 drivers/acpi/tables.c              |    5 +-
 drivers/acpi/thermal.c             |   10 +++++
 include/acpi/acpiosxf.h            |    4 ++
 include/linux/acpi.h               |    2 -
 21 files changed, 213 insertions(+), 61 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/05/18 1.1371.709.22)
   [ACPI] remove /proc files before unloading modules
   from Sau Dan Lee, Zhenyu Wang
   http://bugzilla.kernel.org/show_bug.cgi?id=2705

<len.brown@intel.com> (04/05/18 1.1371.709.21)
   [ACPI] revert button module unload fix (2281)
   Cset exclude: len.brown@intel.com|ChangeSet|20040503042906|02093
   Cset exclude: len.brown@intel.com|ChangeSet|20040428081825|02121
   Cset exclude:
len.brown@intel.com[lenb]|ChangeSet|20040428071221|03892

<len.brown@intel.com> (04/05/14 1.1608.9.6)
   [ACPI] delete IOAPIC-disable workaround on x86_64/VIA
   http://bugme.osdl.org/show_bug.cgi?id=1530

<len.brown@intel.com> (04/05/13 1.1608.9.5)
   [ACPI] create kacpid thread to handle ACPI work in process context.
   Also will be needed for cpu hot-unplug.
   from Anil S Keshavamurthy and David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=2515

<len.brown@intel.com> (04/05/12 1.1608.9.4)
   [ACPI] Add MADT error checking (Yi Zhu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1434

<len.brown@intel.com> (04/05/12 1.1608.9.3)
   [ACPI] if _STA.functional, set _STA.present (Bjorn Helgaas)
   workaround for Big Sur and Bull systems

<len.brown@intel.com> (04/05/11 1.1608.9.2)
   [ACPI] create platform_rename_gsi() so ES7000 can munge IRQ numbers
   from Natalie Protasevich




