Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbULBAC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbULBAC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULBAAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:00:53 -0500
Received: from fmr18.intel.com ([134.134.136.17]:44480 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261525AbULAX5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:57:36 -0500
Subject: [BKPATCH] ACPI for 2.6.10
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1101945436.8026.392.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Dec 2004 18:57:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/26-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20041105-26-latest-release.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    7 
 arch/i386/kernel/acpi/Makefile      |    1 
 arch/i386/kernel/acpi/boot.c        |    6 
 arch/i386/kernel/acpi/earlyquirk.c  |   51 +++++
 arch/i386/kernel/apic.c             |   23 ++
 arch/i386/kernel/dmi_scan.c         |   56 ------
 arch/i386/kernel/io_apic.c          |   11 -
 arch/i386/kernel/mpparse.c          |    7 
 arch/i386/kernel/reboot.c           |   13 -
 arch/i386/mach-es7000/es7000plat.c  |    4 
 drivers/acpi/Makefile               |    2 
 drivers/acpi/acpi_ksyms.c           |  162 ------------------
 drivers/acpi/battery.c              |  205 +++++++++++-------------
 drivers/acpi/bus.c                  |   10 +
 drivers/acpi/dispatcher/dsmthdat.c  |    3 
 drivers/acpi/dispatcher/dswstate.c  |   10 -
 drivers/acpi/ec.c                   |   61 ++++---
 drivers/acpi/events/evxface.c       |   13 +
 drivers/acpi/events/evxfevnt.c      |   15 +
 drivers/acpi/events/evxfregn.c      |    4 
 drivers/acpi/executer/exdump.c      |    4 
 drivers/acpi/fan.c                  |   50 ++---
 drivers/acpi/hardware/Makefile      |    4 
 drivers/acpi/hardware/hwgpe.c       |    3 
 drivers/acpi/hardware/hwregs.c      |    4 
 drivers/acpi/hardware/hwsleep.c     |    7 
 drivers/acpi/hardware/hwtimer.c     |    5 
 drivers/acpi/namespace/Makefile     |    4 
 drivers/acpi/namespace/nsdump.c     |    4 
 drivers/acpi/namespace/nsload.c     |    4 
 drivers/acpi/namespace/nsutils.c    |    3 
 drivers/acpi/namespace/nsxfeval.c   |    7 
 drivers/acpi/namespace/nsxfname.c   |    4 
 drivers/acpi/namespace/nsxfobj.c    |    5 
 drivers/acpi/osl.c                  |   30 +++
 drivers/acpi/parser/pstree.c        |    4 
 drivers/acpi/parser/psutils.c       |    2 
 drivers/acpi/pci_bind.c             |    2 
 drivers/acpi/pci_irq.c              |   43 +++--
 drivers/acpi/pci_link.c             |   24 ++
 drivers/acpi/pci_root.c             |    2 
 drivers/acpi/processor.c            |   62 +++----
 drivers/acpi/resources/Makefile     |    4 
 drivers/acpi/resources/rsutils.c    |    3 
 drivers/acpi/resources/rsxface.c    |   10 +
 drivers/acpi/scan.c                 |    8 
 drivers/acpi/sleep/Makefile         |    4 
 drivers/acpi/sleep/poweroff.c       |    2 
 drivers/acpi/sleep/sleep.h          |    1 
 drivers/acpi/sleep/wakeup.c         |   32 +++
 drivers/acpi/system.c               |   45 ++---
 drivers/acpi/tables/tbconvrt.c      |    2 
 drivers/acpi/tables/tbutils.c       |    3 
 drivers/acpi/tables/tbxface.c       |    7 
 drivers/acpi/tables/tbxfroot.c      |    2 
 drivers/acpi/utilities/utalloc.c    |    3 
 drivers/acpi/utilities/utdebug.c    |    7 
 drivers/acpi/utilities/utglobal.c   |    4 
 drivers/acpi/utilities/utmisc.c     |    3 
 drivers/acpi/utilities/utxface.c    |    6 
 drivers/acpi/utils.c                |    4 
 drivers/acpi/video.c                |    4 
 drivers/char/ipmi/ipmi_si_intf.c    |    4 
 include/acpi/acdebug.h              |    5 
 include/acpi/acdispat.h             |    8 
 include/acpi/achware.h              |    5 
 include/acpi/acinterp.h             |    3 
 include/acpi/acmacros.h             |    8 
 include/acpi/acnamesp.h             |   10 +
 include/acpi/acparser.h             |    4 
 include/acpi/acpiosxf.h             |    6 
 include/acpi/acpixf.h               |   20 ++
 include/acpi/acresrc.h              |    4 
 include/acpi/actables.h             |    2 
 include/acpi/acutils.h              |    6 
 include/acpi/platform/acenv.h       |    8 
 include/acpi/processor.h            |    6 
 include/asm-i386/acpi.h             |    7 
 include/asm-i386/apic.h             |    6 
 include/asm-i386/io_apic.h          |    2 
 include/asm-i386/pci-direct.h       |    1 
 include/linux/acpi.h                |    6 
 82 files changed, 681 insertions(+), 535 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/12/01 1.1988.133.10)
   [ACPI] update C-state limiting patch
   
   Now "max_cstate=" instead of "acpi_cstate_limit="
   Delete redundant static cstate flags .c2 and .c3
   
   http://bugme.osdl.org/show_bug.cgi?id=3549
      
      For static processor driver, boot cmdline:
      processor.max_cstate=2
      
      For processor module, /etc/modprobe.conf:
      options processor max_cstate=2
      or
      # modprobe processor max_cstate=2
      
      From kernel or kernel module:
      #include <linux/acpi.h>
      acpi_set_cstate_limit(2);
    
   Suggested-by: Pavel Machek
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/01 1.1988.133.9)
   [ACPI] disable LAPIC at reboot and poweroff if Linux forced it on
   http://bugzilla.kernel.org/show_bug.cgi?id=3643
   
   Signed-off-by: Alexey Y Starikovskiy
<alexey.y.starikovskiy@intel.com>
   Signed-off-by: Ingo Molnar <mingo@elte.hu>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/01 1.1988.133.8)
   Cset exclude:
len.brown@intel.com[lenb]|ChangeSet|20041109085620|42985

<len.brown@intel.com> (04/12/01 1.1988.133.7)
   [ACPI] IPMI must supply the address of its GPE handler to install or
remove it
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/01 1.1988.133.6)
   [ACPI] fix reboot on poweroff regression due to enabled wakeup GPEs
   http://bugzilla.kernel.org/show_bug.cgi?id=3669
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/12/01 1.1988.133.5)
   [ACPI] fix IRQ assignment regression with CONFIG_PNPACPI=y
   http://bugzilla.kernel.org/show_bug.cgi?id=3762
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/30 1.1988.133.4)
   [ACPI] platform_rename_gsi() is no longer limited to ACPI specific
code,
   so call it ioapic_renumber_irq().
   
   A note to google:
   GSI is a Global System Interrupt -- a flat, linear, global IRQ
number.
   
   Suggested-by: Linus Torvalds
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/30 1.2067)
   [ACPI] fix build errors resulting from auto-merge
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/23 1.1988.133.3)
   [ACPI] survive a BIOS that erroneously supplies multiple MADTs
   http://bugzilla.redhat.com/beta2/show_bug.cgi?id=135449
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/12 1.1988.133.2)
   [ACPI] add #ifdef ACPI_FUTURE_USAGE
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/12 1.1988.133.1)
   [ACPI] remove acpi_ksyms.c
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/11 1.1988.132.8)
   [ACPI] remove acpi_ksyms.c
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/11 1.2063)
   Cset exclude: torvalds@ppc970.osdl.org|ChangeSet|20041111002817|28673
   Cset exclude:
acme@conectiva.com.br[torvalds]|ChangeSet|20041111002501|29509

<len.brown@intel.com> (04/11/11 1.1988.132.7)
   [ACPI] fix warnings for 64-bit video build (Luming Yu)

<len.brown@intel.com> (04/11/11 1.1988.132.6)
   [ACPI] clean up the NFORCE BIOS bug workaround
   delete now obsolete dmi_scan entries
   fix build for ACPI & !IOAPIC
   
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/11 1.1988.132.5)
   [ACPI] automatic workaround for NFORCE timer-override BIOS bug
   http://bugzilla.kernel.org/show_bug.cgi?id=3551
   
   Signed-off-by: Andi Kleen <ak@suse.de>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/11 1.1988.132.4)
   [ACPI] migrate to seq_file() interface
   http://bugzilla.kernel.org/show_bug.cgi?id=3333
   
   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/11 1.1988.132.3)
   [ACPI] handle out of spec EC bit width
   http://bugzilla.kernel.org/show_bug.cgi?id=1744
   
   Signed-off-by: Luming Yu <luming.yu@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/10 1.1988.132.2)
   Merge

<len.brown@intel.com> (04/11/09 1.1803.119.56)
   [ACPI] fix LAPIC-mode poweroff on D600
   http://bugzilla.kernel.org/show_bug.cgi?id=3643
   
   Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
   Signed-off-by: Len Brown <len.brown@intel.com>

<len.brown@intel.com> (04/11/09 1.1803.119.55)
   fix non-ACPI IOAPIC build

<len.brown@intel.com> (04/11/09 1.1803.119.54)
   [ACPI] acpi_pci_irq_enable() now returns 0 on success.
   This bubbles all the way up to pci_enable_device().
   This allows IRQ0 to be used as a legal PCI device IRQ.
   
   The ES7000 uses an interrupt source override to assign pin20 to IRQ0.
   Then platform_rename_gsi assigns pin0 a high-numbered IRQ --
available
   for PCI devices.  But IRQ0 needs to be a legal PCI IRQ in the lookup
code
   to make it as far as the re-name code. 
   
   Signed-off-by: Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
   Signed-off-by: Len Brown <len.brown@intel.com>




