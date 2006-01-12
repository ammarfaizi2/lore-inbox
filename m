Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWALJx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWALJx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWALJx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:53:58 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:18628 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030284AbWALJx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:53:57 -0500
Date: Thu, 12 Jan 2006 09:52:46 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] drm tree for 2.6.16-rc1
Message-ID: <Pine.LNX.4.58.0601120948270.1552@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you pull the drm-forlinus branch from
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This is a pretty major merge over of DRM CVS, and every driver in the DRM
is brought up to latest versions.... along with a lot of interface
renaming that makes the driver interface easier to understand (it used to
use the same names as the old macro interface)..

Regards,
Dave.

 b/drivers/char/drm/Makefile           |    4
 b/drivers/char/drm/ati_pcigart.c      |   23
 b/drivers/char/drm/drm.h              |    4
 b/drivers/char/drm/drmP.h             |  122 +++--
 b/drivers/char/drm/drm_agpsupport.c   |  133 +++--
 b/drivers/char/drm/drm_bufs.c         |   49 +-
 b/drivers/char/drm/drm_context.c      |    2
 b/drivers/char/drm/drm_core.h         |    4
 b/drivers/char/drm/drm_drv.c          |  152 +++---
 b/drivers/char/drm/drm_fops.c         |  317 +++++++------
 b/drivers/char/drm/drm_ioctl.c        |   27 -
 b/drivers/char/drm/drm_lock.c         |    1
 b/drivers/char/drm/drm_memory.c       |    8
 b/drivers/char/drm/drm_memory_debug.h |  269 +++++------
 b/drivers/char/drm/drm_os_linux.h     |    1
 b/drivers/char/drm/drm_pciids.h       |   12
 b/drivers/char/drm/drm_proc.c         |   16
 b/drivers/char/drm/drm_stub.c         |   63 --
 b/drivers/char/drm/drm_sysfs.c        |   66 +-
 b/drivers/char/drm/i810_dma.c         |   49 +-
 b/drivers/char/drm/i810_drv.c         |   60 --
 b/drivers/char/drm/i810_drv.h         |   10
 b/drivers/char/drm/i830_dma.c         |   47 +
 b/drivers/char/drm/i830_drv.c         |   59 --
 b/drivers/char/drm/i830_drv.h         |    8
 b/drivers/char/drm/i915_dma.c         |   52 +-
 b/drivers/char/drm/i915_drm.h         |    6
 b/drivers/char/drm/i915_drv.c         |   66 --
 b/drivers/char/drm/i915_drv.h         |   44 +
 b/drivers/char/drm/i915_irq.c         |   48 +-
 b/drivers/char/drm/i915_mem.c         |    5
 b/drivers/char/drm/mga_dma.c          |  160 ++++--
 b/drivers/char/drm/mga_drv.c          |   58 --
 b/drivers/char/drm/mga_drv.h          |   14
 b/drivers/char/drm/mga_state.c        |   26 -
 b/drivers/char/drm/r128_cce.c         |   15
 b/drivers/char/drm/r128_drm.h         |    4
 b/drivers/char/drm/r128_drv.c         |   48 --
 b/drivers/char/drm/r128_drv.h         |    8
 b/drivers/char/drm/r128_irq.c         |    4
 b/drivers/char/drm/r128_state.c       |   42 -
 b/drivers/char/drm/r300_cmdbuf.c      |   38 -
 b/drivers/char/drm/r300_reg.h         |    1
 b/drivers/char/drm/radeon_cp.c        |  106 ++--
 b/drivers/char/drm/radeon_drm.h       |    6
 b/drivers/char/drm/radeon_drv.c       |   62 +-
 b/drivers/char/drm/radeon_drv.h       |   41 -
 b/drivers/char/drm/radeon_state.c     |  246 ++++------
 b/drivers/char/drm/savage_bci.c       |   81 +--
 b/drivers/char/drm/savage_drv.c       |   50 --
 b/drivers/char/drm/savage_drv.h       |   29 -
 b/drivers/char/drm/savage_state.c     |  324 ++++++-------
 b/drivers/char/drm/sis_drm.h          |   25 +
 b/drivers/char/drm/sis_drv.c          |   42 -
 b/drivers/char/drm/sis_drv.h          |    4
 b/drivers/char/drm/sis_ds.h           |    7
 b/drivers/char/drm/sis_mm.c           |   30 -
 b/drivers/char/drm/tdfx_drv.c         |   42 -
 b/drivers/char/drm/tdfx_drv.h         |    7
 b/drivers/char/drm/via_dma.c          |   38 +
 b/drivers/char/drm/via_dmablit.c      |  805 ++++++++++++++++++++++++++++++++++
 b/drivers/char/drm/via_dmablit.h      |  140 +++++
 b/drivers/char/drm/via_drm.h          |   58 +-
 b/drivers/char/drm/via_drv.c          |   63 --
 b/drivers/char/drm/via_drv.h          |   56 +-
 b/drivers/char/drm/via_ds.c           |    9
 b/drivers/char/drm/via_irq.c          |   53 +-
 b/drivers/char/drm/via_map.c          |   47 +
 b/drivers/char/drm/via_mm.c           |   20
 b/drivers/char/drm/via_verifier.c     |    6
 b/drivers/char/drm/via_verifier.h     |    4
 b/drivers/char/drm/via_video.c        |    7
 drivers/char/drm/drm_init.c           |   53 --

 73 files changed, 2794 insertions(+), 1812 deletions(-)
commit 9c7d462eda13ca211b7b4a62f191f4cfda135e2d
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jan 12 20:44:30 2006 +1100

    drm: fix issues with systems with no MTRR

    On systems with no MTRR we should still define the interface.

    Original bug from apkm.
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit aab8df141fdc4c4c9587521a24b6865390eaeb79
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 11 22:32:51 2006 +1100

    drm: cleanup properly on drm module unload

    Cleanup multiple cards properly

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 8d2ea6258123d7a92a1f6ec638a8cad4a0604c43
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Wed Jan 11 20:48:09 2006 +1100

    drm: fixup drm bufs being just under the EOM

    If the mapping was just under the end of memory it would fail.
    Lets DRM start on my PCI card.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f8e0f2905bf0a7cb5ef2baaf009f0c26f80c3056
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Jan 10 19:56:17 2006 +1100

    drm: fix radeon warnings on 64-bit

    From: Andrew Morton <akpm@osdl.org>

    drivers/char/drm/radeon_state.c: In function `radeon_cp_dispatch_texture':
    drivers/char/drm/radeon_state.c:1653: warning: int format, different type arg
    (arg 3)
    drivers/char/drm/radeon_state.c:1661: warning: int format, different type arg
    (arg 3)
    drivers/char/drm/radeon_state.c:1689: warning: int format, different type arg
    (arg 3)

    sizeof() doesn't return an int.

    Cc: Dave Airlie <airlied@linux.ie>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2185200cd2a910ca7f4e3fa0370c6ed8a2bdc49c
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Jan 10 19:53:54 2006 +1100

    drm: fix warning on alpha

    From: Andrew Morton <akpm@osdl.org>

    On alpha:

    drivers/char/drm/via_dmablit.h:44: error: field `direction' has incomplete type

    Cc: Dave Airlie <airlied@linux.ie>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 4e4c62bd45c40e8e04d09a5f383bffb149abaa63
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Jan 3 22:25:29 2006 +1100

    drm: remove is_pci flag completely...

    this snuck back in, in the last merge.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 97f2aab6698f3ab2552c41c1024a65ffd0763a6d
Merge: d985c1088146607532093d9eaaaf99758f6a4d21 88026842b0a760145aa71d69e74fbc9ec118ca44
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Jan 3 18:18:01 2006 +1100

    drm: merge in Linus mainline

commit d985c1088146607532093d9eaaaf99758f6a4d21
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 21:32:48 2006 +1100

    drm: major update from CVS for radeon and core

    This patch pull in a lot of changes from CVS to the main core DRM,
    and updates the radeon driver to 1.21.0 that supports r300 texrect
    and radeon card type ioctl.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b0cae664ebc85f2431c5a7c9e192a2a2ef72ecc7
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 21:23:07 2006 +1100

    drm: update drm pci ids list

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit fe34765be1ee9465b10406e6e5dddbd43ddc4fbe
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 21:19:39 2006 +1100

    drm: drm_ioctl.c sync with fixes from CVS

    Apply the fixes from CVS that were outstanding for this file

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b3a80a223d5f1af1e1713383376e5472cec4e20c
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 21:15:01 2006 +1100

    drm: update lock flags from userspace

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 0d6aa60b4ac9689b750e35cd66f5d7c053aff0f4
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 20:14:23 2006 +1100

    drm: update to i915 1.3.0

    Add support for vblank ioctls to i915 driver

    From: Dave Airlie <airlied@linux.ie>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f0c408b564ddefa0959ada4e2c2248f4a57f1842
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 19:52:09 2006 +1100

    drm: update drm_memory_debug.h

    Update from DRM CVS for drm memory debug

    From: Jon Smirl <jonsmirl@gmail.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 1e7d51902a8bd08e37113aaf182d12233b157151
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 19:25:35 2006 +1100

    drm: proper fix for drm_context

    Bad patch in last version

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b5e9fc13dd0f25a2f422000c185f491bfd4f7335
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 19:23:44 2006 +1100

    drm: fix issue with contexts running out of RAM

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f26c473cdf557ea6e8f267d34eee82d30473a363
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 17:18:39 2006 +1100

    drm: update PCIGART support from CVS

    In order to work on FreeBSD the gart needed to use a local mapping
    This patch moves the mainline to the new code and aligns some comment
    changes

    From: Eric Anholt <anholt@freebsd.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 0a406877e638a6f43ed4591bb08d528415d7d53a
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 16:49:02 2006 +1100

    drm: remove old reclaim_buffers from ix0 drivers

    From: Dave Airlie <airlied@linux.ie>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 269dc51296f4e985741d2fd567e7be4e7a0a9f29
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 16:23:01 2006 +1100

    drm: bring savage inline with latest CVS

    apply some whitespace cleanup and add wrappers for MTRR for OS calls

    From: Eric Anholt <anholt@freebsd.org> + Dave Airlie <airlied@linux.ie>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 3528af1b189d0fbb4c7a3f121f46d9987b9af5b6
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 16:11:44 2006 +1100

    drm: fix a LOR issue on FreeBSD for savage driver

    Correct a LOR issue on FreeBSD by allocating temporary space and doing a single
    DRM_COPY_FROM_USER rather than DRM_VERIFYAREA_READ followed by tons of
    DRM_COPY_FROM_USER_UNCHECKED.  I don't like the look of the temporary space
    allocation, but I like the simplification in the rest of the file.  Tested
    with glxgears, tuxracer, and q3 on a savage4.

    From: Eric Anholt <anholt@freebsd.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 952d751a140e961f7ac67f743cf94d1a37c736e8
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 14:44:12 2006 +1100

    drm: bring sis + tdfx up to latest CVS

    Cleanup SIS + TDFX drivers with latest changes from CVS.

    From: Eric Anholt <anholt@freebsd.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 443448d05468277abe99c9b24b9df538dd840f35
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 14:26:20 2006 +1100

    drm: via driver update to CVS version

    This updates the DRM via driver to the latest CVS version, which contains
    support for DMA blitting.

    It also contains some whitespace and other minor fixes

    From: Thomas Hellstrom <unichrome@shipmail.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit a7a2cc315c8a5e51b08538d102ec3229c966ac87
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Jan 2 13:54:04 2006 +1100

    drm: move ioctl flags to a bit field of flags

    From: Dave Airlie

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 925142431bd653175b80ae153bd7a8bc13628bde
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sat Nov 12 21:52:46 2005 +1100

    drm: update VIA driver to 2.7.2

    Add PCI DMA blitengine to VIA DRM
    Add portability code for porting VIA to FreeBSD.
    Sync via_drm.h with 3d driver

    From: Thomas Hellstrom <unichrome@shipmail.org>, Eric Anholt <anholt@freebsd.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 792d2b9a12594522111fbe2a7f17460a4d7edff7
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 23:30:27 2005 +1100

    drm: drop mtrr from i915

    Alan Hourihane wants to set MTRR in the DDX only as otherwise
    we get problems with the shared memory chipset.

    From: Alan Hourihane <alanh@fairlite.demon.co.uk>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 7ccf800e9415daf9214eb667318e356f9a3d81fc
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 23:11:34 2005 +1100

    drm: update mga driver for new bootstrap code

    The MGA driver needs to use the full AGP interface.

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit c0be4d240483f3ebd138db467b5e8fbe15c520e2
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 23:10:18 2005 +1100

    drm: remove exports that modules shouldn't use.

    Modules should go via the new drm_agp_ functions.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit efa58395bee82dc5a87805e7eb7c710e88eb4bd7
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 22:33:39 2005 +1100

    drm: add in-kernel entry points for rest of AGP ioctls

    Allow DRM modules to call AGP internally in the kernel.

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 732052ed3e7539d87136dd833be523747af3fb3e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 22:07:35 2005 +1100

    drm: simplify sysfs code for drm

    This simplifies the sysfs code for the drm and add a dri_library_name
    attribute which can be used by a userspace app to figure out which
    library to load.

    From: Jon Smirl <jonsmirl@gmail.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit e96e33eeb8b876c7ec009c557ca5269328eceda0
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 20:27:35 2005 +1100

    drm: fixup drm_proc.c struct table

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 61d04160ff89514919ef95b0d10bee706f569925
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 19:52:22 2005 +1100

    drm: remove old backwards compatibilty stuff

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 8f5f39f77f5a6053ae287d4673028e7a69335f5e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 19:40:52 2005 +1100

    drm: remove drm_flush

    drm_flush is no longer needed remove.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 7052cff984ba575926bb7d2ae5454cce531a97e1
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 19:34:47 2005 +1100

    drm: cleanup via_ds.c includes

    Remove the linux includes from via_ds.c

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 9d6160137a8ef8bd25266ccc0f97d55863708fc6
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Nov 11 19:34:10 2005 +1100

    drm: remove remnamt of old DRM code from tdfx

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 3f9df54d6386bb632ffc00665489bb3bb3bf6ff2
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Nov 10 22:28:56 2005 +1100

    drm: remove drm_init.c it is no longer needed

    Move drm_cpu_valid into drm_fops.c

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 22eae947bf76e236ba972f2f11cfd1b083b736ad
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Nov 10 22:16:34 2005 +1100

    drm: rename driver hooks more understandably

    Rename the driver hooks in the DRM to something a little more understandable:
    preinit         ->      load
    postinit        ->      (removed)
    presetup        ->      firstopen
    postsetup       ->      (removed)
    open_helper     ->      open
    prerelease      ->      preclose
    free_filp_priv  ->      postclose
    pretakedown     ->      lastclose
    postcleanup     ->      unload
    release         ->      reclaim_buffers_locked
    version         ->      (removed)

    postinit and version were replaced with generic code in the Linux DRM (drivers
    now set their version numbers and description in the driver structure, like on
    BSD).  postsetup wasn't used at all.  Fixes the savage hooks for
    initializing and tearing down mappings at the right times.  Testing involved at
    least starting X, running glxgears, killing glxgears, exiting X, and repeating.

    Tested on:      FreeBSD (g200, g400, r200, r128)
                    Linux (r200, savage4)

    From: Eric Anholt <anholt@freebsd.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

