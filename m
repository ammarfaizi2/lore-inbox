Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWENOMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWENOMo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWENOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:12:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32424 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751422AbWENOMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:12:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=F08lQRXaJCU14+NmioUmyIWxafZTr8faSCfTldMksreuQJtGQrFidBc2cUMG40rCzI88ryMOY7NalJWM7g6RFHqc8dPmQHz6VcRdk5pZCEuRt6M+JFW2y2G9lVacZRSrgY6Js5Q72Q9cMYhIWFwxrHIk8tzyG7o2e5d9UX42R08=
Message-ID: <44673ADE.9090004@gmail.com>
Date: Sun, 14 May 2006 16:12:23 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: please git pull ACPI for 2.6.17
References: <200604031806.44347.len.brown@intel.com>
In-Reply-To: <200604031806.44347.len.brown@intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Len Brown napsal(a):
> Hi Linus,
> 
> please pull from: 
Hello,

is it possible to do so now, still before .17 release?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> This will update the files shown below.
> 
> thanks!
> 
> -Len
> 
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.16/acpi-release-20060310-2.6.16.diff.gz
> 
>  Documentation/kernel-parameters.txt               |    3 
>  arch/i386/kernel/acpi/boot.c                      |    5 
>  arch/i386/kernel/acpi/processor.c                 |    2 
>  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |  295 ++++++----
>  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |  250 ++++++--
>  arch/ia64/Kconfig                                 |    1 
>  arch/ia64/hp/common/sba_iommu.c                   |    2 
>  arch/x86_64/Kconfig                               |    1 
>  arch/x86_64/kernel/acpi/Makefile                  |    1 
>  arch/x86_64/kernel/acpi/processor.c               |   74 --
>  drivers/acpi/Kconfig                              |    3 
>  drivers/acpi/ac.c                                 |   12 
>  drivers/acpi/acpi_memhotplug.c                    |   79 +-
>  drivers/acpi/asus_acpi.c                          |   28 
>  drivers/acpi/battery.c                            |   31 -
>  drivers/acpi/bus.c                                |   22 
>  drivers/acpi/button.c                             |   18 
>  drivers/acpi/container.c                          |    2 
>  drivers/acpi/debug.c                              |    5 
>  drivers/acpi/dispatcher/dsfield.c                 |    1 
>  drivers/acpi/dispatcher/dsmethod.c                |    5 
>  drivers/acpi/dispatcher/dsmthdat.c                |    3 
>  drivers/acpi/dispatcher/dsobject.c                |   17 
>  drivers/acpi/dispatcher/dsopcode.c                |    4 
>  drivers/acpi/dispatcher/dsutils.c                 |    9 
>  drivers/acpi/dispatcher/dswexec.c                 |    3 
>  drivers/acpi/dispatcher/dswload.c                 |   10 
>  drivers/acpi/dispatcher/dswscope.c                |    2 
>  drivers/acpi/dispatcher/dswstate.c                |   13 
>  drivers/acpi/ec.c                                 |   33 -
>  drivers/acpi/event.c                              |    5 
>  drivers/acpi/events/evevent.c                     |    2 
>  drivers/acpi/events/evgpe.c                       |    5 
>  drivers/acpi/events/evgpeblk.c                    |   56 +
>  drivers/acpi/events/evmisc.c                      |    6 
>  drivers/acpi/events/evregion.c                    |   12 
>  drivers/acpi/events/evrgnini.c                    |   14 
>  drivers/acpi/events/evxface.c                     |   82 +-
>  drivers/acpi/events/evxfevnt.c                    |   41 -
>  drivers/acpi/events/evxfregn.c                    |    9 
>  drivers/acpi/executer/exconfig.c                  |    9 
>  drivers/acpi/executer/exconvrt.c                  |    2 
>  drivers/acpi/executer/exdump.c                    |    4 
>  drivers/acpi/executer/exfield.c                   |    6 
>  drivers/acpi/executer/exfldio.c                   |    5 
>  drivers/acpi/executer/exmisc.c                    |    1 
>  drivers/acpi/executer/exmutex.c                   |    3 
>  drivers/acpi/executer/exnames.c                   |   10 
>  drivers/acpi/executer/exoparg1.c                  |   63 +-
>  drivers/acpi/executer/exoparg2.c                  |   81 +-
>  drivers/acpi/executer/exoparg3.c                  |   11 
>  drivers/acpi/executer/exoparg6.c                  |    1 
>  drivers/acpi/executer/exprep.c                    |   19 
>  drivers/acpi/executer/exregion.c                  |   11 
>  drivers/acpi/executer/exresnte.c                  |    5 
>  drivers/acpi/executer/exresolv.c                  |   43 -
>  drivers/acpi/executer/exresop.c                   |    4 
>  drivers/acpi/executer/exstore.c                   |    2 
>  drivers/acpi/executer/exstoren.c                  |    3 
>  drivers/acpi/executer/exstorob.c                  |   11 
>  drivers/acpi/executer/exsystem.c                  |    2 
>  drivers/acpi/executer/exutils.c                   |    3 
>  drivers/acpi/fan.c                                |    7 
>  drivers/acpi/hardware/hwgpe.c                     |    2 
>  drivers/acpi/hardware/hwregs.c                    |   12 
>  drivers/acpi/hardware/hwsleep.c                   |   19 
>  drivers/acpi/hardware/hwtimer.c                   |   10 
>  drivers/acpi/hotkey.c                             |   40 -
>  drivers/acpi/motherboard.c                        |   63 +-
>  drivers/acpi/namespace/nsaccess.c                 |   26 
>  drivers/acpi/namespace/nsalloc.c                  |   14 
>  drivers/acpi/namespace/nsdump.c                   |    4 
>  drivers/acpi/namespace/nsdumpdv.c                 |    2 
>  drivers/acpi/namespace/nseval.c                   |    5 
>  drivers/acpi/namespace/nsinit.c                   |    7 
>  drivers/acpi/namespace/nsload.c                   |    3 
>  drivers/acpi/namespace/nsnames.c                  |   10 
>  drivers/acpi/namespace/nsobject.c                 |    3 
>  drivers/acpi/namespace/nsparse.c                  |    2 
>  drivers/acpi/namespace/nssearch.c                 |    5 
>  drivers/acpi/namespace/nsutils.c                  |   23 
>  drivers/acpi/namespace/nswalk.c                   |    4 
>  drivers/acpi/namespace/nsxfeval.c                 |   84 +-
>  drivers/acpi/namespace/nsxfname.c                 |   17 
>  drivers/acpi/namespace/nsxfobj.c                  |   11 
>  drivers/acpi/osl.c                                |   27 
>  drivers/acpi/parser/psargs.c                      |    7 
>  drivers/acpi/parser/psloop.c                      |    7 
>  drivers/acpi/parser/psopcode.c                    |    2 
>  drivers/acpi/parser/psparse.c                     |    8 
>  drivers/acpi/parser/psscope.c                     |    1 
>  drivers/acpi/parser/pstree.c                      |    8 
>  drivers/acpi/parser/psutils.c                     |    9 
>  drivers/acpi/parser/pswalk.c                      |    3 
>  drivers/acpi/parser/psxface.c                     |    2 
>  drivers/acpi/pci_bind.c                           |   50 -
>  drivers/acpi/pci_irq.c                            |   20 
>  drivers/acpi/pci_link.c                           |   92 +--
>  drivers/acpi/pci_root.c                           |   15 
>  drivers/acpi/power.c                              |   22 
>  drivers/acpi/processor_core.c                     |   74 --
>  drivers/acpi/processor_idle.c                     |   14 
>  drivers/acpi/processor_perflib.c                  |  265 ++++++++
>  drivers/acpi/processor_thermal.c                  |   11 
>  drivers/acpi/processor_throttling.c               |    2 
>  drivers/acpi/resources/rscalc.c                   |  126 ++--
>  drivers/acpi/resources/rscreate.c                 |    2 
>  drivers/acpi/resources/rsinfo.c                   |    1 
>  drivers/acpi/resources/rslist.c                   |   18 
>  drivers/acpi/resources/rsmisc.c                   |   12 
>  drivers/acpi/resources/rsutils.c                  |   63 +-
>  drivers/acpi/resources/rsxface.c                  |   31 -
>  drivers/acpi/scan.c                               |   64 --
>  drivers/acpi/sleep/wakeup.c                       |    3 
>  drivers/acpi/system.c                             |    3 
>  drivers/acpi/tables/tbconvrt.c                    |   11 
>  drivers/acpi/tables/tbget.c                       |   11 
>  drivers/acpi/tables/tbgetall.c                    |    1 
>  drivers/acpi/tables/tbinstal.c                    |    9 
>  drivers/acpi/tables/tbrsdt.c                      |    1 
>  drivers/acpi/tables/tbutils.c                     |    2 
>  drivers/acpi/tables/tbxface.c                     |   18 
>  drivers/acpi/tables/tbxfroot.c                    |   33 -
>  drivers/acpi/thermal.c                            |   62 --
>  drivers/acpi/utilities/utalloc.c                  |    7 
>  drivers/acpi/utilities/utcache.c                  |   10 
>  drivers/acpi/utilities/utcopy.c                   |   27 
>  drivers/acpi/utilities/utdebug.c                  |   27 
>  drivers/acpi/utilities/utdelete.c                 |    7 
>  drivers/acpi/utilities/uteval.c                   |    8 
>  drivers/acpi/utilities/utglobal.c                 |    8 
>  drivers/acpi/utilities/utinit.c                   |    8 
>  drivers/acpi/utilities/utmisc.c                   |   39 -
>  drivers/acpi/utilities/utmutex.c                  |    4 
>  drivers/acpi/utilities/utobject.c                 |    7 
>  drivers/acpi/utilities/utresrc.c                  |    4 
>  drivers/acpi/utilities/utstate.c                  |    2 
>  drivers/acpi/utilities/utxface.c                  |   24 
>  drivers/acpi/utils.c                              |   50 -
>  drivers/acpi/video.c                              |   56 -
>  drivers/char/agp/hp-agp.c                         |    2 
>  drivers/char/hpet.c                               |    5 
>  drivers/char/sonypi.c                             |   10 
>  drivers/pnp/pnpacpi/rsparser.c                    |  199 ++----
>  include/acpi/acconfig.h                           |   10 
>  include/acpi/acdisasm.h                           |   24 
>  include/acpi/aclocal.h                            |    8 
>  include/acpi/acmacros.h                           |   46 -
>  include/acpi/acnamesp.h                           |    5 
>  include/acpi/acpiosxf.h                           |    2 
>  include/acpi/actypes.h                            |   25 
>  include/acpi/acutils.h                            |    2 
>  include/acpi/amlresrc.h                           |   63 +-
>  include/acpi/pdc_intel.h                          |    5 
>  include/acpi/platform/acenv.h                     |    6 
>  include/acpi/platform/aclinux.h                   |   23 
>  include/acpi/processor.h                          |   27 
>  include/asm-i386/apicdef.h                        |    1 
>  include/asm-x86_64/acpi.h                         |    2 
>  include/asm-x86_64/apicdef.h                      |    2 
>  include/linux/cpufreq.h                           |    4 
>  161 files changed, 2141 insertions(+), 1566 deletions(-)
> 
> through these commits:
> 
> Adrian Bunk:
>       [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
>       ACPI: Kconfig: ACPI should depend on, not select PCI
> 
> Andi Kleen:
>       [ACPI] fix "nolapic" flag in ACPI mode
> 
> Andrew Morton:
>       ACPI: UP build fix for bugzilla-5737
> 
> Ashok Raj:
>       ACPI: build fix for u8 cpu_index
>       ACPI: Allow hot-add of ejected processor
>       x86_64: Remove stale lapic definition from apicdef.h 
> 
> Bjorn Helgaas:
>       PNPACPI: fix non-memory address space descriptor handling 
>       PNPACPI: remove some code duplication
>       PNPACPI: whitespace cleanup
>       ACPI: request correct fixed hardware resource type (MMIO vs I/O port) 
>       ACPI: Display "ACPI" to motherboard resources in /proc/io{mem,port} 
>       ACPI: make acpi_bus_register_driver() return success/failure, not device 
> count 
>       ACPI: update asus_acpi driver registration to unload on failure
>       ACPI: fix sonypi ACPI driver registration to unregister on failure
>       ACPI: simplify scan.c coding
>       ACPI: fix memory hotplug range length handling
>       HPET: fix ACPI memory range length handling
>       ACPI: remove __init/__exit from Asus .add()/.remove() methods 
>       ACPI: Don't print internal BIOS names of wakeup devices
> 
> Bob Moore:
>       [ACPI] ACPICA 20060210
>       ACPI: ACPICA 20060217
>       ACPI: ACPICA 20060310
> 
> Dave Jones:
>       [ACPI] fix possible acpi thermal leak in failure path
> 
> Davi Arnaut:
>       ACPI: acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled 
> through suspend-resume 
> 
> David Shaohua Li:
>       [ACPI] enable SMP C-states on x86_64
> 
> Irwan Djajadi:
>       [ACPI] drivers/acpi/hotkey.c: check kmalloc return value
> 
> Jiri Slaby:
>       ACPI: EC acpi-ecdt-uid-hack
> 
> Len Brown:
>       ACPI: enable BIOS warning
>       [ACPI] document cmdline acpi_os_name=
>       Revert "ACPI: fix vendor resource length computation"
>       ACPI: inline trivial acpi_os_get_thread_id()
>       ACPI: ia64 buildfix
>       ACPI: ia64 buildfix
>       merge acpi_in_resume address-range cpu-hotplug ec Kconfig motherboard 
> pnpacpi trivial1 into release
>       merge novell-bugzilla-156426 trivial bugzilla-5653 bugzilla-5452 into 
> release
>       Pull bugzilla-5737 into release branch
>       Pull acpi_bus_register_driver into release branch
>       Pull dmesg into release branch
>       Pull acpica into release branch
> 
> Thomas Renniger:
>       [ACPI] Enable ACPI error messages w/o CONFIG_ACPI_DEBUG
> 
> Thomas Renninger:
>       [ACPI] Export symbols for ACPI_ERROR/EXCEPTION/WARNING macros
>       [ACPI] Print error message if remove/install notify handler fails
> 
> Venkatesh Pallipadi:
>       P-state software coordination for ACPI core
>       P-state software coordination for acpi-cpufreq
>       P-state software coordination for speedstep-centrino
>       Enable P-state software coordination via _PDC
> 
> with this log:
> 
> commit 8a83d8aaf47a74be0850322da48e8247783c887c
> Merge: a9ca495... 144c87b...
> Author: Len Brown <len.brown@intel.com>
> Date:   Mon Apr 3 17:27:24 2006 -0400
> 
>     Pull acpica into release branch
> 
> commit a9ca49562e8573be186952f521c7f3a38ed77f77
> Merge: 9683988... f9ea7fd...
> Author: Len Brown <len.brown@intel.com>
> Date:   Mon Apr 3 17:27:07 2006 -0400
> 
>     Pull dmesg into release branch
>     
>     Conflicts:
>     
>     	drivers/acpi/processor_core.c
>     	drivers/acpi/video.c
> 
> commit 968398867298c1f2bddae5760227f75b88916f32
> Merge: 2324f47... e4513a5...
> Author: Len Brown <len.brown@intel.com>
> Date:   Mon Apr 3 17:24:26 2006 -0400
> 
>     Pull acpi_bus_register_driver into release branch
>     
>     Conflicts:
>     
>     	drivers/acpi/asus_acpi.c
> 
> commit 2324f473c054ad95c555668f3f8b65e84156f8d5
> Merge: 035d753... 7e1f19e...
> Author: Len Brown <len.brown@intel.com>
> Date:   Mon Apr 3 17:22:32 2006 -0400
> 
>     Pull bugzilla-5737 into release branch
>     
>     Conflicts:
>     
>     	arch/x86_64/kernel/acpi/processor.c
> 
> commit 035d753683feb19f8f4c83b488efde12fff26756
> Merge: d04a427... 9cfda2c... 6665bda... ffd642e... 0eacee5...
> Author: Len Brown <len.brown@intel.com>
> Date:   Mon Apr 3 17:19:07 2006 -0400
> 
>     merge novell-bugzilla-156426 trivial bugzilla-5653 bugzilla-5452 into 
> release
> 
> commit d04a427d7855320153da8e0d29662f9b03ac4f1a
> Merge: 5e15b92... 9224a86... eefa27a... ff2fc3e... 1300124... cd090ee... 
> 1c6e7d0... e6f1f3c...
> Author: Len Brown <len.brown@intel.com>
> Date:   Mon Apr 3 17:16:41 2006 -0400
> 
>     merge acpi_in_resume address-range cpu-hotplug ec Kconfig motherboard 
> pnpacpi trivial1 into release
> 
> commit e6f1f3c54974a30c65ea0b699809d12f0aa04272
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Mon Apr 3 13:14:00 2006 -0400
> 
>     ACPI: Don't print internal BIOS names of wakeup devices
>     
>     Internal BIOS names like these should be exposed
>     to the user as little as possible:
>     
>     ACPI wakeup devices: C069 C0CE C1D1 C0DE C1D4
>     
>     Eventually, the "wakeup" property of a device should be exported via the
>     device tree, not by a printk of an internal BIOS name.  For the hard-core,
>     these are still available in /proc/acpi/wakeup_devices, just not
>     printed to dmesg.
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 144c87b4e03759214c362d267e01c2905f1ab095
> Author: Len Brown <len.brown@intel.com>
> Date:   Sun Apr 2 00:15:39 2006 -0500
> 
>     ACPI: ia64 buildfix
>     
>     arch/ia64/hp/common/sba_iommu.c used ACPI_MEM_FREE instead of kfree()
>     
>     Signed-off-by: Len Brown <len.brown@intel.com
> 
> commit 7f048801f4a6767433d1aeefd9c24372515265f8
> Author: Len Brown <len.brown@intel.com>
> Date:   Sat Apr 1 23:45:39 2006 -0500
> 
>     ACPI: ia64 buildfix
>     
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit c12ea918ee175ceb3a258cd81f1c43e897d0c0bc
> Author: Ashok Raj <ashok.raj@intel.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     x86_64: Remove stale lapic definition from apicdef.h 
>     
>     Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>     Cc: Andi Kleen <ak@muc.de>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit eefa27a93a0490902f33837ac86dbcf344b3aa29
> Author: Ashok Raj <ashok.raj@intel.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: Allow hot-add of ejected processor
>     
>     acpi_eject_store() didn't trim processors, causing subsequent
>     hot-add to fail.
>     
>     Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>     Cc: Andi Kleen <ak@muc.de>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
> Author: Jiri Slaby <jirislaby@gmail.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: EC acpi-ecdt-uid-hack
>     
>     On some boxes ecdt uid may be equal to 0, so do not test for uids 
> equality,
>     so that fake handler will be unconditionally removed to allow loading the
>     real one.
>     
>     See http://bugzilla.kernel.org/show_bug.cgi?id=6111
>     
>     Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>     Cc: Luming Yu <luming.yu@intel.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit df42baa0d8e54df18dd9366dd7c93d6be7d5d063
> Author: Ashok Raj <ashok.raj@intel.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: build fix for u8 cpu_index
>     
>     Local apic entries are only 8 bits, but it seemed to not be caught with u8
>     return value result in the check
>     
>     cpu_index >= NR_CPUS becomming always false.
>     
>     drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
>     drivers/acpi/processor_core.c:483: warning: comparison is always false due 
> to limited range of data type
>     
>     Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>     Cc: Dave Jones <davej@codemonkey.org.uk>
>     Cc: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 200739c179c63d21804e9e8e2ced265243831579
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: remove __init/__exit from Asus .add()/.remove() methods 
>     
>     Even though the devices claimed by asus_acpi.c can not be hot-plugged, the
>     driver registration infrastructure allows the .add() and .remove() methods 
> to
>     be called at any time while the driver is registered.  So remove __init 
> and
>     __exit from them.
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 5e15b92d07fb11490c886c5dd7567f523ea43e2d
> Author: Davi Arnaut <davi.arnaut@gmail.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled 
> through suspend-resume 
>     
>     acpi_os_acquire_object() gets called, with IRQs disabled, from:
>     
>     Debug: sleeping function called from invalid context at mm/slab.c:2499
>     in_atomic():0, irqs_disabled():1
>      [<c01462f3>] kmem_cache_alloc+0x40/0x4f     [<c0202c85>] 
> acpi_os_acquire_object+0xb/0x3c
>      [<c02171b1>] acpi_ut_allocate_object_desc_dbg+0x13/0x49     [<c021704b>] 
> acpi_ut_create_internal_object_dbg+0xf/0x5e
>      [<c02136d4>] acpi_rs_set_srs_method_data+0x3d/0xb9     [<c021aa3d>] 
> acpi_pci_link_set+0x102/0x17b
>      [<c021aecb>] irqrouter_resume+0x1e/0x3c     [<c024d921>] 
> __sysdev_resume+0x11/0x6b
>      [<c024dbde>] sysdev_resume+0x34/0x52     [<c0251cb7>] 
> device_power_up+0x5/0xa
>      [<c0138787>] suspend_enter+0x44/0x46     [<c01386e5>] 
> suspend_prepare+0x63/0xc1
>      [<c0138813>] enter_state+0x5e/0x7c     [<c013894c>] state_store+0x81/0x8f
>      [<c01388cb>] state_store+0x0/0x8f     [<c0196a0a>] 
> subsys_attr_store+0x1e/0x22
>      [<c0196c12>] flush_write_buffer+0x22/0x28     [<c0196c64>] 
> sysfs_write_file+0x4c/0x71
>      [<c0196c18>] sysfs_write_file+0x0/0x71     [<c015b2c9>] 
> vfs_write+0xa2/0x15a
>      [<c015b42c>] sys_write+0x41/0x6a     [<c0102e75>] syscall_call+0x7/0xb
>     
>     The patch also fixes a missing check for NULL return from
>     acpi_os_acquire_object().
>     
>     Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
>     Cc: Pavel Machek <pavel@ucw.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 9224a867c497053842dc595e594ca6d32112221f
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     HPET: fix ACPI memory range length handling
>     
>     ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and 
> _MAX
>     are the bounds within which the region can be moved (this is clarified in
>     Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the 
> size
>     of the region, not _MAX - _MIN + 1.
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 459c7266d7a5c1730169258217e25fdd1b7ca854
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: fix memory hotplug range length handling
>     
>     Address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX are
>     the bounds within which the region can be moved (this is clarified in 
> Table
>     6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size of
>     the region, not _MAX - _MIN + 1.
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 1a36561607abf1405b56a41aac2fd163429cd1f8
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: simplify scan.c coding
>     
>     No functional changes; just remove leftover, unused "buffer" and simplify
>     control flow (no need to remember error values and goto the end, when we 
> can
>     simply return the value directly).
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit e4513a57ef719d3d6d1cee0ca4d9f4016aa452bb
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: fix sonypi ACPI driver registration to unregister on failure
>     
>     Remove the assumption that acpi_bus_register_driver() returns the number 
> of
>     devices claimed.  Returning the count is unreliable because devices may be
>     hot-plugged in the future (admittedly not applicable for this driver).
>     
>     This also fixes a bug: if sonypi_acpi_driver was registered but found no
>     devices, sonypi_exit() did not unregister it.
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 578b333bfe8eb1360207a08a53c321822a8f40f3
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: update asus_acpi driver registration to unload on failure
>     
>     Remove the assumption that acpi_bus_register_driver() returns the number 
> of
>     devices claimed.  Returning the count is unreliable because devices may be
>     hot-plugged in the future (admittedly not applicable for this driver).
>     
>     Since the hardware for this driver is not hot-pluggable, determine whether 
> the
>     hardware is present by noticing calls to the .add() method.  It would be
>     better to probe the ACPI namespace for the ASUS HIDs, and load the driver 
> only
>     when we find one, but ACPI doesn't support that yet.
>     
>     I don't have an ASUS laptop to test on, but on my HP dl360, it does report 
> the
>     appropriate error when attempting to load the module:
>     
>         $ sudo insmod drivers/acpi/asus_acpi.ko
>         insmod: error inserting 'drivers/acpi/asus_acpi.ko': -1 No such device
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 9d9f749b316ac21cb59ad3e595cbce469b409e1a
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: make acpi_bus_register_driver() return success/failure, not device 
> count 
>     
>     acpi_bus_register_driver() should not return the number of devices 
> claimed.
>     We're not asking to find devices, we're making a driver available to 
> devices,
>     including hot-pluggable devices that may appear in the future.
>     
>     I audited all callers of acpi_bus_register_driver(), and except 
> asus_acpi.c
>     and sonypi.c (fixed in previous patches), all either ignore the return 
> value
>     or test only for failure (<0).
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit cd090eedd85256829f762677d0752a846c1b88b9
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: Display "ACPI" to motherboard resources in /proc/io{mem,port} 
>     
>     Add "ACPI" to motherboard resource allocation names, so people have a clue
>     about where to look.  And remove some trailing spaces.
>     
>     Changes these /proc/iomem entries from this:
>     
>         ff5c1004-ff5c1007 : PM_TMR
>         ff5c1008-ff5c100b : PM1a_EVT_BLK
>         ff5c100c-ff5c100d : PM1a_CNT_BLK
>         ff5c1010-ff5c1013 : GPE0_BLK
>         ff5c1014-ff5c1017 : GPE1_BLK
>     
>     to this:
>     
>         ff5c1004-ff5c1007 : ACPI PM_TMR
>         ff5c1008-ff5c100b : ACPI PM1a_EVT_BLK
>         ff5c100c-ff5c100d : ACPI PM1a_CNT_BLK
>         ff5c1010-ff5c1013 : ACPI GPE0_BLK
>         ff5c1014-ff5c1017 : ACPI GPE1_BLK
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 81507ea9cfa64e9851b53e0fefebfa776eda9ecb
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: request correct fixed hardware resource type (MMIO vs I/O port) 
>     
>     ACPI supports fixed hardware (PM_TMR, GPE blocks, etc) in either I/O port
>     or MMIO space, but used to always request the regions from I/O space
>     because it didn't check the address_space_id.
>     
>     Sample ACPI fixed hardware in MMIO space (HP rx2600), was incorrectly
>     reported in /proc/ioports, now reported in /proc/iomem:
>     
>         ff5c1004-ff5c1007 : PM_TMR
>         ff5c1008-ff5c100b : PM1a_EVT_BLK
>         ff5c100c-ff5c100d : PM1a_CNT_BLK
>         ff5c1010-ff5c1013 : GPE0_BLK
>         ff5c1014-ff5c1017 : GPE1_BLK
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 1c6e7d0aeecac38e66b1bb63e3eff07b2a1c2f2c
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     PNPACPI: whitespace cleanup
>     
>     Tidy up whitespace.  No functional change.
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit b5f2490b6e3317059e87ba40d4f659d1c30afc1f
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     PNPACPI: remove some code duplication
>     
>     Factor out the duplicated switch from pnpacpi_count_resources() and
>     pnpacpi_type_resources().  Remove the unnecessary re-initialization of
>     resource->type and length from all the encode functions (id and length are
>     originally set in the pnpacpi_build_resource_template() ->
>     pnpacpi_type_resources() path).
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 1acfb7f2b0d460ee86bdb25ad0679070ec8a5f0d
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Tue Mar 28 17:03:00 2006 -0500
> 
>     PNPACPI: fix non-memory address space descriptor handling 
>     
>     Fix resource_type handling for QWORD, DWORD, and WORD Address Space
>     Descriptors.  Previously we ignored the resource_type, so I/O ports and 
> bus
>     number ranges were incorrectly parsed as memory ranges.
>     
>     Sample PCI root bridge resources from HP rx2600 before this patch:
>     
>         # cat /sys/bus/pnp/devices/00:02/resources
>         state = active
>         mem 0x0-0x1f
>         mem 0x0-0x3af
>         mem 0x3e0-0x1fff
>         mem 0x80000000-0x8fffffff
>     
>     With this patch:
>     
>         # cat /sys/bus/pnp/devices/00:02/resources
>         state = active
>         io 0x0-0x3af
>         io 0x3e0-0x1fff
>         mem 0x80000000-0x8fffffff
>         mem 0x80004000000-0x80103fffffe
>     
>     Changes:
>         0x0-0x1f PCI bus number range was incorrectly reported as memory, now
>     	not reported at all
>         0x0-0x3af I/O port range was incorrectly reported as memory
>         0x3e0-0x1fff I/O port range was incorrectly reported as memory
>         0x80004000000-0x80103fffffe memory range wasn't reported at all 
> because
>     	we only support PNP_MAX_MEM (4) memory resources
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 7e1f19e50371e1d148226b64c8edc77fec47fa5b
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Tue Mar 28 17:03:00 2006 -0500
> 
>     ACPI: UP build fix for bugzilla-5737
>     
>     cpu_online_map doesn't exist if !CONFIG_SMP.
>     
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 1300124f69cafc54331bc06e968a8dd67863f989
> Author: Adrian Bunk <bunk@stusta.de>
> Date:   Tue Mar 28 17:04:00 2006 -0500
> 
>     ACPI: Kconfig: ACPI should depend on, not select PCI
>     
>     Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are
>     possible.
>     
>     This patch also fixes the options select'ing ACPI to also select PCI.
>     
>     Signed-off-by: Adrian Bunk <bunk@stusta.de>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit ec7381d6bfd3e7b8d2880dd5e9d03b131b0603f6
> Author: Len Brown <lenb@toshiba.site>
> Date:   Sat Apr 1 05:12:23 2006 -0500
> 
>     ACPI: inline trivial acpi_os_get_thread_id()
>     
>     acpi_os_get_thread_id() is used only for debugging
>     code that is not enabled on Linux, so stub it out.
>     
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 8313524a0d466f451a62709aaedf988d8257b21c
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Tue Oct 3 00:00:00 2006 -0400
> 
>     ACPI: ACPICA 20060310
>     
>     Tagged all external interfaces to the subsystem with the
>     new ACPI_EXPORT_SYMBOL macro. This macro can be defined
>     as necessary to assist kernel integration. For Linux,
>     the macro resolves to the EXPORT_SYMBOL macro. The default
>     definition is NULL.
>     
>     Added the ACPI_THREAD_ID type for the return value from
>     acpi_os_get_thread_id(). This allows the host to define this
>     as necessary to simplify kernel integration. The default
>     definition is ACPI_NATIVE_UINT.
>     
>     Valery Podrezov fixed two interpreter problems related
>     to error processing, the deletion of objects, and placing
>     invalid pointers onto the internal operator result stack.
>     http://bugzilla.kernel.org/show_bug.cgi?id=6028
>     http://bugzilla.kernel.org/show_bug.cgi?id=6151
>     
>     Increased the reference count threshold where a warning is
>     emitted for large reference counts in order to eliminate
>     unnecessary warnings on systems with large namespaces
>     (especially 64-bit.) Increased the value from 0x400
>     to 0x800.
>     
>     Due to universal disagreement as to the meaning of the
>     'c' in the calloc() function, the ACPI_MEM_CALLOCATE
>     macro has been renamed to ACPI_ALLOCATE_ZEROED so that the
>     purpose of the interface is 'clear'. ACPI_MEM_ALLOCATE and
>     ACPI_MEM_FREE are renamed to ACPI_ALLOCATE and ACPI_FREE.
>     
>     Signed-off-by: Bob Moore <robert.moore@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit ea936b78f46cbe089a4ac363e1682dee7d427096
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Fri Feb 17 00:00:00 2006 -0500
> 
>     ACPI: ACPICA 20060217
>     
>     Implemented a change to the IndexField support to match
>     the behavior of the Microsoft AML interpreter. The value
>     written to the Index register is now a byte offset,
>     no longer an index based upon the width of the Data
>     register. This should fix IndexField problems seen on
>     some machines where the Data register is not exactly one
>     byte wide. The ACPI specification will be clarified on
>     this point.
>     
>     Fixed a problem where several resource descriptor
>     types could overrun the internal descriptor buffer due
>     to size miscalculation: VendorShort, VendorLong, and
>     Interrupt. This was noticed on IA64 machines, but could
>     affect all platforms.
>     
>     Fixed a problem where individual resource descriptors were
>     misaligned within the internal buffer, causing alignment
>     faults on IA64 platforms.
>     
>     Signed-off-by: Bob Moore <robert.moore@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 52fc0b026e99b5d5d585095148d997d5634bbc25
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Mon Oct 2 00:00:00 2006 -0400
> 
>     [ACPI] ACPICA 20060210
>     
>     Removed a couple of extraneous ACPI_ERROR messages that
>     appeared during normal execution. These became apparent
>     after the conversion from ACPI_DEBUG_PRINT.
>     
>     Fixed a problem where the CreateField operator could hang
>     if the BitIndex or NumBits parameter referred to a named
>     object. From Valery Podrezov.
>     http://bugzilla.kernel.org/show_bug.cgi?id=5359
>     
>     Fixed a problem where a DeRefOf operation on a buffer
>     object incorrectly failed with an exception. This also
>     fixes a couple of related RefOf and DeRefOf issues.
>     From Valery Podrezov.
>     http://bugzilla.kernel.org/show_bug.cgi?id=5360
>     http://bugzilla.kernel.org/show_bug.cgi?id=5387
>     http://bugzilla.kernel.org/show_bug.cgi?id=5392
>     
>     Fixed a problem where the AE_BUFFER_LIMIT exception was
>     returned instead of AE_STRING_LIMIT on an out-of-bounds
>     Index() operation. From Valery Podrezov.
>     http://bugzilla.kernel.org/show_bug.cgi?id=5480
>     
>     Implemented a memory cleanup at the end of the execution
>     of each iteration of an AML While() loop, preventing the
>     accumulation of outstanding objects. From Valery Podrezov.
>     http://bugzilla.kernel.org/show_bug.cgi?id=5427
>     
>     Eliminated a chunk of duplicate code in the object
>     resolution code. From Valery Podrezov.
>     http://bugzilla.kernel.org/show_bug.cgi?id=5336
>     
>     Fixed several warnings during the 64-bit code generation.
>     
>     Signed-off-by: Bob Moore <robert.moore@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 46358614ed5b031797522f1020e989c959a8d8a6
> Author: Len Brown <lenb@toshiba.site>
> Date:   Fri Mar 31 02:16:19 2006 -0500
> 
>     Revert "[PATCH] ACPI: fix vendor resource length computation"
>     
>     fixed in a different way by a subsequent ACPICA patch
>     
>     This reverts 35b73ceb9a7d10c81bd9e79e8485f7079ef2b40e commit.
> 
> commit 6665bda76461308868bd1e52caf627f4cb29ed32
> Author: Adrian Bunk <bunk@stusta.de>
> Date:   Sat Mar 11 10:12:00 2006 -0500
> 
>     [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
>     
>     The Coverity checker spotted this bug in
>     acpi_video_device_lcd_query_levels().
>     
>     Signed-off-by: Adrian Bunk <bunk@stusta.de>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit fdc136ccd3332938e989439c025c363f8479f3e6
> Author: Dave Jones <davej@redhat.com>
> Date:   Wed Mar 8 22:12:00 2006 -0500
> 
>     [ACPI] fix possible acpi thermal leak in failure path
>     
>     Coverity: #601
>     
>     Signed-off-by: Dave Jones <davej@redhat.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit a1f9e65e2085e0a87f28a4d5a8ae43b32c087f24
> Author: Len Brown <len.brown@intel.com>
> Date:   Wed Jan 25 23:47:36 2006 -0500
> 
>     [ACPI] document cmdline acpi_os_name=
>     
>     This can sometimes be used to work around broken BIOS.
>     Use "Microsoft Windows" to take the same path
>     through the BIOS as Windows98 would.
>     
>     The default is "Microsoft Windows NT", which
>     is what NT and later versions of Windows use,
>     and is the most tested path through most BIOS.
>     
>     Set it to anything else, including "Linux", at your
>     own risk, as it seems that virtually no BIOS
>     has been tested with anything but the two options above.
>     
>     Note that this uses the legacy _OS interface, so
>     we don't expect this to ever change.
>     
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 1fee94034917aa711fcbd4ebf4c36f7ebd9fa7d6
> Author: Irwan Djajadi <irwan.djajadi@iname.com>
> Date:   Fri Jan 20 15:28:00 2006 -0500
> 
>     [ACPI] drivers/acpi/hotkey.c: check kmalloc return value
>     
>     Signed-off-by: Irwan Djajadi <irwan.djajadi@iname.com>
>     Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 0eacee585a89ce5827b572a73a024931506bef48
> Author: Len Brown <lenb@toshiba.site>
> Date:   Fri Mar 31 00:37:23 2006 -0500
> 
>     ACPI: enable BIOS warning
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=5452
>     
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 9cfda2c94df61c9f859b474abe774c65a4464d0a
> Author: Andi Kleen <ak@suse.de>
> Date:   Mon Mar 27 02:24:32 2006 -0500
> 
>     [ACPI] fix "nolapic" flag in ACPI mode
>     
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit d52bb94d56676acd9bdac8e097257a87b4b1b2e1
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Wed Dec 14 15:05:00 2005 -0500
> 
>     Enable P-state software coordination via _PDC
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=5737
>     
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit c52851b60cc0aaaf974ff0e49989fb698220447d
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Wed Dec 14 15:05:00 2005 -0500
> 
>     P-state software coordination for speedstep-centrino
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=5737
>     
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 09b4d1ee881c8593bfad2a42f838d85070365c3e
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Wed Dec 14 15:05:00 2005 -0500
> 
>     P-state software coordination for acpi-cpufreq
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=5737
>     
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Wed Dec 14 15:05:00 2005 -0500
> 
>     P-state software coordination for ACPI core
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=5737
>     
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit ffd642e748c867a7339b57225b8bf8b9a0dcd9c5
> Author: David Shaohua Li <shaohua.li@intel.com>
> Date:   Wed Feb 8 17:35:00 2006 -0500
> 
>     [ACPI] enable SMP C-states on x86_64
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=5653
>     
>     Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit f9ea7fd8be9827791f407ca1191ff70ec25eb2d9
> Author: Thomas Renninger <trenn@suse.de>
> Date:   Fri Jun 2 15:58:00 2006 -0400
> 
>     [ACPI] Print error message if remove/install notify handler fails
>     
>     Signed-off-by: Thomas Renniger <trenn@suse.de>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit b60e49b2383db0334bef1f0d9cdad9bec2336050
> Author: Thomas Renninger <trenn@suse.de>
> Date:   Fri Jun 2 15:58:00 2006 -0400
> 
>     [ACPI] Export symbols for ACPI_ERROR/EXCEPTION/WARNING macros
>     
>     Signed-off-by: Thomas Renninger <trenn@suse.de>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> commit 1ca218d3bd6acca0922a349cb76e3244d27ebfba
> Author: Thomas Renniger <trenn@suse.de>
> Date:   Fri Jun 2 15:58:00 2006 -0400
> 
>     [ACPI] Enable ACPI error messages w/o CONFIG_ACPI_DEBUG
>     
>     Signed-off-by: Thomas Renniger <trenn@suse.de>
>     Signed-off-by: Len Brown <len.brown@intel.com>

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZzrdMsxVwznUen4RAlwFAKCbpecgFhvhAS0CSPnkguEHX2hSqACdGE3L
GmRMUoZmhmFrNfPtg7/39FA=
=dLnq
-----END PGP SIGNATURE-----
