Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWF3GSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWF3GSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWF3GSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:18:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:55727 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751156AbWF3GSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:18:46 -0400
X-IronPort-AV: i="4.06,194,1149490800"; 
   d="scan'208"; a="58864395:sNHT148702554"
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: [GIT PATCH] ACPI for 2.6.18 -- part deux
Date: Fri, 30 Jun 2006 02:20:37 -0400
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200606230437.50845.len.brown@intel.com>
In-Reply-To: <200606230437.50845.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606300220.39405.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

CONFIG_ACPI_DOCK is new.  Although it has been in -mm for a while, I've
marked it EXPERIMENTAL because it hasn't yet seen the broad exposure
that comes with being in your upstream tree.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.17/acpi-release-20060623-2.6.17.diff.gz

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |    8 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    8 
 drivers/acpi/Kconfig                              |    7 
 drivers/acpi/Makefile                             |    1 
 drivers/acpi/ac.c                                 |   63 
 drivers/acpi/acpi_memhotplug.c                    |  135 -
 drivers/acpi/asus_acpi.c                          |    2 
 drivers/acpi/battery.c                            |  122 -
 drivers/acpi/bus.c                                |  128 -
 drivers/acpi/button.c                             |   72 
 drivers/acpi/container.c                          |   36 
 drivers/acpi/debug.c                              |   19 
 drivers/acpi/dispatcher/dsinit.c                  |   30 
 drivers/acpi/dispatcher/dsmethod.c                |  330 +---
 drivers/acpi/dispatcher/dswexec.c                 |    4 
 drivers/acpi/dispatcher/dswload.c                 |   49 
 drivers/acpi/dock.c                               |  739 ++++++++++
 drivers/acpi/ec.c                                 |  168 --
 drivers/acpi/event.c                              |   19 
 drivers/acpi/events/evgpe.c                       |   14 
 drivers/acpi/events/evxface.c                     |   47 
 drivers/acpi/executer/exconfig.c                  |    8 
 drivers/acpi/executer/excreate.c                  |   27 
 drivers/acpi/executer/exdump.c                    |    8 
 drivers/acpi/executer/exfldio.c                   |   71 
 drivers/acpi/executer/exmutex.c                   |   12 
 drivers/acpi/executer/exsystem.c                  |   82 -
 drivers/acpi/fan.c                                |   51 
 drivers/acpi/hardware/hwregs.c                    |   77 -
 drivers/acpi/hotkey.c                             |  132 -
 drivers/acpi/motherboard.c                        |    5 
 drivers/acpi/namespace/nsaccess.c                 |   27 
 drivers/acpi/osl.c                                |   72 
 drivers/acpi/parser/psparse.c                     |   18 
 drivers/acpi/pci_bind.c                           |   87 -
 drivers/acpi/pci_irq.c                            |   91 -
 drivers/acpi/pci_link.c                           |  189 +-
 drivers/acpi/pci_root.c                           |   39 
 drivers/acpi/power.c                              |  145 -
 drivers/acpi/processor_core.c                     |  161 --
 drivers/acpi/processor_idle.c                     |  129 -
 drivers/acpi/processor_perflib.c                  |  132 -
 drivers/acpi/processor_thermal.c                  |   48 
 drivers/acpi/processor_throttling.c               |   45 
 drivers/acpi/scan.c                               |  107 -
 drivers/acpi/system.c                             |   21 
 drivers/acpi/thermal.c                            |  218 +-
 drivers/acpi/utilities/utdelete.c                 |   36 
 drivers/acpi/utilities/utglobal.c                 |    1 
 drivers/acpi/utilities/utmisc.c                   |    3 
 drivers/acpi/utilities/utmutex.c                  |   39 
 drivers/acpi/utils.c                              |  104 -
 drivers/acpi/video.c                              |  270 +--
 drivers/pci/hotplug/Makefile                      |    3 
 drivers/pci/hotplug/acpiphp.h                     |   36 
 drivers/pci/hotplug/acpiphp_core.c                |   19 
 drivers/pci/hotplug/acpiphp_dock.c                |  438 -----
 drivers/pci/hotplug/acpiphp_glue.c                |  123 +
 include/acpi/acconfig.h                           |    2 
 include/acpi/acdispat.h                           |    2 
 include/acpi/acglobal.h                           |   26 
 include/acpi/acinterp.h                           |    5 
 include/acpi/aclocal.h                            |   36 
 include/acpi/acmacros.h                           |    2 
 include/acpi/acobject.h                           |    8 
 include/acpi/acpi_bus.h                           |    2 
 include/acpi/acpi_drivers.h                       |   17 
 include/acpi/acpiosxf.h                           |   40 
 include/acpi/actypes.h                            |   49 
 include/acpi/platform/aclinux.h                   |    2 
 include/acpi/processor.h                          |    1 
 include/linux/cpufreq.h                           |    6 
 include/linux/kobject.h                           |    2 
 lib/kobject_uevent.c                              |    4 
 74 files changed, 2637 insertions(+), 2642 deletions(-)

through these commits:

Andreas Mohr:
      ACPI: restore comment justifying 'extra' P_LVLx access

Andrew Morton:
      ACPI: asus_acpi_init: propagate correct return value

Bartlomiej Swiercz:
      ACPI: additional blacklist entry for ThinkPad R40e

Bjorn Helgaas:
      ACPI: acpi_os_wait_semaphore(): silence complaint

Bob Moore:
      ACPI: ACPICA 20060623

Dominik Brodowski:
      ACPI: C-States: accounting of sleep states
      ACPI: C-States: bm_activity improvements
      ACPI: C-States: only demote on current bus mastering activity

Jae-hyeon Park:
      ACPI: Device [kobj-name] is not power manageable

Kristen Accardi:
      KEVENT: add new uevent for dock
      ACPI: dock driver
      ACPIPHP: use ACPI dock driver
      ACPIPHP: prevent duplicate slot numbers when no _SUN

Len Brown:
      ACPI: un-export ACPI_WARNING() -- use printk(KERN_WARNING...)
      ACPI: un-export ACPI_ERROR() -- use printk(KERN_ERR...)
      ACPI: static-ize handle_hotplug_event_func()

Patrick Mochel:
      ACPI: delete tracing macros from drivers/acpi/*.c

Thomas Renninger:
      ACPI: Enable ACPI error messages w/o CONFIG_ACPI_DEBUG
      ACPI: Export symbols for ACPI_ERROR/EXCEPTION/WARNING macros
      [ACPI] Print error message if remove/install notify handler fails

Venkatesh Pallipadi:
      ACPI: HW P-state coordination support

Vladimir Lebedev:
      ACPI: fix battery on HP NX6125

with this log:

commit d120cfb544ed6161b9d32fb6c4648c471807ee6b
Merge: 9dce0e9... bf7e851...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 29 19:57:46 2006 -0400

    merge linus into release branch
    
    Conflicts:
    
    	drivers/acpi/acpi_memhotplug.c

commit 9dce0e950dbfab4148f35ac6f297d8638cdc63c4
Merge: f1b2ad5... 967440e...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 29 19:55:27 2006 -0400

    Pull acpica into release branch

commit f1b2ad5d2a8e1791d806ef244164d19c3d5c8b83
Merge: a51a69c... c4a001b...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 29 15:58:09 2006 -0400

    Pull c-states into release branch

commit a51a69c0ed955f4fa6f64b4377378c744f9b737b
Merge: 49fee98... f831335...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jun 29 15:57:42 2006 -0400

    Pull trivial into release branch

commit 49fee981fa98f3c0a21f3d6c8193eddcc15e84e9
Author: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Date:   Tue Jun 20 16:46:00 2006 -0400

    ACPI: fix battery on HP NX6125
    
    EC problem was cause of both battery and AC issues.
    http://bugzilla.kernel.org/show_bug.cgi?id=6455
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f831335d42a9aed26449a264266763fb542dbbe3
Author: Bartlomiej Swiercz <swierczu@dmcs.p.lodz.pl>
Date:   Mon May 29 07:16:00 2006 -0400

    ACPI: additional blacklist entry for ThinkPad R40e
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b488f02156d3deb08f5ad7816d565c370a8cc6f1
Author: Andreas Mohr <[andi@rhlx01.fht-esslingen.de]>
Date:   Mon Jun 26 15:58:00 2006 -0400

    ACPI: restore comment justifying 'extra' P_LVLx access
    
    While trying to look for superfluous I/O accesses that can be optimized
    away, I stumbled upon this ACPI sleep I/O access and couldn't figure out
    why the hell this dummy op was necessary.
    After more than one hour of internet research, I had collected a sufficient
    number of documents (among those very old kernel versions) that finally
    told me what this dummy read was about: STPCLK# doesn't get asserted in time
    on (some) chipsets, which is why we need to have a dummy I/O read to delay
    further instruction processing until the CPU is fully stopped.
    
    Signed-off-by: Andreas Mohr <andi@lisas.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c4a001b1ea32e09f7556178249b8885418858b5c
Author: Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Sat Jun 24 19:37:00 2006 -0400

    ACPI: C-States: only demote on current bus mastering activity
    
    Only if bus master activity is going on at the present, we should avoid
    entering C3-type sleep, as it might be a faulty transition.  As long as the
    bm_activity bitmask was based on the number of calls to the ACPI idle
    function, looking at previous moments made sense.  Now, with it being based on
    what happened this jiffy, looking at this jiffy should be sufficient.
    
    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c5ab81ca01ad4a8870b456f93dd2fb3d815f91d9
Author: Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Sat Jun 24 19:37:00 2006 -0400

    ACPI: C-States: bm_activity improvements
    
    Do not assume there was bus mastering activity if the idle handler didn't get
    called, as there's only reason to not enter C3-type sleep if there is bus
    master activity going on.  Only for the "promotion" into C3-type sleep bus
    mastering activity is taken into account, and there only current bus mastering
    activity, and not pure guessing should lead to the decision on whether to
    enter C3-type sleep or not.
    
    Also, as bm_activity is a jiffy-based bitmask (bit 0: bus mastering activity
    during this juffy, bit 31: bus mastering activity 31 jiffies ago), fix the
    setting of bit 0, as it might be called multiple times within one jiffy.
    
    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a3c6598f92cf27d3d201a2a5b052563148156837
Author: Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Sat Jun 24 19:37:00 2006 -0400

    ACPI: C-States: accounting of sleep states
    
    Track the actual time spent in C-States (C2 upwards, we can't determine this
    for C1), not only the number of invocations.  This is especially useful for
    dynamic ticks / "tickless systems", but is also of interest on normal systems,
    as any interrupt activity leads to C-States being exited, not only the timer
    interrupt.
    
    The time is being measured in PM timer ticks, so an increase by one equals 279
    nanoseconds.
    
    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 967440e3be1af06ad4dc7bb18d2e3c16130fe067
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jun 23 17:04:00 2006 -0400

    ACPI: ACPICA 20060623
    
    Implemented a new acpi_spinlock type for the OSL lock
    interfaces.  This allows the type to be customized to
    the host OS for improved efficiency (since a spinlock is
    usually a very small object.)
    
    Implemented support for "ignored" bits in the ACPI
    registers.  According to the ACPI specification, these
    bits should be preserved when writing the registers via
    a read/modify/write cycle. There are 3 bits preserved
    in this manner: PM1_CONTROL[0] (SCI_EN), PM1_CONTROL[9],
    and PM1_STATUS[11].
    http://bugzilla.kernel.org/show_bug.cgi?id=3691
    
    Implemented the initial deployment of new OSL mutex
    interfaces.  Since some host operating systems have
    separate mutex and semaphore objects, this feature was
    requested. The base code now uses mutexes (and the new
    mutex interfaces) wherever a binary semaphore was used
    previously. However, for the current release, the mutex
    interfaces are defined as macros to map them to the
    existing semaphore interfaces.
    
    Fixed several problems with the support for the control
    method SyncLevel parameter. The SyncLevel now works
    according to the ACPI specification and in concert with the
    Mutex SyncLevel parameter, since the current SyncLevel is
    a property of the executing thread. Mutual exclusion for
    control methods is now implemented with a mutex instead
    of a semaphore.
    
    Fixed three instances of the use of the C shift operator
    in the bitfield support code (exfldio.c) to avoid the use
    of a shift value larger than the target data width. The
    behavior of C compilers is undefined in this case and can
    cause unpredictable results, and therefore the case must
    be detected and avoided.  (Fiodor Suietov)
    
    Added an info message whenever an SSDT or OEM table
    is loaded dynamically via the Load() or LoadTable()
    ASL operators. This should improve debugging capability
    since it will show exactly what tables have been loaded
    (beyond the tables present in the RSDT/XSDT.)
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 95b38b3f453c16de0f8cddcde3e71050bbfb37b9
Author: Kristen Accardi <kristen.c.accardi@intel.com>
Date:   Wed Jun 28 03:09:54 2006 -0400

    ACPIPHP: prevent duplicate slot numbers when no _SUN
    
    Dock bridges generally do not implement _SUN, yet show up as ejectable
    slots.  If you have more than one ejectable slot that does not implement
    SUN, with the current code you will get duplicate slot numbers.  So, if
    there is no _SUN, use the current count of the number of slots found
    instead.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2b85e1307fe3a84eca2e1a21c6c857359908dab4
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jun 27 01:50:14 2006 -0400

    ACPI: static-ize handle_hotplug_event_func()
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4e8662bbd680c54496189ac68f398e847f3ca374
Author: Kristen Accardi <kristen.c.accardi@intel.com>
Date:   Wed Jun 28 03:08:06 2006 -0400

    ACPIPHP: use ACPI dock driver
    
    Modify the acpiphp driver to use the ACPI dock driver for dock
    notifications.  Only load the acpiphp driver if we find we have pci dock
    devices.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a5e1b94008f2a96abf4a0c0371a55a56b320c13e
Author: Kristen Accardi <kristen.c.accardi@intel.com>
Date:   Wed Jun 28 03:07:16 2006 -0400

    ACPI: dock driver
    
    Create a driver which lives in the acpi subsystem to handle dock events.
    This driver is not an "ACPI" driver, because acpi drivers require that the
    object be present when the driver is loaded.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Cc: Dave Hansen <haveblue@us.ibm.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a6a888b3c20cf559c8a2e6e4d86c570dda2ef0f5
Author: Kristen Accardi <kristen.c.accardi@intel.com>
Date:   Sat Jun 24 19:36:00 2006 -0400

    KEVENT: add new uevent for dock
    
    so that userspace can be notified of dock and undock events.
    
    Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5e7d8818114f08ad9078d2c1a8a88d78d49de8dc
Author: Andrew Morton <akpm@osdl.org>
Date:   Sat Jun 24 19:36:00 2006 -0400

    ACPI: asus_acpi_init: propagate correct return value
    
    Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Acked-by: Francois Romieu <romieu@fr.zoreil.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e8406b4485730031d91872086456bd052948686b
Author: Thomas Renninger <trenn@suse.de>
Date:   Fri Jun 2 15:58:00 2006 -0400

    [ACPI] Print error message if remove/install notify handler fails
    
    Signed-off-by: Thomas Renniger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d550d98d3317378d93a4869db204725d270ec812
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Tue Jun 27 00:41:40 2006 -0400

    ACPI: delete tracing macros from drivers/acpi/*.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d7fa2589bbe7ab53fd5eb20e8c7e388d5aff6f16
Merge: 6468463... 46f18e3...
Author: Thomas Renninger <trenn@suse.de>
Date:   Tue Jun 27 00:06:37 2006 -0400

    Pull bugzilla-5737 into release branch

commit 6468463abd7051fcc29f3ee7c931f9bbbb26f5a4
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jun 26 23:41:38 2006 -0400

    ACPI: un-export ACPI_ERROR() -- use printk(KERN_ERR...)
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cece92969762b8ed7930d4e23008b76b06411dee
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jun 26 23:04:31 2006 -0400

    ACPI: un-export ACPI_WARNING() -- use printk(KERN_WARNING...)
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 64dedfb8fdbbc4fabb8c131e4b597cd4bc7f3881
Author: Jae-hyeon Park <hpark@tuhep.phys.tohoku.ac.jp>
Date:   Mon Jun 26 22:34:03 2006 -0400

    ACPI: Device [kobj-name] is not power manageable
    
    print kobj name in this message.
    lenb changed to use printk.
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9e7e2c047503db5a094ab30c7b4b8a5a0a324915
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Thu Apr 27 05:25:00 2006 -0400

    ACPI: acpi_os_wait_semaphore(): silence complaint
    
    The ASL Acquire operator (17.5.1 in ACPI 3.0 spec) is allowed to time out
    and return True without acquiring the semaphore.  There's no indication in
    the spec that this is an actual error, so this message should be
    debug-only, as the message for successful acquisition is.
    
    This used to be an ACPI_DEBUG_PRINT, but it was mis-classified as
    ACPI_DB_ERROR rather than ACPI_DB_MUTEX, so it got swept up in Thomas'
    recent patch to enable ACPI error messages even without CONFIG_ACPI_DEBUG.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit be63c925a123b492fc05063c98ca7e9f7453a58a
Author: Thomas Renninger <trenn@suse.de>
Date:   Fri Jun 2 15:58:00 2006 -0400

    ACPI: Export symbols for ACPI_ERROR/EXCEPTION/WARNING macros
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a6fc67202e0224e6c9d1d285cc0b444bce887ed5
Author: Thomas Renninger <trenn@suse.de>
Date:   Mon Jun 26 23:58:43 2006 -0400

    ACPI: Enable ACPI error messages w/o CONFIG_ACPI_DEBUG
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 46f18e3a28295a9e11a6ffa4478241c19bc93735
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Jun 26 00:34:43 2006 -0400

    ACPI: HW P-state coordination support
    
    Treat HW coordination as independent CPUs.
    This enables per-cpu monintoring of P-states
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
