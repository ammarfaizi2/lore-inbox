Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVIHHZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVIHHZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVIHHZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:25:06 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:30972 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751328AbVIHHZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:25:02 -0400
Subject: [GIT PATCH] ACPI for 2.6.14
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "acpi-devel@lists.sourceforge.net" <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Date: Thu, 08 Sep 2005 03:18:57 -0400
Message-Id: <1126163937.21723.12.camel@toshiba>
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="134566789ABCDEFGHIJKLMNOPQRSTUVWXYYZabcd"
X-BLTSYMAVREINSERT: T01c550f0UP722kiRT5RLZmd74UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--134566789ABCDEFGHIJKLMNOPQRSTUVWXYYZabcd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This message has been processed by Brightmail(r) AntiVirus using
Symantec's AntiVirus Technology.

Unknown00000000.data was not scanned for viruses because too many nested levels of files were found.


For more information on antivirus tips and technology, visit
http://www.brightmail.com/antivirus .
--134566789ABCDEFGHIJKLMNOPQRSTUVWXYYZabcd
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from toshiba (c-65-96-210-63.hsd1.ma.comcast.net[65.96.210.63])
          by comcast.net (rwcrmhc12) with SMTP
          id <2005090807171301400arfrje>; Thu, 8 Sep 2005 07:17:13 +0000
Subject: [GIT PATCH] ACPI for 2.6.14
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "acpi-devel@lists.sourceforge.net" <acpi-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 03:18:57 -0400
Message-Id: <1126163937.21723.12.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from the release branch here:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.
Note that the large patch size is due to a Lindent flag day.

thanks,
-Len

ps.
Plain patch available here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050902-2.6.13.diff.gz

Individual patches available here:
http://kernel.org/git/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=summary

 Documentation/acpi-hotkey.txt               |    3 
 Documentation/ibm-acpi.txt                  |  378 ++
 arch/i386/Kconfig                           |    1 
 arch/i386/defconfig                         |    4 
 arch/i386/kernel/Makefile                   |    2 
 arch/i386/kernel/acpi/Makefile              |    2 
 arch/i386/kernel/acpi/boot.c                |  561 ++--
 arch/i386/kernel/acpi/earlyquirk.c          |   40 
 arch/i386/kernel/acpi/sleep.c               |   35 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |   57 
 arch/i386/kernel/io_apic.c                  |    4 
 arch/i386/kernel/mpparse.c                  |   18 
 arch/i386/kernel/setup.c                    |   10 
 arch/i386/mach-es7000/es7000plat.c          |    8 
 arch/i386/pci/Makefile                      |    2 
 arch/i386/pci/irq.c                         |    2 
 arch/ia64/Kconfig                           |   32 
 arch/ia64/configs/bigsur_defconfig          |    6 
 arch/ia64/configs/sn2_defconfig             |    7 
 arch/ia64/configs/tiger_defconfig           |    7 
 arch/ia64/configs/zx1_defconfig             |    7 
 arch/ia64/defconfig                         |    6 
 arch/ia64/kernel/acpi-ext.c                 |   37 
 arch/ia64/kernel/acpi.c                     |  342 +-
 arch/ia64/kernel/iosapic.c                  |   27 
 arch/ia64/kernel/setup.c                    |    4 
 arch/ia64/kernel/topology.c                 |    2 
 arch/ia64/sn/kernel/irq.c                   |    2 
 arch/ia64/sn/kernel/sn2/sn_proc_fs.c        |    2 
 arch/x86_64/Kconfig                         |    2 
 arch/x86_64/defconfig                       |    4 
 arch/x86_64/kernel/Makefile                 |    2 
 arch/x86_64/kernel/acpi/Makefile            |    4 
 arch/x86_64/kernel/acpi/sleep.c             |   17 
 arch/x86_64/kernel/genapic.c                |    4 
 arch/x86_64/kernel/io_apic.c                |    4 
 arch/x86_64/kernel/mpparse.c                |   14 
 arch/x86_64/kernel/setup.c                  |    8 
 arch/x86_64/pci/Makefile                    |    2 
 arch/x86_64/pci/Makefile-BUS                |    2 
 drivers/Makefile                            |    2 
 drivers/acpi/Kconfig                        |   85 
 drivers/acpi/Makefile                       |   14 
 drivers/acpi/ac.c                           |  138 -
 drivers/acpi/acpi_memhotplug.c              |  176 -
 drivers/acpi/asus_acpi.c                    |  692 ++---
 drivers/acpi/battery.c                      |  406 +--
 drivers/acpi/blacklist.c                    |  120 
 drivers/acpi/bus.c                          |  316 +-
 drivers/acpi/button.c                       |  276 --
 drivers/acpi/container.c                    |  128 -
 drivers/acpi/debug.c                        |  115 
 drivers/acpi/dispatcher/dsfield.c           |  346 +-
 drivers/acpi/dispatcher/dsinit.c            |  155 -
 drivers/acpi/dispatcher/dsmethod.c          |  608 ++--
 drivers/acpi/dispatcher/dsmthdat.c          |  430 +--
 drivers/acpi/dispatcher/dsobject.c          |  332 +-
 drivers/acpi/dispatcher/dsopcode.c          |  727 ++---
 drivers/acpi/dispatcher/dsutils.c           |  427 +--
 drivers/acpi/dispatcher/dswexec.c           |  517 ++--
 drivers/acpi/dispatcher/dswload.c           |  555 ++--
 drivers/acpi/dispatcher/dswscope.c          |  139 -
 drivers/acpi/dispatcher/dswstate.c          |  686 ++---
 drivers/acpi/ec.c                           | 2029 +++++++---------
 drivers/acpi/event.c                        |   80 
 drivers/acpi/events/evevent.c               |  170 -
 drivers/acpi/events/evgpe.c                 |  431 +--
 drivers/acpi/events/evgpeblk.c              |  829 +++---
 drivers/acpi/events/evmisc.c                |  303 +-
 drivers/acpi/events/evregion.c              |  582 ++--
 drivers/acpi/events/evrgnini.c              |  321 +-
 drivers/acpi/events/evsci.c                 |   77 
 drivers/acpi/events/evxface.c               |  456 +--
 drivers/acpi/events/evxfevnt.c              |  469 +--
 drivers/acpi/events/evxfregn.c              |  114 
 drivers/acpi/executer/exconfig.c            |  367 +-
 drivers/acpi/executer/exconvrt.c            |  313 +-
 drivers/acpi/executer/excreate.c            |  342 +-
 drivers/acpi/executer/exdump.c              |  939 ++++---
 drivers/acpi/executer/exfield.c             |  257 +-
 drivers/acpi/executer/exfldio.c             |  640 ++---
 drivers/acpi/executer/exmisc.c              |  360 +-
 drivers/acpi/executer/exmutex.c             |  160 -
 drivers/acpi/executer/exnames.c             |  242 -
 drivers/acpi/executer/exoparg1.c            |  584 ++--
 drivers/acpi/executer/exoparg2.c            |  317 +-
 drivers/acpi/executer/exoparg3.c            |  179 -
 drivers/acpi/executer/exoparg6.c            |  127 -
 drivers/acpi/executer/exprep.c              |  383 +--
 drivers/acpi/executer/exregion.c            |  278 --
 drivers/acpi/executer/exresnte.c            |  174 -
 drivers/acpi/executer/exresolv.c            |  286 +-
 drivers/acpi/executer/exresop.c             |  398 +--
 drivers/acpi/executer/exstore.c             |  427 +--
 drivers/acpi/executer/exstoren.c            |  125 
 drivers/acpi/executer/exstorob.c            |   86 
 drivers/acpi/executer/exsystem.c            |  183 -
 drivers/acpi/executer/exutils.c             |  173 -
 drivers/acpi/fan.c                          |  162 -
 drivers/acpi/glue.c                         |    9 
 drivers/acpi/hardware/hwacpi.c              |  116 
 drivers/acpi/hardware/hwgpe.c               |  217 -
 drivers/acpi/hardware/hwregs.c              |  608 ++--
 drivers/acpi/hardware/hwsleep.c             |  427 +--
 drivers/acpi/hardware/hwtimer.c             |   77 
 drivers/acpi/hotkey.c                       |  233 -
 drivers/acpi/ibm_acpi.c                     | 1924 ++++++++++-----
 drivers/acpi/motherboard.c                  |  106 
 drivers/acpi/namespace/nsaccess.c           |  363 +-
 drivers/acpi/namespace/nsalloc.c            |  364 --
 drivers/acpi/namespace/nsdump.c             |  509 +---
 drivers/acpi/namespace/nsdumpdv.c           |   74 
 drivers/acpi/namespace/nseval.c             |  288 +-
 drivers/acpi/namespace/nsinit.c             |  263 --
 drivers/acpi/namespace/nsload.c             |  274 --
 drivers/acpi/namespace/nsnames.c            |  118 
 drivers/acpi/namespace/nsobject.c           |  207 -
 drivers/acpi/namespace/nsparse.c            |   92 
 drivers/acpi/namespace/nssearch.c           |  205 -
 drivers/acpi/namespace/nsutils.c            |  506 +--
 drivers/acpi/namespace/nswalk.c             |  105 
 drivers/acpi/namespace/nsxfeval.c           |  430 +--
 drivers/acpi/namespace/nsxfname.c           |  173 -
 drivers/acpi/namespace/nsxfobj.c            |   91 
 drivers/acpi/numa.c                         |  125 
 drivers/acpi/osl.c                          |  807 +++---
 drivers/acpi/parser/Makefile                |    2 
 drivers/acpi/parser/psargs.c                |  374 +-
 drivers/acpi/parser/psloop.c                | 1322 ++++++++--
 drivers/acpi/parser/psopcode.c              |  749 ++++-
 drivers/acpi/parser/psparse.c               | 1268 ++-------
 drivers/acpi/parser/psscope.c               |  130 -
 drivers/acpi/parser/pstree.c                |   92 
 drivers/acpi/parser/psutils.c               |  146 -
 drivers/acpi/parser/pswalk.c                |   26 
 drivers/acpi/parser/psxface.c               |  431 +--
 drivers/acpi/pci_bind.c                     |  224 -
 drivers/acpi/pci_irq.c                      |  285 +-
 drivers/acpi/pci_link.c                     |  496 +--
 drivers/acpi/pci_root.c                     |  130 -
 drivers/acpi/power.c                        |  275 --
 drivers/acpi/processor_core.c               |  491 +--
 drivers/acpi/processor_idle.c               |  315 +-
 drivers/acpi/processor_perflib.c            |  303 +-
 drivers/acpi/processor_thermal.c            |  159 -
 drivers/acpi/processor_throttling.c         |  133 -
 drivers/acpi/resources/rsaddr.c             | 1045 +++-----
 drivers/acpi/resources/rscalc.c             |  312 +-
 drivers/acpi/resources/rscreate.c           |  293 +-
 drivers/acpi/resources/rsdump.c             |  871 +++---
 drivers/acpi/resources/rsio.c               |  172 -
 drivers/acpi/resources/rsirq.c              |  257 --
 drivers/acpi/resources/rslist.c             |  275 +-
 drivers/acpi/resources/rsmemory.c           |  218 -
 drivers/acpi/resources/rsmisc.c             |  230 -
 drivers/acpi/resources/rsutils.c            |  159 -
 drivers/acpi/resources/rsxface.c            |  182 -
 drivers/acpi/scan.c                         |  439 +--
 drivers/acpi/sleep/poweroff.c               |    2 
 drivers/acpi/sleep/proc.c                   |  285 +-
 drivers/acpi/sleep/wakeup.c                 |  115 
 drivers/acpi/system.c                       |   76 
 drivers/acpi/tables.c                       |  434 +--
 drivers/acpi/tables/tbconvrt.c              |  410 +--
 drivers/acpi/tables/tbget.c                 |  277 --
 drivers/acpi/tables/tbgetall.c              |  189 -
 drivers/acpi/tables/tbinstal.c              |  292 +-
 drivers/acpi/tables/tbrsdt.c                |  251 -
 drivers/acpi/tables/tbutils.c               |  238 +
 drivers/acpi/tables/tbxface.c               |  263 --
 drivers/acpi/tables/tbxfroot.c              |  555 ++--
 drivers/acpi/thermal.c                      |  809 +++---
 drivers/acpi/toshiba_acpi.c                 |  176 -
 drivers/acpi/utilities/Makefile             |    2 
 drivers/acpi/utilities/utalloc.c            |  815 ++----
 drivers/acpi/utilities/utcache.c            |  483 +++
 drivers/acpi/utilities/utcopy.c             |  610 ++--
 drivers/acpi/utilities/utdebug.c            |  590 ++--
 drivers/acpi/utilities/utdelete.c           |  465 +--
 drivers/acpi/utilities/uteval.c             |  394 +--
 drivers/acpi/utilities/utglobal.c           |  669 ++---
 drivers/acpi/utilities/utinit.c             |  137 -
 drivers/acpi/utilities/utmath.c             |  142 -
 drivers/acpi/utilities/utmisc.c             | 1337 ++--------
 drivers/acpi/utilities/utmutex.c            |  610 +++-
 drivers/acpi/utilities/utobject.c           |  354 +-
 drivers/acpi/utilities/utstate.c            |  535 +++-
 drivers/acpi/utilities/utxface.c            |  290 --
 drivers/acpi/utils.c                        |  195 -
 drivers/acpi/video.c                        | 1112 ++++----
 drivers/char/hpet.c                         |    8 
 drivers/char/ipmi/ipmi_si_intf.c            |    9 
 drivers/char/tpm/Kconfig                    |    2 
 drivers/pci/hotplug/Kconfig                 |    4 
 drivers/pci/hotplug/Makefile                |    4 
 drivers/pnp/Kconfig                         |    2 
 drivers/pnp/pnpacpi/Kconfig                 |    2 
 drivers/pnp/pnpacpi/rsparser.c              |   77 
 drivers/serial/8250_acpi.c                  |   20 
 drivers/serial/Kconfig                      |    2 
 include/acpi/acconfig.h                     |   47 
 include/acpi/acdebug.h                      |  269 --
 include/acpi/acdisasm.h                     |  326 --
 include/acpi/acdispat.h                     |  439 +--
 include/acpi/acevents.h                     |  245 -
 include/acpi/acexcep.h                      |   34 
 include/acpi/acglobal.h                     |  295 +-
 include/acpi/achware.h                      |  113 
 include/acpi/acinterp.h                     |  648 +----
 include/acpi/aclocal.h                      |  782 ++----
 include/acpi/acmacros.h                     |  147 -
 include/acpi/acnames.h                      |   29 
 include/acpi/acnamesp.h                     |  381 +--
 include/acpi/acobject.h                     |  402 +--
 include/acpi/acopcode.h                     |    6 
 include/acpi/acoutput.h                     |   10 
 include/acpi/acparser.h                     |  295 --
 include/acpi/acpi.h                         |   35 
 include/acpi/acpi_bus.h                     |  334 +-
 include/acpi/acpi_drivers.h                 |   42 
 include/acpi/acpiosxf.h                     |  310 --
 include/acpi/acpixf.h                       |  412 ---
 include/acpi/acresrc.h                      |  309 --
 include/acpi/acstruct.h                     |  237 -
 include/acpi/actables.h                     |  141 -
 include/acpi/actbl.h                        |  346 +-
 include/acpi/actbl1.h                       |  185 -
 include/acpi/actbl2.h                       |  364 +-
 include/acpi/actbl71.h                      |  148 -
 include/acpi/actypes.h                      |  937 +++----
 include/acpi/acutils.h                      |  884 ++----
 include/acpi/amlcode.h                      |  174 -
 include/acpi/amlresrc.h                     |  412 +--
 include/acpi/container.h                    |    3 
 include/acpi/pdc_intel.h                    |    4 
 include/acpi/platform/acenv.h               |   70 
 include/acpi/platform/acgcc.h               |   14 
 include/acpi/platform/aclinux.h             |   19 
 include/acpi/processor.h                    |  238 -
 include/asm-i386/acpi.h                     |   22 
 include/asm-i386/fixmap.h                   |    2 
 include/asm-i386/io_apic.h                  |    4 
 include/asm-i386/mpspec.h                   |    4 
 include/asm-ia64/acpi-ext.h                 |    1 
 include/asm-x86_64/acpi.h                   |   31 
 include/asm-x86_64/io_apic.h                |    2 
 include/asm-x86_64/mpspec.h                 |    2 
 include/linux/acpi.h                        |   45 
 kernel/power/Kconfig                        |    1 
 249 files changed, 31455 insertions(+), 34926 deletions(-)

through these commits:

commit 64e47488c913ac704d465a6af86a26786d1412a5
Merge: 4a35a46bf1cda4737c428380d1db5d15e2590d18
caf39e87cc1182f7dae84eefc43ca14d54c78ef9
Author: Len Brown <len.brown@intel.com>
Date:   Thu Sep 8 01:45:47 2005 -0400

    Merge linux-2.6 with linux-acpi-2.6

commit 4a35a46bf1cda4737c428380d1db5d15e2590d18
Author: Len Brown <len.brown@intel.com>
Date:   Sat Sep 3 12:40:06 2005 -0400

    [ACPI] revert bad processor_core.c patch for bug 5128
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2413d2c12cf0dc5980d7b082d838d5468d83a8b9
Author: Len Brown <len.brown@intel.com>
Date:   Sat Sep 3 02:55:47 2005 -0400

    [ACPI] build fix - processor_core.c w/ !CONFIG_SMP
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5128
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 129521dcc94f781890f8f668219ab79f0073ff9f
Merge: 824b558bbe2c298b165cdb54c33718994dda30bb
f505380ba7b98ec97bf25300c2a58aeae903530b
Author: Len Brown <len.brown@intel.com>
Date:   Sat Sep 3 02:44:09 2005 -0400

    Merge linux-2.6 into linux-acpi-2.6 test

commit 824b558bbe2c298b165cdb54c33718994dda30bb
Author: Luming Yu <luming.yu@intel.com>
Date:   Sun Aug 21 19:17:00 2005 -0400

    [ACPI] acpi_video_device_write_state() now works
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5060
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9a31477a95d642dd42a1be7cc342f5902b56f584
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Aug 30 17:55:00 2005 -0400

    [ACPI] fix processor_core.c for NR_CPUS > 256
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5128
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit dbed12da5bb06b15c63930e9282b45daea566d7b
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Sat Sep 3 00:37:56 2005 -0400

    [ACPI] PNPACPI IRQ workaround for HP workstations
    
    Move pcibios_penalize_isa_irq() to
pnpacpi_parse_allocated_irqresource().
    Previously we passed the GSI, not the IRQ, and we did it even if
parsing
    the IRQ resource failed.
    
    Parse IRQ descriptors that contain multiple interrupts.  This
violates the
    spec (in _CRS, only one interrupt per descriptor is allowed), but
some
    firmware, e.g., HP rx7620 and rx8620 descriptions of HPET, has this
bug.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Cc: Adam Belay <ambx1@neo.rr.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5f0110f2a716376f3b260703835f527ca8900946
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Sat Sep 3 00:34:32 2005 -0400

    [ACPI] fix run-time error checking in acpi_pci_irq_disable()
    
    The 'bus' field in pci_dev structure should be checked before
calling
    pci_read_config_byte() because pci_bus_read_config_byte() called by
    pci_read_config_byte() refers to 'bus' field.
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8713cbefafbb5a101ade541a4b0ffa108bf697cc
Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Sep 2 17:16:48 2005 -0400

    [ACPI] add static to function definitions
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aff8c2777d1a9edf97f26bf60579f9c931443eb1
Author: Robert Moore <Robert.Moore@intel.com>
Date:   Fri Sep 2 17:24:17 2005 -0400

    [ACPI] ACPICA 20050902
    
    Fixed a problem with the internal Owner ID allocation and
    deallocation mechanisms for control method execution and
    recursive method invocation.  This should eliminate the
    OWNER_ID_LIMIT exceptions and "Invalid OwnerId" messages
    seen on some systems.  Recursive method invocation depth
    is currently limited to 255.  (Alexey Starikovskiy)
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4892
    
    Completely eliminated all vestiges of support for the
    "module-level executable code" until this support is
    fully implemented and debugged.  This should eliminate the
    NO_RETURN_VALUE exceptions seen during table load on some
    systems that invoke this support.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5162
    
    Fixed a problem within the resource manager code where
    the transaction flags for a 64-bit address descriptor were
    handled incorrectly in the type-specific flag byte.
    
    Consolidated duplicate code within the address descriptor
    resource manager code, reducing overall subsystem code size.
    
    Signed-off-by: Robert Moore <Robert.Moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a94f18810f52d3a6de0a09bee0c7258b62eca262
Author: Len Brown <len.brown@intel.com>
Date:   Sat Sep 3 00:09:12 2005 -0400

    [ACPI] revert owner-id-3.patch
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8813dfbfc56b3f7c369b3115c2f70bcacd77ec51
Author: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Aug 25 09:56:52 2005 +0400

    [ACPI] Error: Invalid owner_id: 00
    
    Signed-off-by: Alexey Y. Starikovskiy
<alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4fbd1514173a80f9dc93e8ebbd6d4eb97cee123e
Author: Yann Droneaud <ydroneaud@mandriva.com>
Date:   Tue Jun 7 16:54:01 2005 +0200

    [ACPI] check acpi_disabled in IPMI
    
    Signed-off-by: Yann Droneaud <ydroneaud@mandriva.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a18ecf413ca9846becb760f7f990c2c62c15965e
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Aug 15 03:42:00 2005 -0800

    [ACPI] ACPICA 20050815
    
    Implemented a full bytewise compare to determine if a table load
    request is attempting to load a duplicate table. The compare is
    performed if the table signatures and table lengths match. This
    will allow different tables with the same OEM Table ID and
    revision to be loaded.
    
    Although the BIOS is technically violating the ACPI spec when
    this happens -- it does happen -- so Linux must handle it.
    
    Signed-off-by: Robert Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 27a639a92d3289c4851105efcbc2f8b88969194f
Merge: d395bf12d1ba61437e546eb642f0d7ea666123ff
bf4e70e54cf31dcca48d279c7f7e71328eebe749
Author: Len Brown <len.brown@intel.com>
Date:   Mon Aug 29 17:02:17 2005 -0400

    Auto-update from upstream

commit d395bf12d1ba61437e546eb642f0d7ea666123ff
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Aug 25 15:59:00 2005 -0400

    [ACPI] Reduce acpi-cpufreq switching latency by 50%
    
    The acpi-cpufreq driver does a P-state get after a P-state set
    to verify whether set went through successfully. This test
    is kind of redundant as set goes throught most of the times,
    and the test is also expensive as a get of P-states can
    take a lot of time (same as a set operation) as it goes
    through SMM mode. Effectively, we are doubling the P-state
    latency due to this get opertion.
    
    momdule parameter "acpi_pstate_strict" restores orginal paranoia.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5129
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 60cfff3516580f5c782cef4dc28f2974c4df8ed1
Merge: 89ef1a21a174a4f581a4b6973f9a9f9ee28a9304
212d6d2237f60bc28c1518f8abf9d3ed6c17574a
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 26 22:11:28 2005 -0400

    Auto-update from upstream

commit 89ef1a21a174a4f581a4b6973f9a9f9ee28a9304
Merge: 09d4a80e66cdf3e68cdb06e907f7bc0b242acbd0
78f81cc4355c31c798564ff7efb253cc4cdce6c0
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 17:41:14 2005 -0400

    merge ibm into test

commit 78f81cc4355c31c798564ff7efb253cc4cdce6c0
Author: Borislav Deianov <borislav@users.sf.net>
Date:   Wed Aug 17 00:00:00 2005 -0400

    [ACPI] IBM ThinkPad ACPI Extras Driver v0.12
    
    http://ibm-acpi.sf.net/
    
    Signed-off-by: Borislav Deianov <borislav@users.sf.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 09d4a80e66cdf3e68cdb06e907f7bc0b242acbd0
Merge: d0d59b98d7a0b3801ce03e695ba885b698a6d122
9c2c38a122cc23d6a09b8004d60a33913683eedf
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 12:45:49 2005 -0400

    Merge HEAD from ../from-linus 

commit d0d59b98d7a0b3801ce03e695ba885b698a6d122
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 12:41:22 2005 -0400

    [IA64] fix allnoconfig build
    
    cc: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6153df7b2f4d27c8bde054db1b947369a6f64d83
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 12:27:09 2005 -0400

    [ACPI] delete CONFIG_ACPI_PCI
    
    Delete the ability to build an ACPI kernel that does
    not include PCI support.  When such a machine is created
    and it requires a tuned kernel, send a patch.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=1364
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07fefe4ca93b3e45b2bea32871a4496067888852
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 12:22:04 2005 -0400

    [ACPI] remove "default m" from acpi/Kconfig
    
    Andi Kleen suggested it was unconventional for us to "default m"
    on ACPI modules -- even though they are expected to be deployed
    as modules.  But as "default n" would likely result in some
    users building nonsense kernels, we compromise to "default y".
    
    Distros are expected to continue to use =m in their configs.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bfea6c2af798d9a882bbc6b9ae9893ab1864d230
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 12:15:11 2005 -0400

    [ACPI] reduce use of EXPERIMENTAL in acpi/Kconfig
    
    Distros are shipping modules we had marked EXPERIMENTAL,
    so clearly it has lost some meaning.
    
    Delete that dependency for shipping modules, retaining
    it only for ACPI_HOTKEY and ACPI_CONTAINER to emphasize
    that they lack testing on real hardware.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eb7b6b32644f7a48357e02f8004f88b3220f3494
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 25 12:08:25 2005 -0400

    [ACPI] IA64-related ACPI Kconfig fixes
    
    Build issues were mostly in the ACPI=n case -- don't do that.
    Select ACPI from IA64_GENERIC.
    Add some missing dependencies on ACPI.
    
    Mark BLACKLIST_YEAR and some laptop-only ACPI drivers
    as X86-only.  Let me know when you get an IA64 Laptop.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 76f58584824c61eb5b3bdbf019236815921d2e7c
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 24 12:10:49 2005 -0400

    [ACPI] delete CONFIG_ACPI_BUS
    
    it is a synonym for CONFIG_ACPI
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8466361ad5233d4356a4601e16b66c25277920d1
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 24 12:09:07 2005 -0400

    [ACPI] delete CONFIG_ACPI_INTERPRETER
    
    it is a synonym for CONFIG_ACPI
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 888ba6c62bc61a995d283977eb3a6cbafd6f4ac6
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 24 12:07:20 2005 -0400

    [ACPI] delete CONFIG_ACPI_BOOT
    
    it has been a synonym for CONFIG_ACPI since 2.6.12
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 84ffa747520edd4556b136bdfc9df9eb1673ce12
Merge: 702c7e7626deeabb057b6f529167b65ec2eefbdb
81065e2f415af6c028eac13f481fb9e60a0b487b
Author: Len Brown <len.brown@intel.com>
Date:   Tue Aug 23 22:12:23 2005 -0400

    Merge from-linus to-akpm

commit 702c7e7626deeabb057b6f529167b65ec2eefbdb
Author: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date:   Mon Aug 8 01:09:00 2005 -0400

    [ACPI] fix ia64 build issues resulting from Lindent and merge
    
    Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Brown, Len <len.brown@intel.com>

commit 09d92002718edf8ef284ec3726247acc83efbbe0
Merge: cb220c1af49644786944c549518b491d4c654030
3edea4833a1efcd43e1dff082bc8001fdfe74b34
Author: Len Brown <len.brown@intel.com>
Date:   Mon Aug 15 16:07:26 2005 -0400

    Merge from-linus to-akpm

commit cb220c1af49644786944c549518b491d4c654030
Merge: 1dadb3dadfaa01890fc10df03f0dd03a9f8774b2
f6869979bec3cc2efddc7359f30ba37642084fb7
Author: Len Brown <len.brown@intel.com>
Date:   Mon Aug 15 15:56:23 2005 -0400

    Merge 'acpi-2.6.12' branch into to-akpm

commit f6869979bec3cc2efddc7359f30ba37642084fb7
Merge: 50526df605e7c3e22168664acf726269eae10171
30e332f3307e9f7718490a706e5ce99f0d3a7b26
Author: Len Brown <len.brown@intel.com>
Date:   Mon Aug 15 15:52:00 2005 -0400

    Merge to-linus-stable into to-akpm

commit 1dadb3dadfaa01890fc10df03f0dd03a9f8774b2
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Wed Jul 27 18:32:00 2005 -0400

    [ACPI] don't complain about PCI root bridges without _SEG
    
    There are lots of single-PCI-segment machines that don't
    supply _SEG for the root bridges.  The PCI root bridge driver
    silently assumes the segment to be zero in this case,
    so glue.c shouldn't complain either.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6c89cce75c6f93088a5a2a25bb9674a9194592cc
Merge: 13779c739168fdb905fae81287d75a9e632825e3
50526df605e7c3e22168664acf726269eae10171
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 11 17:43:19 2005 -0400

    Merge acpi-2.6.12 to-akpm

commit 50526df605e7c3e22168664acf726269eae10171
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 11 17:32:05 2005 -0400

    [ACPI] Lindent drivers/acpi/ec.c
    
    necessary for clean merge from acpi-2.6.12 to-akpm
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 716e084edb0230910b174000dc3490f9e91652e3
Author: Luming Yu <luming.yu@intel.com>
Date:   Wed Aug 10 01:40:00 2005 -0400

    [ACPI] Fix "ec_burst=1" mode latency issue
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3851
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 13779c739168fdb905fae81287d75a9e632825e3
Merge: 95f193aa4fe50eb2dc987081d066edd6e13027de
7d69fa6266770eeb6317eddd46b64456e8a515bf
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 11 17:09:15 2005 -0400

    Merge ../from-linus

commit 95f193aa4fe50eb2dc987081d066edd6e13027de
Merge: e872d4cace8681838e8d18d52c92f4870e980a08
bc68552faad0e134eb22281343d5ae5a4873fa80
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 11 00:56:08 2005 -0400

    Merge ../to-linus

commit e872d4cace8681838e8d18d52c92f4870e980a08
Merge: 1f3a730117ceda2a7c917d687921fe3c82283968
403fe5ae57c831968c3dbbaba291ae825a1c5aaa
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 5 13:03:06 2005 -0400

    Merge ../from-linus

commit 1f3a730117ceda2a7c917d687921fe3c82283968
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 5 03:33:14 2005 -0400

    [ACPI] Lindent created a syntax error that broke the build
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c202ac9fbdb64145f034be266d6ee88c98b40aa8
Merge: 4be44fcd3bf648b782f4460fd06dfae6c42ded4b
c306895167c8384b88bc02945a0d226a04218fa5
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 5 00:49:06 2005 -0400

    Merge ../to-linus

commit 4be44fcd3bf648b782f4460fd06dfae6c42ded4b
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 5 00:44:28 2005 -0400

    [ACPI] Lindent all ACPI files
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c65ade4dc8b486e8c8b9b0a6399789a5428e2039
Author: Pavel Machek <pavel@suze.cz>
Date:   Fri Aug 5 00:37:45 2005 -0400

    [ACPI] whitespace
    
    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1d492eb41371d9a5145651e8eb64bea1042a4057
Merge: 5d2a22079c825669d91a3a200332f1053b4b61b0
cbfc1bae55bbd053308ef0fa6b6448cd1ddf3e67
Author: Len Brown <len.brown@intel.com>
Date:   Fri Aug 5 00:31:42 2005 -0400

    [ACPI] Merge acpi-2.6.12 branch into 2.6.13-rc3
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cbfc1bae55bbd053308ef0fa6b6448cd1ddf3e67
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] ACPI_HOTPLUG_CPU Kconfig dependency update
    
    prevent:
    
    HOTPLUG_CPU=y
    ACPI_PROCESSOR=y
    ACPI_HOTPLUG_CPU=n
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4fdcf0804598f44b0f48da9e5281af48a4db393f
Author: Andrew Morton <len.brown@intel.com>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] lint: irqrouter_suspend() takes a pm_message_t, not a u32
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 031ec77bf67e4bda994ef8ceba267be3295ffdb7
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] acpi_remove_notify_handler() on video driver unload
    
    The video driver doesn't properly remove all the notify handlers
    on module unload.  This has a side effect of subdevices failing
    to register on module reload, but sudden death looms if the
    handlers trigger after the module is unloaded.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e92310a930462c6e1611f35453f57357c42bde14
Author: Andrew Morton <akpm@osdl.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] fix IA64 build warning
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intelc.com>

commit 53de49f52e305e96143375d1741f15acff7bf34b
Author: Andrew Morton <akpm@osdl.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] CONFIG_ACPI=n build fix
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 14454a1b3ff8d1d15fbe7cc77f27373777184ddf
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] iosapic_register_intr() now returns error instead of panic
    error condition is passed along by acpi_register_gsi().
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 58e0276245f6c60119f0384e7eca576b08aa89e2
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] 8250 driver now checks for acpi_register_gsi() errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 71df30f8e3e97fde573c41df063c2d66c1ad01b0
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] PNPACPI driver now checks for acpi_register_gsi() errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a9bd53bc49ee8984633e57c1d9d45111c58e9457
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] HPET driver now checks for acpi_register_gsi() errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 349f0d5640c18db09a646f9da51a97f1da908660
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] acpi_pci_enable_irq() now checks for acpi_register_gsi()
errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1f3a6a15771ed70d3b2581663dcc6b9bc134baa5
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] acpi_register_gsi() can return error
    
    Current acpi_register_gsi() function has no way to indicate errors
to its
    callers even though acpi_register_gsi() can fail to register gsi
because of
    some reasons (out of memory, lack of interrupt vectors, incorrect
BIOS, and so
    on).  As a result, caller of acpi_register_gsi() cannot handle the
case that
    acpi_register_gsi() fails.  I think failure of acpi_register_gsi()
should be
    handled properly.
    
    This series of patches changes acpi_register_gsi() to return
negative value on
    error, and also changes callers of acpi_register_gsi() to handle
failure of
    acpi_register_gsi().
    
    This patch changes the type of return value of acpi_register_gsi()
from
    "unsigned int" to "int" to indicate an error.  If
acpi_register_gsi() fails to
    register gsi, it returns negative value.
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d2a22079c825669d91a3a200332f1053b4b61b0
Merge: 1c5ad84516ae7ea4ec868436a910a6bd8d20215a
bd6dbdf3c7b9784fbf5d8500e427a954e27a976a
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 4 18:09:09 2005 -0400

    /home/lenb/src/to-akpm branch 'acpi-2.6.12'

commit bd6dbdf3c7b9784fbf5d8500e427a954e27a976a
Merge: aefdcfa6c243702f1d35d23515d0e5eeca225c97
d4ab025b73a2d10548e17765eb76f3b7351dc611
Author: Len Brown <len.brown@intel.com>
Date:   Thu Aug 4 00:17:42 2005 -0400

    When a merge does not work automatically, git prevents
    commit from running until a change has been made in
    the destination.  In this instance the desired result
    was to choose the destination version of the file
    and ignore the source version, but git would not
    allow that.
    
    Here I added a blank line to let git commit think
    I resolved a merge conflict.

commit aefdcfa6c243702f1d35d23515d0e5eeca225c97
Merge: 0c9938cc75057c0fca1af55a55dcfc2842436695
79cda7d0e1c8629996242c036d6fe0466038d8ba
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 3 18:12:57 2005 -0400

    Merge ../to-linus

commit 0c9938cc75057c0fca1af55a55dcfc2842436695
Author: Robert Moore <robert.moore@intel.com>
Date:   Fri Jul 29 15:15:00 2005 -0700

    [ACPI] ACPICA 20050729 from Bob Moore
    
    Implemented support to ignore an attempt to install/load
    a particular ACPI table more than once. Apparently there
    exists BIOS code that repeatedly attempts to load the same
    SSDT upon certain events. Thanks to Venkatesh Pallipadi.
    
    Restructured the main interface to the AML parser in
    order to correctly handle all exceptional conditions. This
    will prevent leakage of the OwnerId resource and should
    eliminate the AE_OWNER_ID_LIMIT exceptions seen on some
    machines. Thanks to Alexey Starikovskiy.
    
    Support for "module level code" has been disabled in this
    version due to a number of issues that have appeared
    on various machines. The support can be enabled by
    defining ACPI_ENABLE_MODULE_LEVEL_CODE during subsystem
    compilation. When the issues are fully resolved, the code
    will be enabled by default again.
    
    Modified the internal functions for debug print support
    to define the FunctionName parameter as a (const char *)
    for compatibility with compiler built-in macros such as
    __FUNCTION__, etc.
    
    Linted the entire ACPICA source tree for both 32-bit
    and 64-bit.
    
    Signed-off-by: Robert Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit dd8f39bbf5154cdbfd698fc70c66faba33eafa44
Merge: c2c2e03409f5f5405e79d9d9156202b75cb5b35b
87bec66b9691522414862dd8d41e430b063735ef
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 29 23:11:11 2005 -0400

    Merge ../to-linus

commit c2c2e03409f5f5405e79d9d9156202b75cb5b35b
Author: Iacopo Spalletti <avvisi@spalletti.it>
Date:   Sun Jul 17 02:06:00 2005 -0400

    [ACPI] update hotkey documentation
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4903
    
    Signed-off-by: Iacopo Spalletti <avvisi@spalletti.it>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 670fac79b9dcf16549a4c1f4c0b73c457e53bd7e
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 29 00:16:54 2005 -0400

    [ACPI] disable module level AML code (for now)
    
    It is important that we support module level code --
    BIOS's implement it.  But this implementation needs
    more testing.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d75ab45594c78d2d976a3248ea1ca281c9d7056
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 29 00:03:55 2005 -0400

    [ACPI] handle const char * __FUNCTION__ in debug code
    build warning: discards qualifiers from pointer target type
    when mixing "const char *" and "char *"
    
    We should probably update the routines to expect const,
    but easier for now to shut up the warning with 1 cast.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit feee9570753645f9f6888937ff9aee426b7afe55
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 29 00:01:00 2005 -0400

    [ACPI] comment out prototypes for new unused debug routines
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f9f4601f331aa1226d7a798a01950efbb388f07f
Author: Robert Moore <robert.moore@intel.com>
Date:   Fri Jul 8 00:00:00 2005 -0400

    ACPICA 20050708 from Bob Moore <robert.moore@intel.com>
    
    The use of the CPU stack in the debug version of the
    subsystem has been considerably reduced.  Previously, a
    debug structure was declared in every function that used
    the debug macros.  This structure has been removed in
    favor of declaring the individual elements as parameters
    to the debug functions.  This reduces the cumulative stack
    use during nested execution of ACPI function calls at the
    cost of a small increase in the code size of the debug
    version of the subsystem.  With assistance from Alexey
    Starikovskiy and Len Brown.
    
    Added the ACPI_GET_FUNCTION_NAME macro to enable the
    compiler-dependent headers to define a macro that will
    return the current function name at runtime (such as
    __FUNCTION__ or _func_, etc.) The function name is used
    by the debug trace output.  If ACPI_GET_FUNCTION_NAME
    is not defined in the compiler-dependent header, the
    function name is saved on the CPU stack (one pointer per
    function.) This mechanism is used because apparently there
    exists no standard ANSI-C defined macro that that returns
    the function name.
    
    Alexey Starikovskiy redesigned and reimplemented the
    "Owner ID" mechanism used to track namespace objects
    created/deleted by ACPI tables and control method
    execution.  A bitmap is now used to allocate and free the
    IDs, thus solving the wraparound problem present in the
    previous implementation.  The size of the namespace node
    descriptor was reduced by 2 bytes as a result.
    
    Removed the UINT32_BIT and UINT16_BIT types that were used
    for the bitfield flag definitions within the headers for
    the predefined ACPI tables.  These have been replaced by
    UINT8_BIT in order to increase the code portability of
    the subsystem.  If the use of UINT8 remains a problem,
    we may be forced to eliminate bitfields entirely because
    of a lack of portability.
    
    Alexey Starikovksiy enhanced the performance of
    acpi_ut_update_object_reference.  This is a frequently used
    function and this improvement increases the performance
    of the entire subsystem.
    
    Alexey Starikovskiy fixed several possible memory leaks
    and the inverse - premature object deletion.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4c3ffbd79529b680b3c3ef2b6f42f0c89c694ec5
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Thu Jul 14 00:00:00 2005 -0400

    [ACPI] revert R40 workaround
    
    Should not be necessary...
    
    http://bugme.osdl.org/show_bug.cgi?id=1038
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 73459f73e5d1602c59ebec114fc45185521353c1
Author: Robert Moore <robert.moore@intel.com>
Date:   Fri Jun 24 00:00:00 2005 -0400

    ACPICA 20050617-0624 from Bob Moore <robert.moore@intel.com>
    
    ACPICA 20050617:
    
    Moved the object cache operations into the OS interface
    layer (OSL) to allow the host OS to handle these operations
    if desired (for example, the Linux OSL will invoke the
    slab allocator).  This support is optional; the compile
    time define ACPI_USE_LOCAL_CACHE may be used to utilize
    the original cache code in the ACPI CA core.  The new OSL
    interfaces are shown below.  See utalloc.c for an example
    implementation, and acpiosxf.h for the exact interface
    definitions.  Thanks to Alexey Starikovskiy.
    	acpi_os_create_cache
    	acpi_os_delete_cache
    	acpi_os_purge_cache
    	acpi_os_acquire_object
    	acpi_os_release_object
    
    Modified the interfaces to acpi_os_acquire_lock and
    acpi_os_release_lock to return and restore a flags
    parameter.  This fits better with many OS lock models.
    Note: the current execution state (interrupt handler
    or not) is no longer passed to these interfaces.  If
    necessary, the OSL must determine this state by itself, a
    simple and fast operation.  Thanks to Alexey Starikovskiy.
    
    Fixed a problem in the ACPI table handling where a valid
    XSDT was assumed present if the revision of the RSDP
    was 2 or greater.  According to the ACPI specification,
    the XSDT is optional in all cases, and the table manager
    therefore now checks for both an RSDP >=2 and a valid
    XSDT pointer.  Otherwise, the RSDT pointer is used.
    Some ACPI 2.0 compliant BIOSs contain only the RSDT.
    
    Fixed an interpreter problem with the Mid() operator in the
    case of an input string where the resulting output string
    is of zero length.  It now correctly returns a valid,
    null terminated string object instead of a string object
    with a null pointer.
    
    Fixed a problem with the control method argument handling
    to allow a store to an Arg object that already contains an
    object of type Device.  The Device object is now correctly
    overwritten.  Previously, an error was returned.
    
    ACPICA 20050624:
    
    Modified the new OSL cache interfaces to use ACPI_CACHE_T
    as the type for the host-defined cache object.  This allows
    the OSL implementation to define and type this object in
    any manner desired, simplifying the OSL implementation.
    For example, ACPI_CACHE_T is defined as kmem_cache_t for
    Linux, and should be defined in the OS-specific header
    file for other operating systems as required.
    
    Changed the interface to AcpiOsAcquireObject to directly
    return the requested object as the function return (instead
    of ACPI_STATUS.) This change was made for performance
    reasons, since this is the purpose of the interface in the
    first place.  acpi_os_acquire_object is now similar to the
    acpi_os_allocate interface.  Thanks to Alexey Starikovskiy.
    
    Modified the initialization sequence in
    acpi_initialize_subsystem to call the OSL interface
    acpi_osl_initialize first, before any local initialization.
    This change was required because the global initialization
    now calls OSL interfaces.
    
    Restructured the code base to split some files because
    of size and/or because the code logically belonged in a
    separate file.  New files are listed below.
    
      utilities/utcache.c	/* Local cache interfaces */
      utilities/utmutex.c	/* Local mutex support */
      utilities/utstate.c	/* State object support */
      parser/psloop.c	/* Main AML parse loop */
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 88ac00f5a841dcfc5c682000f4a6add0add8caac
Author: Robert Moore <robert.moore@intel.com>
Date:   Thu May 26 00:00:00 2005 -0400

    ACPICA 20050526 from Bob Moore <robert.moore@intel.com>
    
    Implemented support to execute Type 1 and Type 2 AML
    opcodes appearing at the module level (not within a control
    method.)  These opcodes are executed exactly once at the
    time the table is loaded. This type of code was legal up
    until the release of ACPI 2.0B (2002) and is now supported
    within ACPI CA in order to provide backwards compatibility
    with earlier BIOS implementations. This eliminates the
    "Encountered executable code at module level" warning that
    was previously generated upon detection of such code.
    
    Fixed a problem in the interpreter where an AE_NOT_FOUND
    exception could inadvertently be generated during the
    lookup of namespace objects in the second pass parse of
    ACPI tables and control methods. It appears that this
    problem could occur during the resolution of forward
    references to namespace objects.
    
    Added the ACPI_MUTEX_DEBUG #ifdef to the
    acpi_ut_release_mutex function, corresponding to the same
    the deadlock detection debug code to be compiled out in
    the normal case, improving mutex performance (and overall
    subsystem performance) considerably.  As suggested by
    Alexey Starikovskiy.
    
    Implemented a handful of miscellaneous fixes for possible
    memory leaks on error conditions and error handling
    control paths. These fixes were suggested by FreeBSD and
    the Coverity Prevent source code analysis tool.
    
    Added a check for a null RSDT pointer in
    acpi_get_firmware_table (tbxfroot.c) to prevent a fault
    in this error case.
    
    Signed-off-by Len Brown <len.brown@intel.com>

commit 6f42ccf2fc50ecee8ea170040627f268430c1648
Author: Robert Moore <robert.moore@intel.com>
Date:   Fri May 13 00:00:00 2005 -0400

    ACPICA from Bob Moore <robert.moore@intel.com>
    
    Implemented support for PCI Express root bridges
    -- added support for device PNP0A08 in the root
    bridge search within AcpiEvPciConfigRegionSetup.
    acpi_ev_pci_config_region_setup().
    
    The interpreter now automatically truncates incoming
    64-bit constants to 32 bits if currently executing out
    of a 32-bit ACPI table (Revision < 2). This also affects
    the iASL compiler constant folding. (Note: as per below,
    the iASL compiler no longer allows 64-bit constants within
    32-bit tables.)
    
    Fixed a problem where string and buffer objects with
    "static" pointers (pointers to initialization data within
    an ACPI table) were not handled consistently. The internal
    object copy operation now always copies the data to a newly
    allocated buffer, regardless of whether the source object
    is static or not.
    
    Fixed a problem with the FromBCD operator where an
    implicit result conversion was improperly performed while
    storing the result to the target operand. Since this is an
    "explicit conversion" operator, the implicit conversion
    should never be performed on the output.
    
    Fixed a problem with the CopyObject operator where a copy
    to an existing named object did not always completely
    overwrite the existing object stored at name. Specifically,
    a buffer-to-buffer copy did not delete the existing buffer.
    
    Replaced "interrupt_level" with "interrupt_number" in all
    GPE interfaces and structs for consistency.
    
    Signed-off-by: Len Brown <len.brown@intel.com>



--134566789ABCDEFGHIJKLMNOPQRSTUVWXYYZabcd--
