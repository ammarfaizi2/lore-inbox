Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266696AbUBGJL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUBGJL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:11:29 -0500
Received: from fmr03.intel.com ([143.183.121.5]:48365 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266696AbUBGJLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:11:08 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076145024.8687.32.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Feb 2004 04:10:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.25

	the AML param fix is in 2.6 -- the others changes
	are Asus and Toshiba model specific.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.25/acpi-20040116-2.4.25.diff.gz

This will update the following files:

 drivers/acpi/asus_acpi.c           |  753 +++++++++++++++----------
 drivers/acpi/dispatcher/dsmthdat.c |   10 
 drivers/acpi/pci_irq.c             |   12 
 drivers/acpi/toshiba_acpi.c        |   81 +-
 4 files changed, 533 insertions(+), 323 deletions(-)

through these ChangeSets:

<sziwan@hell.org.pl> (04/02/06 1.1063.46.71)
   [PATCH] acpi4asus update from Karol 'sziwan' Kozimor
   
   The attached patch updates the acpi4asus driver to 0.27 through the
   following changes:
   - add support for M1300A, S5200N, L8400L,
   - remove WLED support for certain models, since it is not controlled
by
     AML,
   - add LCD backlight switching for L2E / L3H,
   - C99 initializers,
   - generic LED handlers,
   - the output of ASYM method to provide battery state information
(might be
     more accurate under certain conditions) in /proc/acpi/asus/info,
   - fix several oddities, various clean-ups and other minor changes.
   
   The patch itself is quite big, which is mostly due to the C99
initializers
   and the fact that diff doesn't like moving code around.
   
   This has been compile-tested in various configurations, the
substantive
   changes were discussed on the acpi4asus mailing list.
   
   The code should apply to current bk (both for 2.4 and 2.6). The patch
is
   also available here:
   http://hell.org.pl/~sziwan/asus/acpi4asus-0.26-0.27.diff
   
   Thanks to all the contributors (notably Pontus Fuchs) to this
release.

<john@neggie.net> (04/02/05 1.1063.46.70)
   [PATCH] toshiba_acpi 0.17 from John Belmonte
   
   Fix remote chance of invalid buffer access in write_video.
   Support alternate HCI method path (recent "Phoenix BIOS" Toshiba's).
   Signal more proc-write errors.
   On proc-reads, report errors via printk instead of proc output.
   Add log level and driver name prefix to all printk's.
   Add missing __init and __exit function attributes.
   Be explicit about vars for which code relies on zero-init of BSS.

<len.brown@intel.com> (04/02/05 1.1063.46.69)
   [ACPI] fix IA64 build warning
   from Martin Hicks

<len.brown@intel.com> (04/01/30 1.1293)
   [ACPI] proposed fix for AML parameter passing from Bob Moore
     http://bugzilla.kernel.org/show_bug.cgi?id=1766




