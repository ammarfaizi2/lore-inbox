Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932943AbWFWIgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbWFWIgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWFWIgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:36:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:39030 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932938AbWFWIgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:36:07 -0400
X-IronPort-AV: i="4.06,168,1149490800"; 
   d="scan'208"; a="88180439:sNHT251169240"
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org, akpm@osdl.org
Subject: [GIT PATCH] ACPI for 2.6.18
Date: Fri, 23 Jun 2006 04:37:50 -0400
User-Agent: KMail/1.8.2
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606230437.50845.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.

All of these patches have been in mm, some for several months.

I plan to send additional ACPI patches  for 2.6.18, but no reason to hold
up this batch for them. 

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.17/acpi-release-20060608-2.6.17.diff.gz

 Documentation/kernel-parameters.txt               |    3 
 arch/i386/kernel/acpi/boot.c                      |    9 
 arch/i386/kernel/acpi/processor.c                 |    2 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |  289 +++-
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |  250 ++-
 arch/ia64/Kconfig                                 |    1 
 arch/ia64/hp/common/sba_iommu.c                   |    2 
 arch/ia64/kernel/acpi.c                           |    4 
 arch/ia64/mm/init.c                               |    2 
 arch/x86_64/Kconfig                               |    1 
 arch/x86_64/kernel/acpi/Makefile                  |    1 
 arch/x86_64/kernel/acpi/processor.c               |   74 -
 drivers/acpi/Kconfig                              |    3 
 drivers/acpi/acpi_memhotplug.c                    |   12 
 drivers/acpi/asus_acpi.c                          |   32 
 drivers/acpi/bus.c                                |   22 
 drivers/acpi/dispatcher/dsfield.c                 |   13 
 drivers/acpi/dispatcher/dsinit.c                  |    6 
 drivers/acpi/dispatcher/dsmethod.c                |  234 ++-
 drivers/acpi/dispatcher/dsmthdat.c                |   43 
 drivers/acpi/dispatcher/dsobject.c                |   25 
 drivers/acpi/dispatcher/dsopcode.c                |   63 
 drivers/acpi/dispatcher/dsutils.c                 |   25 
 drivers/acpi/dispatcher/dswexec.c                 |   26 
 drivers/acpi/dispatcher/dswload.c                 |   67 -
 drivers/acpi/dispatcher/dswscope.c                |   10 
 drivers/acpi/dispatcher/dswstate.c                |   72 -
 drivers/acpi/ec.c                                 |   72 -
 drivers/acpi/events/evevent.c                     |   10 
 drivers/acpi/events/evgpe.c                       |   87 -
 drivers/acpi/events/evgpeblk.c                    |   96 -
 drivers/acpi/events/evmisc.c                      |   49 
 drivers/acpi/events/evregion.c                    |  117 +
 drivers/acpi/events/evrgnini.c                    |   50 
 drivers/acpi/events/evsci.c                       |    8 
 drivers/acpi/events/evxface.c                     |   49 
 drivers/acpi/events/evxfevnt.c                    |   67 -
 drivers/acpi/events/evxfregn.c                    |   15 
 drivers/acpi/executer/exconfig.c                  |   54 
 drivers/acpi/executer/exconvrt.c                  |   12 
 drivers/acpi/executer/excreate.c                  |   25 
 drivers/acpi/executer/exdump.c                    |   36 
 drivers/acpi/executer/exfield.c                   |   18 
 drivers/acpi/executer/exfldio.c                   |   67 -
 drivers/acpi/executer/exmisc.c                    |   25 
 drivers/acpi/executer/exmutex.c                   |   15 
 drivers/acpi/executer/exnames.c                   |   28 
 drivers/acpi/executer/exoparg1.c                  |  101 +
 drivers/acpi/executer/exoparg2.c                  |   91 -
 drivers/acpi/executer/exoparg3.c                  |   17 
 drivers/acpi/executer/exoparg6.c                  |    3 
 drivers/acpi/executer/exprep.c                    |   57 
 drivers/acpi/executer/exregion.c                  |   40 
 drivers/acpi/executer/exresnte.c                  |   17 
 drivers/acpi/executer/exresolv.c                  |   77 -
 drivers/acpi/executer/exresop.c                   |   12 
 drivers/acpi/executer/exstore.c                   |   15 
 drivers/acpi/executer/exstoren.c                  |    7 
 drivers/acpi/executer/exstorob.c                  |   17 
 drivers/acpi/executer/exsystem.c                  |   12 
 drivers/acpi/executer/exutils.c                   |   17 
 drivers/acpi/fan.c                                |   40 
 drivers/acpi/hardware/hwacpi.c                    |    6 
 drivers/acpi/hardware/hwgpe.c                     |    8 
 drivers/acpi/hardware/hwregs.c                    |  146 --
 drivers/acpi/hardware/hwsleep.c                   |   31 
 drivers/acpi/hardware/hwtimer.c                   |   20 
 drivers/acpi/hotkey.c                             |    2 
 drivers/acpi/ibm_acpi.c                           |   70 +
 drivers/acpi/motherboard.c                        |   63 
 drivers/acpi/namespace/nsaccess.c                 |   46 
 drivers/acpi/namespace/nsalloc.c                  |  132 --
 drivers/acpi/namespace/nsdump.c                   |   15 
 drivers/acpi/namespace/nsdumpdv.c                 |    6 
 drivers/acpi/namespace/nseval.c                   |  500 +------
 drivers/acpi/namespace/nsinit.c                   |  334 +++--
 drivers/acpi/namespace/nsload.c                   |   27 
 drivers/acpi/namespace/nsnames.c                  |   14 
 drivers/acpi/namespace/nsobject.c                 |   15 
 drivers/acpi/namespace/nsparse.c                  |    6 
 drivers/acpi/namespace/nssearch.c                 |  152 +-
 drivers/acpi/namespace/nsutils.c                  |  108 -
 drivers/acpi/namespace/nswalk.c                   |    6 
 drivers/acpi/namespace/nsxfeval.c                 |  211 +--
 drivers/acpi/namespace/nsxfname.c                 |   22 
 drivers/acpi/namespace/nsxfobj.c                  |   11 
 drivers/acpi/osl.c                                |  159 +-
 drivers/acpi/parser/psargs.c                      |   25 
 drivers/acpi/parser/psloop.c                      |   25 
 drivers/acpi/parser/psopcode.c                    |    6 
 drivers/acpi/parser/psparse.c                     |   37 
 drivers/acpi/parser/psscope.c                     |   25 
 drivers/acpi/parser/pstree.c                      |    8 
 drivers/acpi/parser/psutils.c                     |    5 
 drivers/acpi/parser/pswalk.c                      |    5 
 drivers/acpi/parser/psxface.c                     |   46 
 drivers/acpi/pci_link.c                           |   25 
 drivers/acpi/processor_core.c                     |   14 
 drivers/acpi/processor_idle.c                     |    8 
 drivers/acpi/processor_perflib.c                  |  277 +++-
 drivers/acpi/resources/rscalc.c                   |  136 +-
 drivers/acpi/resources/rscreate.c                 |   35 
 drivers/acpi/resources/rsdump.c                   |   42 
 drivers/acpi/resources/rsinfo.c                   |    1 
 drivers/acpi/resources/rslist.c                   |  142 --
 drivers/acpi/resources/rsmisc.c                   |   16 
 drivers/acpi/resources/rsutils.c                  |  173 +-
 drivers/acpi/resources/rsxface.c                  |  417 +++---
 drivers/acpi/scan.c                               |  222 ++-
 drivers/acpi/sleep/main.c                         |    8 
 drivers/acpi/sleep/wakeup.c                       |    3 
 drivers/acpi/system.c                             |    6 
 drivers/acpi/tables.c                             |    4 
 drivers/acpi/tables/tbconvrt.c                    |   48 
 drivers/acpi/tables/tbget.c                       |   67 -
 drivers/acpi/tables/tbgetall.c                    |   11 
 drivers/acpi/tables/tbinstal.c                    |   50 
 drivers/acpi/tables/tbrsdt.c                      |   46 
 drivers/acpi/tables/tbutils.c                     |  151 +-
 drivers/acpi/tables/tbxface.c                     |   42 
 drivers/acpi/tables/tbxfroot.c                    |   82 -
 drivers/acpi/thermal.c                            |   25 
 drivers/acpi/utilities/utalloc.c                  |  652 +---------
 drivers/acpi/utilities/utcache.c                  |   18 
 drivers/acpi/utilities/utcopy.c                   |   41 
 drivers/acpi/utilities/utdebug.c                  |   65 
 drivers/acpi/utilities/utdelete.c                 |   62 
 drivers/acpi/utilities/uteval.c                   |  141 +-
 drivers/acpi/utilities/utglobal.c                 |   68 -
 drivers/acpi/utilities/utinit.c                   |   26 
 drivers/acpi/utilities/utmath.c                   |    8 
 drivers/acpi/utilities/utmisc.c                   |  295 ++--
 drivers/acpi/utilities/utmutex.c                  |   42 
 drivers/acpi/utilities/utobject.c                 |   23 
 drivers/acpi/utilities/utresrc.c                  |  266 ++--
 drivers/acpi/utilities/utstate.c                  |   36 
 drivers/acpi/utilities/utxface.c                  |   44 
 drivers/acpi/utils.c                              |    2 
 drivers/acpi/video.c                              |   23 
 drivers/char/agp/hp-agp.c                         |    2 
 drivers/char/hpet.c                               |    5 
 drivers/char/sonypi.c                             |   10 
 drivers/pnp/pnpacpi/rsparser.c                    |  199 +--
 include/acpi/acconfig.h                           |   44 
 include/acpi/acdisasm.h                           |  185 ++
 include/acpi/acdispat.h                           |    6 
 include/acpi/acevents.h                           |    4 
 include/acpi/acexcep.h                            |    6 
 include/acpi/acglobal.h                           |   29 
 include/acpi/aclocal.h                            |  308 ++--
 include/acpi/acmacros.h                           |   95 -
 include/acpi/acnamesp.h                           |   28 
 include/acpi/acobject.h                           |  188 +-
 include/acpi/acopcode.h                           |    2 
 include/acpi/acoutput.h                           |   10 
 include/acpi/acparser.h                           |   18 
 include/acpi/acpi_bus.h                           |   10 
 include/acpi/acpiosxf.h                           |   41 
 include/acpi/acpixf.h                             |    4 
 include/acpi/acresrc.h                            |   20 
 include/acpi/acstruct.h                           |  131 +-
 include/acpi/actables.h                           |    6 
 include/acpi/actbl.h                              |  406 +++---
 include/acpi/actbl1.h                             |  639 ++++++++-
 include/acpi/actbl2.h                             |  230 ---
 include/acpi/actypes.h                            |   90 -
 include/acpi/acutils.h                            |   99 -
 include/acpi/amlcode.h                            |    6 
 include/acpi/amlresrc.h                           |  111 -
 include/acpi/pdc_intel.h                          |    5 
 include/acpi/platform/acenv.h                     |   47 
 include/acpi/platform/aclinux.h                   |   23 
 include/acpi/processor.h                          |   27 
 include/asm-i386/apicdef.h                        |    1 
 include/asm-x86_64/acpi.h                         |    2 
 include/asm-x86_64/apicdef.h                      |    2 
 include/linux/cpufreq.h                           |    4 
 177 files changed, 6617 insertions(+), 5295 deletions(-)

through these commits:

Adrian Bunk:
      [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
      ACPI: Kconfig: ACPI should depend on, not select PCI

Alexey Starikovskiy:
      ACPI: execute Notify() handlers on new thread

Andi Kleen:
      [ACPI] fix "nolapic" flag in ACPI mode

Andreas Mohr:
      ACPI: apply "__read_mostly" to processor_idle.c loop module parameters 
and friends

Andrew Morton:
      ACPI: UP build fix for bugzilla-5737
      ACPI: asus_acpi_init(): propagate correct return value

Arjan van de Ven:
      sem2mutex: drivers/acpi/processor_perflib.c

Arnaud Patard:
      ACPI: suppress power button event on S3 resume

Ashok Raj:
      ACPI: build fix for u8 cpu_index
      ACPI: Allow hot-add of ejected processor
      x86_64: Remove stale lapic definition from apicdef.h

Bjorn Helgaas:
      PNPACPI: fix non-memory address space descriptor handling
      PNPACPI: remove some code duplication
      PNPACPI: whitespace cleanup
      ACPI: request correct fixed hardware resource type (MMIO vs I/O port)
      ACPI: Display "ACPI" to motherboard resources in /proc/io{mem,port}
      ACPI: make acpi_bus_register_driver() return success/failure, not device 
count
      ACPI: update asus_acpi driver registration to unload on failure
      ACPI: fix sonypi ACPI driver registration to unregister on failure
      ACPI: simplify scan.c coding
      ACPI: fix memory hotplug range length handling
      HPET: fix ACPI memory range length handling
      ACPI: remove __init/__exit from Asus .add()/.remove() methods
      ACPI: Don't print internal BIOS names of wakeup devices
      ACPI: acpi_bus_unregister_driver() returns void

Bob Moore:
      [ACPI] ACPICA 20060210
      ACPI: ACPICA 20060217
      ACPI: ACPICA 20060310
      [ACPI] ACPICA 20060317
      ACPI: ACPICA 20060331
      ACPI: ACPICA 20060421
      ACPI: ACPICA 20060512
      ACPI: ACPICA 20060526
      ACPI: ACPICA 20060608

Dave Jones:
      [ACPI] fix possible acpi thermal leak in failure path

David Shaohua Li:
      [ACPI] enable SMP C-states on x86_64

Ingo Molnar:
      sem2mutex: acpi, acpi_link_lock

Irwan Djajadi:
      [ACPI] drivers/acpi/hotkey.c: check kmalloc return value

Jeremy Fitzhardinge:
      ACPI: Allow a WAN module enable/disable on a Thinkpad X60.

Jiri Slaby:
      ACPI: EC acpi-ecdt-uid-hack

KAMEZAWA Hiroyuki:
      ACPI: use for_each_possible_cpu() instead of for_each_cpu()
      ACPI add ia64 exports to build acpi_memhotplug as a module

Konstantin Karasyov:
      ACPI: create acpi_fan_suspend()/acpi_fan_resume()
      ACPI: create acpi_thermal_resume()

Len Brown:
      ACPI: enable BIOS warning
      [ACPI] document cmdline acpi_os_name=
      Revert "ACPI: fix vendor resource length computation"
      ACPI: inline trivial acpi_os_get_thread_id()
      ACPI: ia64 buildfix
      ACPI: ia64 buildfix
      ACPI: delete newly added debugging macros in processor_perflib.c
      ACPI: silence ia64 build warning
      ACPI: delete unused acpi_bus_drivers_lock
      ACPI: pass pm_message_t from acpi_device_suspend() to root_suspend()
      ACPI: resolve merge conflict between sem2mutex and processor_perflib.c

Patrick Mochel:
      ACPI: create acpi_device_suspend()/acpi_device_resume()

Rich Townsend:
      ACPI: replace spin_lock_irq with mutex for ec poll mode

Vasily Averin:
      ACPI: fix potential memory leak in acpi_evaluate_integer() error path
      ACPI: fix memory leak in acpi_thermal_add() error path

Venkatesh Pallipadi:
      P-state software coordination for ACPI core
      P-state software coordination for acpi-cpufreq
      P-state software coordination for speedstep-centrino
      Enable P-state software coordination via _PDC

Yu, Luming:
      ACPI: fix potential memory leaks in driver/acpi/video.c

with this log:

commit ae6c859b7dcd708efadf1c76279c33db213e3506
Merge: 5b4b7a2... 427abfa...
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jun 19 18:01:24 2006 -0400

    merge linus into release branch

commit 5b4b7a236e7787f16af4e15a6253d46d8e794be6
Merge: 785fccc... 872d83d...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 23:17:14 2006 -0400

    Pull button into release branch

commit 872d83d00f67021e036d75aab3b7c6e3fc7e29ee
Author: Arnaud Patard <apatard@mandriva.com>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: suppress power button event on S3 resume
    
    http://bugzilla.kernel.org/show_bug.cgi?id=6612
    
    Note that this fix depends on a fix in ACPICA 20060608
    to replace a semaphore with a spin-lock.
    
    Signed-off-by: Arnaud Patard <apatard@mandriva.com>
    Acked-by: "Yu, Luming" <luming.yu@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 785fcccd68bd4dc436f75fd4cd40e8557966c86d
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 22:19:31 2006 -0400

    ACPI: resolve merge conflict between sem2mutex and processor_perflib.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d42510a0f58c2583c37c8e9b7548e3a68545863a
Merge: 8f2ddb3... 193de0c...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:39:25 2006 -0400

    Pull bugzilla-5737 into release branch
    
    Conflicts:
    
    	arch/x86_64/kernel/acpi/processor.c

commit 8f2ddb37e564a9616c05fa0d5652e0049072a730
Merge: 5b542e4... 74ce146...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:36:11 2006 -0400

    Pull bugzilla-5000 into release branch

commit 5b542e4422766d644ca303b8a47b27ec9eeeef3a
Merge: e4151ea... f9a6ee1...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:34:21 2006 -0400

    Pull bugzilla-5764 into release branch

commit e4151eaa7f231296d027b8fb34e2b855a3480836
Merge: c080a3e... 42adb53...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:33:36 2006 -0400

    Pull ibm_acpi into release branch

commit c080a3e69dfb58ae9b8c7e70a1e33f4f4e493ea7
Merge: bf891bd... 36e4309...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:31:47 2006 -0400

    Pull sem2mutex into release branch

commit bf891bd65de65284f3964216fcde493dba5149db
Merge: de59e3a... 9c576ff...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:31:17 2006 -0400

    Pull trivial2 into release branch

commit de59e3aa6eda7fc7cd6c717f084930f6a841b602
Merge: 69cd291... 973bf49...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:30:59 2006 -0400

    Pull video into release branch

commit 69cd291c6bbc6647fe3783257c5a2e076e808f71
Merge: 35a5d9e... 06ea8e0...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 21:28:57 2006 -0400

    Pull acpi_bus_register_driver into release branch
    
    Conflicts:
    
    	drivers/acpi/asus_acpi.c
    	drivers/acpi/scan.c

commit 35a5d9ed9fedb74c22cb19ff7d749289473144e0
Merge: 3e8e7c9... 0eacee5...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:42:14 2006 -0400

    Pull bugzilla-5452 into release branch

commit 3e8e7c93d7eb091463839b5212789c4aae09459e
Merge: 36a557d... ffd642e...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:41:53 2006 -0400

    Pull bugzilla-5653 into release branch

commit 36a557d1f48669c57f59e37d9334400a29e4e53c
Merge: 4e8f10b... 6665bda...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:40:39 2006 -0400

    Pull trivial into release branch

commit 4e8f10b7ccf1c3c53a818a157962074a7340732e
Merge: 6351847... 9cfda2c...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:38:30 2006 -0400

    Pull novell-bugzilla-156426 into release branch
    
    Conflicts:
    
    	arch/i386/kernel/acpi/boot.c

commit 63518472c05a351d779f35803e6ccfb361ae630a
Merge: e44e20f... e6f1f3c...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:37:09 2006 -0400

    Pull trivial1 into release branch

commit e44e20ff1273cf96c7f195297208f654c49295cf
Merge: 3145012... 1c6e7d0...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:36:43 2006 -0400

    Pull pnpacpi into release branch

commit 3145012c1c34a3504a2234bd2034ca6ea4767bc5
Merge: 1465887... cd090ee...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:36:16 2006 -0400

    Pull motherboard into release branch

commit 1465887cfe79889273e3fd3aaf862e7ec3ee244f
Merge: 60e04a5... 1300124...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:35:57 2006 -0400

    Pull Kconfig into release branch

commit 60e04a5c533785c23ce6b76a6e5058328fe68edb
Merge: 61fb46c... ff2fc3e...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:35:37 2006 -0400

    Pull ec into release branch

commit 61fb46c5b3578fda7cc780e8bc53b3e8f8c1a143
Merge: 59f720e... eefa27a...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:35:15 2006 -0400

    Pull cpu-hotplug into release branch

commit 59f720eb5a4337b2c4fc0b4c6cfd9c144e492aa8
Merge: b3899c6... 9224a86...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:34:42 2006 -0400

    Pull address_range into release branch

commit b3899c6613160b18f79e4356184de55311302fe4
Merge: 553698f... 4c90ece...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 15 15:19:48 2006 -0400

    Pull acpica into release branch

commit 4c90ece249992c7a2e3fc921e5cdb8eb92193067
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Jun 8 16:29:00 2006 -0400

    ACPI: ACPICA 20060608
    
    Converted the locking mutex used for the ACPI hardware
    to a spinlock. This change should eliminate all problems
    caused by attempting to acquire a semaphore at interrupt
    level, and it means that all ACPICA external interfaces
    that directly access the ACPI hardware can be safely
    called from interrupt level.
    
    Fixed a regression introduced in 20060526 where the ACPI
    device initialization could be prematurely aborted with
    an AE_NOT_FOUND if a device did not have an optional
    _INI method.
    
    Fixed an IndexField issue where a write to the Data
    Register should be limited in size to the AccessSize
    (width) of the IndexField itself. (BZ 433, Fiodor Suietov)
    
    Fixed problem reports (Valery Podrezov) integrated: - Allow
    store of ThermalZone objects to Debug object.
    http://bugzilla.kernel.org/show_bug.cgi?id=5369
    http://bugzilla.kernel.org/show_bug.cgi?id=5370
    
    Fixed problem reports (Fiodor Suietov) integrated: -
    acpi_get_table_header() doesn't handle multiple instances
    correctly (BZ 364)
    
    Removed four global mutexes that were obsolete and were
    no longer being used.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4119532c95547821dbe72d6916dfa1b2148475b3
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri May 26 16:36:00 2006 -0400

    ACPI: ACPICA 20060526
    
    Restructured, flattened, and simplified the internal
    interfaces for namespace object evaluation - resulting
    in smaller code, less CPU stack use, and fewer
    interfaces. (With assistance from Mikhail Kouzmich)
    
    Fixed a problem with the CopyObject operator where the
    first parameter was not typed correctly for the parser,
    interpreter, compiler, and disassembler. Caused various
    errors and unexpected behavior.
    
    Fixed a problem where a ShiftLeft or ShiftRight of
    more than 64 bits produced incorrect results with some
    C compilers. Since the behavior of C compilers when
    the shift value is larger than the datatype width is
    apparently not well defined, the interpreter now detects
    this condition and simply returns zero as expected in all
    such cases. (BZ 395)
    
    Fixed problem reports (Valery Podrezov) integrated: -
    Update String-to-Integer conversion to match ACPI 3.0A spec
    http://bugzilla.kernel.org/show_bug.cgi?id=5329
    Allow interpreter to handle nested method declarations
    http://bugzilla.kernel.org/show_bug.cgi?id=5361
    
    Fixed problem reports (Fiodor Suietov) integrated: -
    acpi_terminate() doesn't free debug memory allocation
    list objects (BZ 355) - After Core Subsystem
    shutdown, acpi_subsystem_status() returns AE_OK (BZ 356) -
    acpi_os_unmap_memory() for RSDP can be invoked inconsistently
    (BZ 357) - Resource Manager should return AE_TYPE for
    non-device objects (BZ 358) - Incomplete cleanup branch
    in AcpiNsEvaluateRelative (BZ 359) - Use acpi_os_free()
    instead of ACPI_FREE in acpi_rs_set_srs_method_data (BZ 360)
    - Incomplete cleanup branch in acpi_ps_parse_aml (BZ 361) -
    Incomplete cleanup branch in acpi_ds_delete_walk_state (BZ 362)
    - acpi_get_table_header returns AE_NO_ACPI_TABLES until DSDT
    is loaded (BZ 365) - Status of the Global Initialization
    Handler call not used (BZ 366) - Incorrect object parameter
    to Global Initialization Handler (BZ 367)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b8d35192c55fb055792ff0641408eaaec7c88988
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Fri May 5 03:23:00 2006 -0400

    ACPI: execute Notify() handlers on new thread
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5534
    
    Thanks to Peter Wainwright for isolating the issue.
    Thanks to Andi Kleen and Bob Moore for feedback.
    Thanks to Richard Mace and others for testing.
    Updates by Konstantin Karasyov.
    
    Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 958dd242b691f64ab4632b4903dbb1e16fee8269
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri May 12 17:12:00 2006 -0400

    ACPI: ACPICA 20060512
    
    Replaced the acpi_os_queue_for_execution() with a new
    interface named acpi_os_execute(). The major difference is
    that the new interface does not have a Priority parameter,
    this appeared to be useless and has been replaced by
    a Type parameter. The Type tells the OS what type of
    execution is being requested, such as global lock handler,
    notify handler, GPE handler, etc. This allows the host
    to queue and execute the request as appropriate for the
    request type, possibly using different work queues and
    different priorities for the various request types. This
    enables fixes for multithreading deadlock problems such as
    http://bugzilla.kernel.org/show_bug.cgi?id=5534
    (Alexey Starikovskiy and Bob Moore)
    
    Fixed a possible memory leak associated with the
    support for the so-called "implicit return" ACPI
    extension. Reported by FreeBSD  (Fiodor Suietov)
    http://bugzilla.kernel.org/show_bug.cgi?id=6514
    
    Fixed a problem with the Load() operator where a table
    load from an operation region could overwrite an internal
    table buffer by up to 7 bytes and cause alignment faults
    on IPF systems. (With assistance from Luming Yu)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b229cf92eee616c7cb5ad8cdb35a19b119f00bc8
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Apr 21 17:15:00 2006 -0400

    ACPI: ACPICA 20060421
    
    Removed a device initialization optimization introduced in
    20051216 where the _STA method was not run unless an _INI
    was also present for the same device. This optimization
    could cause problems because it could allow _INI methods
    to be run within a not-present device subtree (If a
    not-present device had no _INI, _STA would not be run,
    the not-present status would not be discovered, and the
    children of the device would be incorrectly traversed.)
    
    Implemented a new _STA optimization where namespace
    subtrees that do not contain _INI are identified and
    ignored during device initialization. Selectively running
    _STA can significantly improve boot time on large machines
    (with assistance from Len Brown.)
    
    Implemented support for the device initialization case
    where the returned _STA flags indicate a device not-present
    but functioning. In this case, _INI is not run, but the
    device children are examined for presence, as per the
    ACPI specification.
    
    Implemented an additional change to the IndexField support
    in order to conform to MS behavior. The value written to
    the Index Register is not simply a byte offset, it is a
    byte offset in units of the access width of the parent
    Index Field. (Fiodor Suietov)
    
    Defined and deployed a new OSL interface,
    acpi_os_validate_address().  This interface is called during
    the creation of all AML operation regions, and allows
    the host OS to exert control over what addresses it will
    allow the AML code to access. Operation Regions whose
    addresses are disallowed will cause a runtime exception
    when they are actually accessed (will not affect or abort
    table loading.)
    
    Defined and deployed a new OSL interface,
    acpi_os_validate_interface().  This interface allows the host OS
    to match the various "optional" interface/behavior strings
    for the _OSI predefined control method as appropriate
    (with assistance from Bjorn Helgaas.)
    
    Restructured and corrected various problems in the
    exception handling code paths within DsCallControlMethod
    and DsTerminateControlMethod in dsmethod (with assistance
    from Takayoshi Kochi.)
    
    Modified the Linux source converter to ignore quoted string
    literals while converting identifiers from mixed to lower
    case. This will correct problems with the disassembler
    and other areas where such strings must not be modified.
    
    The ACPI_FUNCTION_* macros no longer require quotes around
    the function name. This allows the Linux source converter
    to convert the names, now that the converter ignores
    quoted strings.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 793c2388cae3fd023b3b5166354931752d42353c
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Mar 31 00:00:00 2006 -0500

    ACPI: ACPICA 20060331
    
    Implemented header file support for the following
    additional ACPI tables: ASF!, BOOT, CPEP, DBGP, MCFG, SPCR,
    SPMI, TCPA, and WDRT. With this support, all current and
    known ACPI tables are now defined in the ACPICA headers and
    are available for use by device drivers and other software.
    
    Implemented support to allow tables that contain ACPI
    names with invalid characters to be loaded. Previously,
    this would cause the table load to fail, but since
    there are several known cases of such tables on
    existing machines, this change was made to enable
    ACPI support for them. Also, this matches the
    behavior of the Microsoft ACPI implementation.
    https://bugzilla.novell.com/show_bug.cgi?id=147621
    
    Fixed a couple regressions introduced during the memory
    optimization in the 20060317 release. The namespace
    node definition required additional reorganization and
    an internal datatype that had been changed to 8-bit was
    restored to 32-bit. (Valery Podrezov)
    
    Fixed a problem where a null pointer passed to
    acpi_ut_delete_generic_state() could be passed through
    to acpi_os_release_object which is unexpected. Such
    null pointers are now trapped and ignored, matching
    the behavior of the previous implementation before the
    deployment of acpi_os_release_object().  (Valery Podrezov,
    Fiodor Suietov)
    
    Fixed a memory mapping leak during the deletion of
    a SystemMemory operation region where a cached memory
    mapping was not deleted. This became a noticeable problem
    for operation regions that are defined within frequently
    used control methods. (Dana Meyers)
    
    Reorganized the ACPI table header files into two main
    files: one for the ACPI tables consumed by the ACPICA core,
    and another for the miscellaneous ACPI tables that are
    consumed by the drivers and other software. The various
    FADT definitions were merged into one common section and
    three different tables (ACPI 1.0, 1.0+, and 2.0)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 61686124f47d7c4b78610346c5f8f9d8a6d46bb5
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Mar 17 16:44:00 2006 -0500

    [ACPI] ACPICA 20060317
    
    Implemented the use of a cache object for all internal
    namespace nodes. Since there are about 1000 static nodes
    in a typical system, this will decrease memory use for
    cache implementations that minimize per-allocation overhead
    (such as a slab allocator.)
    
    Removed the reference count mechanism for internal
    namespace nodes, since it was deemed unnecessary. This
    reduces the size of each namespace node by about 5%-10%
    on all platforms. Nodes are now 20 bytes for the 32-bit
    case, and 32 bytes for the 64-bit case.
    
    Optimized several internal data structures to reduce
    object size on 64-bit platforms by packing data within
    the 64-bit alignment. This includes the frequently used
    ACPI_OPERAND_OBJECT, of which there can be ~1000 static
    instances corresponding to the namespace objects.
    
    Added two new strings for the predefined _OSI method:
    "Windows 2001.1 SP1" and "Windows 2006".
    
    Split the allocation tracking mechanism out to a separate
    file, from utalloc.c to uttrack.c. This mechanism appears
    to be only useful for application-level code. Kernels may
    wish to not include uttrack.c in distributions.
    
    Removed all remnants of the obsolete ACPI_REPORT_* macros
    and the associated code. (These macros have been replaced
    by the ACPI_ERROR and ACPI_WARNING macros.)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 42adb53cb36d19862a02d3087e2e3d9dab39e5fa
Author: Jeremy Fitzhardinge <jeremy@goop.org>
Date:   Thu Jun 1 17:41:00 2006 -0400

    ACPI: Allow a WAN module enable/disable on a Thinkpad X60.
    
    The WAN (Sierra Wireless EV-DO) module is very similar to the
    Bluetooth module.  It appears on the USB bus when enabled.  It can be
    controlled via hot key, or directly via ACPI.  This change enables
    direct control via ACPI.
    
    I have tested it on my Lenovo Thinkpad X60; I guess it will probably
    work on other Thinkpad models which come with this module installed.
    
    Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
    Ack'd by: Borislav Deianov <borislav@users.sf.net>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f9a6ee1afb84fd767508428ec5d1df4fb60a03ad
Author: Rich Townsend <rhdt@bartol.udel.edu>
Date:   Mon Dec 19 23:07:00 2005 -0500

    ACPI: replace spin_lock_irq with mutex for ec poll mode
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5764
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 74ce1468128e299fe6a85e7e78e528e45e72d6d9
Author: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Date:   Mon May 8 08:32:00 2006 -0400

    ACPI: create acpi_thermal_resume()
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4364
    
    Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0feabb01d93e5801d1127416a66cfc3963280bca
Author: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Date:   Mon May 8 00:00:00 2006 -0400

    ACPI: create acpi_fan_suspend()/acpi_fan_resume()
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5000
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 531881d665ca011326bb466b97b07c95dee8d0a1
Author: Len Brown <len.brown@intel.com>
Date:   Mon May 15 03:06:41 2006 -0400

    ACPI: pass pm_message_t from acpi_device_suspend() to root_suspend()
    in case we want to decode it for future use in acpi_op_suspend(..., state)
    
    also, inline new 1-liner static function
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5000
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5b3272655a8e8a9a6e2503bc5a88fc9d9c8292a4
Author: Patrick Mochel <patrick.mochel@intel.com>
Date:   Wed May 10 10:33:00 2006 -0400

    ACPI: create acpi_device_suspend()/acpi_device_resume()
    
    updated and tested by Konstantin Karasyov
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5000
    
    Signed-off-by: Patrick Mochel <patrick.mochel@intel.com>
    Signed-off-by: Konstantin Karasyov <konstantin.karasyov @intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9c576ff1bc9ab42d06457e68e39c121481138562
Author: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI add ia64 exports to build acpi_memhotplug as a module
    
    Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 973bf491a55b825740f0d8d300b50bcd3d6fb8de
Author: Yu, Luming <luming.yu@intel.com>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: fix potential memory leaks in driver/acpi/video.c
    
    acpi_video_bus_get_one_device() and other functions in driver/acpi/video.c 
do
    not release allocated memory on remove and on the error path.
    
    Signed-off-by: "Yu, Luming" <luming.yu@intel.com>
    Signed-off-by: Vasily Averin <vvs@sw.ru>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ebd5f2ca811b75f7145fa487748f26430c584a72
Author: Andrew Morton <akpm@osdl.org>
Date:   Sat May 13 22:56:00 2006 -0400

    ACPI: asus_acpi_init(): propagate correct return value
    
    Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Acked-by: Francois Romieu <romieu@fr.zoreil.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b6835052a6aa00536343b6d2127fc65cd814a040
Author: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: apply "__read_mostly" to processor_idle.c loop module parameters and 
friends
    
    make pm_idle_save, nocst and bm_history __read_mostly
    remove initializer from static 'first_run'.
    
    Signed-off-by: Andreas Mohr <andi@lisas.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 09047e75f69428dcfa977b326256085154068b65
Author: Vasily Averin <vvs@sw.ru>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: fix memory leak in acpi_thermal_add() error path
    
    Signed-off-by: Vasily Averin <vvs@sw.ru>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 64385f2fd8bc9d8803c8d10dcd391871cb126b77
Author: Vasily Averin <vvs@sw.ru>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: fix potential memory leak in acpi_evaluate_integer() error path
    
    Signed-off-by: Vasily Averin <vvs@sw.ru>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 06ea8e08ae7e7e450b6a78e7ce5e10b3c5f954ea
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: acpi_bus_unregister_driver() returns void
    
    Nobody looks at the return value, and this brings it into line with
    pci_unregister_driver(), etc.  Also removed validation of the driver
    pointer passed in to register and unregister.  More consistent, and we'll
    find bugs faster if we fault rather than returning an error that's 
ignored.
    
    Also makes internal functions acpi_device_unregister() and
    acpi_driver_detach() void, since nobody uses their returns either.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 193de0c79da580eb33a66113b62e2378fc1fb629
Author: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: use for_each_possible_cpu() instead of for_each_cpu()
    
    for_each_cpu() actually iterates across all possible CPUs.  We've had 
mistakes
    in the past where people were using for_each_cpu() where they should have 
been
    iterating across only online or present CPUs.  This is inefficient and
    possibly buggy.
    
    We're renaming for_each_cpu() to for_each_possible_cpu() to avoid this in 
the
    future.
    
    Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 36e430951af0b0d1bdfd50ce22e70079d02646df
Author: Ingo Molnar <mingo@elte.hu>
Date:   Thu Apr 27 05:25:00 2006 -0400

    sem2mutex: acpi, acpi_link_lock
    
    Semaphore to mutex conversion.
    
    The conversion was generated via scripts, and the result was validated
    automatically via a script as well.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 415d320a2384bb80d2be98b1dfa41594e085012d
Author: Len Brown <len.brown@intel.com>
Date:   Sat May 13 21:35:56 2006 -0400

    ACPI: delete unused acpi_bus_drivers_lock
    
    acpi_bus_drivers is protected by acpi_device_lock
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 65c19bbd28cba587d9bd24feccf7272da18481a7
Author: Arjan van de Ven <arjan@infradead.org>
Date:   Thu Apr 27 05:25:00 2006 -0400

    sem2mutex: drivers/acpi/processor_perflib.c
    
    Semaphore to mutex conversion.
    
    The conversion was generated via scripts, and the result was validated
    automatically via a script as well.
    
    Signed-off-by: Arjan van de Ven <arjan@infradead.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5810452d00ae5fed7f720185d02d79ec9d15b91e
Author: Len Brown <len.brown@intel.com>
Date:   Sat May 13 01:12:15 2006 -0400

    ACPI: silence ia64 build warning
    
    When building sim_defconfig, which does not define CONFIG_ACPI
    arch/ia64/kernel/acpi.c:71: warning: 'acpi_madt_rev' defined but not used
    
    really acpi.c should not be built when CONFIG_ACPI=n...
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9011bff4bdc0fef1f9a782d7415c306ee61826c9
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 00:28:12 2006 -0400

    ACPI: delete newly added debugging macros in processor_perflib.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e6f1f3c54974a30c65ea0b699809d12f0aa04272
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Apr 3 13:14:00 2006 -0400

    ACPI: Don't print internal BIOS names of wakeup devices
    
    Internal BIOS names like these should be exposed
    to the user as little as possible:
    
    ACPI wakeup devices: C069 C0CE C1D1 C0DE C1D4
    
    Eventually, the "wakeup" property of a device should be exported via the
    device tree, not by a printk of an internal BIOS name.  For the hard-core,
    these are still available in /proc/acpi/wakeup_devices, just not
    printed to dmesg.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 144c87b4e03759214c362d267e01c2905f1ab095
Author: Len Brown <len.brown@intel.com>
Date:   Sun Apr 2 00:15:39 2006 -0500

    ACPI: ia64 buildfix
    
    arch/ia64/hp/common/sba_iommu.c used ACPI_MEM_FREE instead of kfree()
    
    Signed-off-by: Len Brown <len.brown@intel.com

commit 7f048801f4a6767433d1aeefd9c24372515265f8
Author: Len Brown <len.brown@intel.com>
Date:   Sat Apr 1 23:45:39 2006 -0500

    ACPI: ia64 buildfix
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c12ea918ee175ceb3a258cd81f1c43e897d0c0bc
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    x86_64: Remove stale lapic definition from apicdef.h
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Cc: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eefa27a93a0490902f33837ac86dbcf344b3aa29
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: Allow hot-add of ejected processor
    
    acpi_eject_store() didn't trim processors, causing subsequent
    hot-add to fail.
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Cc: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
Author: Jiri Slaby <jirislaby@gmail.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: EC acpi-ecdt-uid-hack
    
    On some boxes ecdt uid may be equal to 0, so do not test for uids 
equality,
    so that fake handler will be unconditionally removed to allow loading the
    real one.
    
    See http://bugzilla.kernel.org/show_bug.cgi?id=6111
    
    Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
    Cc: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit df42baa0d8e54df18dd9366dd7c93d6be7d5d063
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: build fix for u8 cpu_index
    
    Local apic entries are only 8 bits, but it seemed to not be caught with u8
    return value result in the check
    
    cpu_index >= NR_CPUS becomming always false.
    
    drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
    drivers/acpi/processor_core.c:483: warning: comparison is always false due 
to limited range of data type
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Cc: Dave Jones <davej@codemonkey.org.uk>
    Cc: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 200739c179c63d21804e9e8e2ced265243831579
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: remove __init/__exit from Asus .add()/.remove() methods
    
    Even though the devices claimed by asus_acpi.c can not be hot-plugged, the
    driver registration infrastructure allows the .add() and .remove() methods 
to
    be called at any time while the driver is registered.  So remove __init 
and
    __exit from them.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9224a867c497053842dc595e594ca6d32112221f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    HPET: fix ACPI memory range length handling
    
    ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and 
_MAX
    are the bounds within which the region can be moved (this is clarified in
    Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the 
size
    of the region, not _MAX - _MIN + 1.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 459c7266d7a5c1730169258217e25fdd1b7ca854
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: fix memory hotplug range length handling
    
    Address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX are
    the bounds within which the region can be moved (this is clarified in 
Table
    6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size of
    the region, not _MAX - _MIN + 1.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1a36561607abf1405b56a41aac2fd163429cd1f8
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: simplify scan.c coding
    
    No functional changes; just remove leftover, unused "buffer" and simplify
    control flow (no need to remember error values and goto the end, when we 
can
    simply return the value directly).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e4513a57ef719d3d6d1cee0ca4d9f4016aa452bb
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: fix sonypi ACPI driver registration to unregister on failure
    
    Remove the assumption that acpi_bus_register_driver() returns the number 
of
    devices claimed.  Returning the count is unreliable because devices may be
    hot-plugged in the future (admittedly not applicable for this driver).
    
    This also fixes a bug: if sonypi_acpi_driver was registered but found no
    devices, sonypi_exit() did not unregister it.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 578b333bfe8eb1360207a08a53c321822a8f40f3
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: update asus_acpi driver registration to unload on failure
    
    Remove the assumption that acpi_bus_register_driver() returns the number 
of
    devices claimed.  Returning the count is unreliable because devices may be
    hot-plugged in the future (admittedly not applicable for this driver).
    
    Since the hardware for this driver is not hot-pluggable, determine whether 
the
    hardware is present by noticing calls to the .add() method.  It would be
    better to probe the ACPI namespace for the ASUS HIDs, and load the driver 
only
    when we find one, but ACPI doesn't support that yet.
    
    I don't have an ASUS laptop to test on, but on my HP dl360, it does report 
the
    appropriate error when attempting to load the module:
    
        $ sudo insmod drivers/acpi/asus_acpi.ko
        insmod: error inserting 'drivers/acpi/asus_acpi.ko': -1 No such device
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9d9f749b316ac21cb59ad3e595cbce469b409e1a
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: make acpi_bus_register_driver() return success/failure, not device 
count
    
    acpi_bus_register_driver() should not return the number of devices 
claimed.
    We're not asking to find devices, we're making a driver available to 
devices,
    including hot-pluggable devices that may appear in the future.
    
    I audited all callers of acpi_bus_register_driver(), and except 
asus_acpi.c
    and sonypi.c (fixed in previous patches), all either ignore the return 
value
    or test only for failure (<0).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cd090eedd85256829f762677d0752a846c1b88b9
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: Display "ACPI" to motherboard resources in /proc/io{mem,port}
    
    Add "ACPI" to motherboard resource allocation names, so people have a clue
    about where to look.  And remove some trailing spaces.
    
    Changes these /proc/iomem entries from this:
    
        ff5c1004-ff5c1007 : PM_TMR
        ff5c1008-ff5c100b : PM1a_EVT_BLK
        ff5c100c-ff5c100d : PM1a_CNT_BLK
        ff5c1010-ff5c1013 : GPE0_BLK
        ff5c1014-ff5c1017 : GPE1_BLK
    
    to this:
    
        ff5c1004-ff5c1007 : ACPI PM_TMR
        ff5c1008-ff5c100b : ACPI PM1a_EVT_BLK
        ff5c100c-ff5c100d : ACPI PM1a_CNT_BLK
        ff5c1010-ff5c1013 : ACPI GPE0_BLK
        ff5c1014-ff5c1017 : ACPI GPE1_BLK
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 81507ea9cfa64e9851b53e0fefebfa776eda9ecb
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: request correct fixed hardware resource type (MMIO vs I/O port)
    
    ACPI supports fixed hardware (PM_TMR, GPE blocks, etc) in either I/O port
    or MMIO space, but used to always request the regions from I/O space
    because it didn't check the address_space_id.
    
    Sample ACPI fixed hardware in MMIO space (HP rx2600), was incorrectly
    reported in /proc/ioports, now reported in /proc/iomem:
    
        ff5c1004-ff5c1007 : PM_TMR
        ff5c1008-ff5c100b : PM1a_EVT_BLK
        ff5c100c-ff5c100d : PM1a_CNT_BLK
        ff5c1010-ff5c1013 : GPE0_BLK
        ff5c1014-ff5c1017 : GPE1_BLK
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1c6e7d0aeecac38e66b1bb63e3eff07b2a1c2f2c
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    PNPACPI: whitespace cleanup
    
    Tidy up whitespace.  No functional change.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b5f2490b6e3317059e87ba40d4f659d1c30afc1f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    PNPACPI: remove some code duplication
    
    Factor out the duplicated switch from pnpacpi_count_resources() and
    pnpacpi_type_resources().  Remove the unnecessary re-initialization of
    resource->type and length from all the encode functions (id and length are
    originally set in the pnpacpi_build_resource_template() ->
    pnpacpi_type_resources() path).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1acfb7f2b0d460ee86bdb25ad0679070ec8a5f0d
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:03:00 2006 -0500

    PNPACPI: fix non-memory address space descriptor handling
    
    Fix resource_type handling for QWORD, DWORD, and WORD Address Space
    Descriptors.  Previously we ignored the resource_type, so I/O ports and 
bus
    number ranges were incorrectly parsed as memory ranges.
    
    Sample PCI root bridge resources from HP rx2600 before this patch:
    
        # cat /sys/bus/pnp/devices/00:02/resources
        state = active
        mem 0x0-0x1f
        mem 0x0-0x3af
        mem 0x3e0-0x1fff
        mem 0x80000000-0x8fffffff
    
    With this patch:
    
        # cat /sys/bus/pnp/devices/00:02/resources
        state = active
        io 0x0-0x3af
        io 0x3e0-0x1fff
        mem 0x80000000-0x8fffffff
        mem 0x80004000000-0x80103fffffe
    
    Changes:
        0x0-0x1f PCI bus number range was incorrectly reported as memory, now
    	not reported at all
        0x0-0x3af I/O port range was incorrectly reported as memory
        0x3e0-0x1fff I/O port range was incorrectly reported as memory
        0x80004000000-0x80103fffffe memory range wasn't reported at all 
because
    	we only support PNP_MAX_MEM (4) memory resources
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7e1f19e50371e1d148226b64c8edc77fec47fa5b
Author: Andrew Morton <akpm@osdl.org>
Date:   Tue Mar 28 17:03:00 2006 -0500

    ACPI: UP build fix for bugzilla-5737
    
    cpu_online_map doesn't exist if !CONFIG_SMP.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1300124f69cafc54331bc06e968a8dd67863f989
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: Kconfig: ACPI should depend on, not select PCI
    
    Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are
    possible.
    
    This patch also fixes the options select'ing ACPI to also select PCI.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ec7381d6bfd3e7b8d2880dd5e9d03b131b0603f6
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:12:23 2006 -0500

    ACPI: inline trivial acpi_os_get_thread_id()
    
    acpi_os_get_thread_id() is used only for debugging
    code that is not enabled on Linux, so stub it out.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8313524a0d466f451a62709aaedf988d8257b21c
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Oct 3 00:00:00 2006 -0400

    ACPI: ACPICA 20060310
    
    Tagged all external interfaces to the subsystem with the
    new ACPI_EXPORT_SYMBOL macro. This macro can be defined
    as necessary to assist kernel integration. For Linux,
    the macro resolves to the EXPORT_SYMBOL macro. The default
    definition is NULL.
    
    Added the ACPI_THREAD_ID type for the return value from
    acpi_os_get_thread_id(). This allows the host to define this
    as necessary to simplify kernel integration. The default
    definition is ACPI_NATIVE_UINT.
    
    Valery Podrezov fixed two interpreter problems related
    to error processing, the deletion of objects, and placing
    invalid pointers onto the internal operator result stack.
    http://bugzilla.kernel.org/show_bug.cgi?id=6028
    http://bugzilla.kernel.org/show_bug.cgi?id=6151
    
    Increased the reference count threshold where a warning is
    emitted for large reference counts in order to eliminate
    unnecessary warnings on systems with large namespaces
    (especially 64-bit.) Increased the value from 0x400
    to 0x800.
    
    Due to universal disagreement as to the meaning of the
    'c' in the calloc() function, the ACPI_MEM_CALLOCATE
    macro has been renamed to ACPI_ALLOCATE_ZEROED so that the
    purpose of the interface is 'clear'. ACPI_MEM_ALLOCATE and
    ACPI_MEM_FREE are renamed to ACPI_ALLOCATE and ACPI_FREE.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ea936b78f46cbe089a4ac363e1682dee7d427096
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Feb 17 00:00:00 2006 -0500

    ACPI: ACPICA 20060217
    
    Implemented a change to the IndexField support to match
    the behavior of the Microsoft AML interpreter. The value
    written to the Index register is now a byte offset,
    no longer an index based upon the width of the Data
    register. This should fix IndexField problems seen on
    some machines where the Data register is not exactly one
    byte wide. The ACPI specification will be clarified on
    this point.
    
    Fixed a problem where several resource descriptor
    types could overrun the internal descriptor buffer due
    to size miscalculation: VendorShort, VendorLong, and
    Interrupt. This was noticed on IA64 machines, but could
    affect all platforms.
    
    Fixed a problem where individual resource descriptors were
    misaligned within the internal buffer, causing alignment
    faults on IA64 platforms.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 52fc0b026e99b5d5d585095148d997d5634bbc25
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Oct 2 00:00:00 2006 -0400

    [ACPI] ACPICA 20060210
    
    Removed a couple of extraneous ACPI_ERROR messages that
    appeared during normal execution. These became apparent
    after the conversion from ACPI_DEBUG_PRINT.
    
    Fixed a problem where the CreateField operator could hang
    if the BitIndex or NumBits parameter referred to a named
    object. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5359
    
    Fixed a problem where a DeRefOf operation on a buffer
    object incorrectly failed with an exception. This also
    fixes a couple of related RefOf and DeRefOf issues.
    From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5360
    http://bugzilla.kernel.org/show_bug.cgi?id=5387
    http://bugzilla.kernel.org/show_bug.cgi?id=5392
    
    Fixed a problem where the AE_BUFFER_LIMIT exception was
    returned instead of AE_STRING_LIMIT on an out-of-bounds
    Index() operation. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5480
    
    Implemented a memory cleanup at the end of the execution
    of each iteration of an AML While() loop, preventing the
    accumulation of outstanding objects. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5427
    
    Eliminated a chunk of duplicate code in the object
    resolution code. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5336
    
    Fixed several warnings during the 64-bit code generation.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 46358614ed5b031797522f1020e989c959a8d8a6
Author: Len Brown <lenb@toshiba.site>
Date:   Fri Mar 31 02:16:19 2006 -0500

    Revert "[PATCH] ACPI: fix vendor resource length computation"
    
    fixed in a different way by a subsequent ACPICA patch
    
    This reverts 35b73ceb9a7d10c81bd9e79e8485f7079ef2b40e commit.

commit 6665bda76461308868bd1e52caf627f4cb29ed32
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Mar 11 10:12:00 2006 -0500

    [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
    
    The Coverity checker spotted this bug in
    acpi_video_device_lcd_query_levels().
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fdc136ccd3332938e989439c025c363f8479f3e6
Author: Dave Jones <davej@redhat.com>
Date:   Wed Mar 8 22:12:00 2006 -0500

    [ACPI] fix possible acpi thermal leak in failure path
    
    Coverity: #601
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a1f9e65e2085e0a87f28a4d5a8ae43b32c087f24
Author: Len Brown <len.brown@intel.com>
Date:   Wed Jan 25 23:47:36 2006 -0500

    [ACPI] document cmdline acpi_os_name=
    
    This can sometimes be used to work around broken BIOS.
    Use "Microsoft Windows" to take the same path
    through the BIOS as Windows98 would.
    
    The default is "Microsoft Windows NT", which
    is what NT and later versions of Windows use,
    and is the most tested path through most BIOS.
    
    Set it to anything else, including "Linux", at your
    own risk, as it seems that virtually no BIOS
    has been tested with anything but the two options above.
    
    Note that this uses the legacy _OS interface, so
    we don't expect this to ever change.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1fee94034917aa711fcbd4ebf4c36f7ebd9fa7d6
Author: Irwan Djajadi <irwan.djajadi@iname.com>
Date:   Fri Jan 20 15:28:00 2006 -0500

    [ACPI] drivers/acpi/hotkey.c: check kmalloc return value
    
    Signed-off-by: Irwan Djajadi <irwan.djajadi@iname.com>
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0eacee585a89ce5827b572a73a024931506bef48
Author: Len Brown <lenb@toshiba.site>
Date:   Fri Mar 31 00:37:23 2006 -0500

    ACPI: enable BIOS warning
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5452
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9cfda2c94df61c9f859b474abe774c65a4464d0a
Author: Andi Kleen <ak@suse.de>
Date:   Mon Mar 27 02:24:32 2006 -0500

    [ACPI] fix "nolapic" flag in ACPI mode
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d52bb94d56676acd9bdac8e097257a87b4b1b2e1
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    Enable P-state software coordination via _PDC
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c52851b60cc0aaaf974ff0e49989fb698220447d
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for speedstep-centrino
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 09b4d1ee881c8593bfad2a42f838d85070365c3e
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for acpi-cpufreq
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for ACPI core
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ffd642e748c867a7339b57225b8bf8b9a0dcd9c5
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Feb 8 17:35:00 2006 -0500

    [ACPI] enable SMP C-states on x86_64
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5653
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
