Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWI3ChU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWI3ChU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 22:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWI3ChU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 22:37:20 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:20459 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750732AbWI3ChS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 22:37:18 -0400
Date: Sat, 30 Sep 2006 03:37:16 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [resend] [git pull] drm tree for 2.6.19-rc1 
Message-ID: <Pine.LNX.4.64.0609300336000.4402@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="29444707-1161863009-1159184844=:17428"
Content-ID: <Pine.LNX.4.64.0609300336030.4402@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--29444707-1161863009-1159184844=:17428
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0609280114591.29178@skynet.skynet.ie>


Hi Linus,

This is the DRM tree, the main work is the addition of simpler clean memory
manager which fixes a lot of problems for Via and Sis users and the Intel
965 support.

Please pull from 'drm-patches' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git drm-patches

to receive the following updates:

  drivers/char/drm/Kconfig        |    9 -
  drivers/char/drm/Makefile       |    6
  drivers/char/drm/drmP.h         |   68 ++++-
  drivers/char/drm/drm_auth.c     |   64 +----
  drivers/char/drm/drm_bufs.c     |   74 +++---
  drivers/char/drm/drm_drv.c      |   12 +
  drivers/char/drm/drm_fops.c     |   10 -
  drivers/char/drm/drm_hashtab.c  |  190 +++++++++++++++
  drivers/char/drm/drm_hashtab.h  |   67 +++++
  drivers/char/drm/drm_ioc32.c    |    2
  drivers/char/drm/drm_ioctl.c    |   34 ++-
  drivers/char/drm/drm_irq.c      |   12 +
  drivers/char/drm/drm_mm.c       |  201 ++++++++++++++++
  drivers/char/drm/drm_pciids.h   |  187 ++++++++------
  drivers/char/drm/drm_proc.c     |    2
  drivers/char/drm/drm_sman.c     |  352 +++++++++++++++++++++++++++
  drivers/char/drm/drm_sman.h     |  176 ++++++++++++++
  drivers/char/drm/drm_stub.c     |   12 -
  drivers/char/drm/drm_vm.c       |   45 +--
  drivers/char/drm/i810_dma.c     |   10 -
  drivers/char/drm/i830_dma.c     |    4
  drivers/char/drm/i915_dma.c     |   45 +++
  drivers/char/drm/i915_drm.h     |    6
  drivers/char/drm/i915_drv.h     |   10 -
  drivers/char/drm/i915_irq.c     |   16 +
  drivers/char/drm/radeon_cp.c    |   72 +++---
  drivers/char/drm/radeon_drv.c   |    2
  drivers/char/drm/radeon_drv.h   |   36 ++-
  drivers/char/drm/radeon_state.c |   48 ++--
  drivers/char/drm/sis_drv.c      |   39 +++
  drivers/char/drm/sis_drv.h      |   34 ++-
  drivers/char/drm/sis_ds.c       |  299 -----------------------
  drivers/char/drm/sis_ds.h       |  146 -----------
  drivers/char/drm/sis_mm.c       |  504 +++++++++++++++++----------------------
  drivers/char/drm/via_dmablit.c  |   68 +++--
  drivers/char/drm/via_drm.h      |    8 +
  drivers/char/drm/via_drv.c      |    3
  drivers/char/drm/via_drv.h      |   16 +
  drivers/char/drm/via_ds.c       |  273 ---------------------
  drivers/char/drm/via_ds.h       |  104 --------
  drivers/char/drm/via_map.c      |    9 +
  drivers/char/drm/via_mm.c       |  375 +++++++++--------------------
  42 files changed, 1878 insertions(+), 1772 deletions(-)
  create mode 100644 drivers/char/drm/drm_hashtab.c
  create mode 100644 drivers/char/drm/drm_hashtab.h
  create mode 100644 drivers/char/drm/drm_mm.c
  create mode 100644 drivers/char/drm/drm_sman.c
  create mode 100644 drivers/char/drm/drm_sman.h
  delete mode 100644 drivers/char/drm/sis_ds.c
  delete mode 100644 drivers/char/drm/sis_ds.h
  delete mode 100644 drivers/char/drm/via_ds.c
  delete mode 100644 drivers/char/drm/via_ds.h

Adrian Bunk:
       drm: cleanups

Alan Hourihane:
       drm: Add support for Intel i965G chipsets.

Andrew Morton:
       drm: remove FALSE/TRUE that snuck in with simple memory manager changes.
       drm: fix i965 build bug

Chuck Short:
       drm: allow detection of new VIA chipsets

Dave:
       drm: remove local copies of pci bus/slot/func

Dave Airlie:
       drm: cleanup old compat code and DRM fns from Linux only code
       drm: remove the DRM pci domain
       drm: Add the P4VM800PRO (?) PCI ID.
       drm: fix return value in auth function
       drm: remove a tab that snuck in
       drm: add better explanation for i830/i915
       drm: realign via driver with drm git tree
       drm: realign sosme radeon code with drm git tree
       drm: fixup i915 error codes
       drm: fixup setversion return codes..
       drm: domain changes broke ppc r200
       drm: use radeon specific names for radeon flags

Denis Vlasenko:
       drm: i810_dma.c: fix pointer arithmetic for 64-bit target

Eric Anholt:
       drm: add device/vendor id to drm_device_t for compat with FreeBSD drivers

Michel Daenzer:
       drm: fd.o Bug #7595: Avoid u32 overflows in 
radeon_check_and_fixup_offset().
       drm: Use register writes instead of BITBLT_MULTI packets for buffer swap 
blits

Michel Dänzer:
       drm: radeon: add some debug output when getparam is called with unknown
       drm: radeon: implement RADEON_PARAM_SCRATCH_OFFSET getparam
       drm: radeon: fix up bus mastering when writeback is disabled
       drm: radeon: Use RADEON_RB3D_DSTCACHE_CTLSTAT instead of 
RADEON_RB2D_DSTCACHE_CTLSTAT.

Thomas Hellstrom:
       drm: missing mutex unlock
       drm: add simple DRM memory manager, and hash table
       drm: add drm simple memory manager support for SiS and VIA drivers
       drm: move drm authentication to new generic hash table.
       drm: update user token hashing and map handles
       drm: SiS 315 Awareness.
       drm: avoid kernel oops in some error paths calling drm_lastclose
       drm: remove hash tables on drm exit
       drm: Fix hashtab implementation leaking illegal error codes to user 
space.
       drm: allow multiple addMaps with the same 32-bit map offsset.
--29444707-1161863009-1159184844=:17428--
