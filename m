Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVGILEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVGILEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVGILEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:04:12 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:7106 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261177AbVGILEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:04:10 -0400
Date: Sat, 9 Jul 2005 12:04:07 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] DRM fixes/cleanups tree
Message-ID: <Pine.LNX.4.58.0507091202460.6297@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you please pull the 'drm-fixes' tree from
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This tree contains the following patches:

commit 850eb83a6a21b086624b227653ce90ad927ba423
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jul 7 21:09:14 2005 +1000

    drm: wrap config.h include in a ifdef KERNEL

    This file can be included from userspace so wrap the config.h include.

    Signed-off-by: David Airlie <airlied@linux.ie>

commit c94f70298529d99ac6e1ee7709f61eab00adeb39
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jul 7 21:03:38 2005 +1000

    drm: misc cleanup

    This patch contains the following cleanups:
    - make needlessly global functions static
    - remove the following unused global functions:
     - drm_fops.c: drm_read
     - i915_dma.c: i915_do_cleanup_pageflip

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b9523249de59c49e7c2cc83dfa73fb011a489a45
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jul 7 20:33:26 2005 +1000

    drm: use kcalloc now that it is available..

    Make the DRM drm_calloc call kcalloc now.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f650130803c4c0b5e5d76eff24faae722e3a69e2
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jul 7 20:17:42 2005 +1000

    drm: ctx release can happen before dev->ctxlist is allocated

    From: Jon Smirl <jonsmirl@gmail.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 0c7b525c344bc29a760c37053f8d5c80292ee1be
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Jul 7 20:16:08 2005 +1000

    drm: fix minor issues caused by core conversion

    The conversion to core/driver got this check in-correct.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

 ati_pcigart.c |    2 -
 drm.h         |    2 +
 drmP.h        |   30 ++++--------------
 drm_auth.c    |    4 +-
 drm_bufs.c    |   12 +++----
 drm_context.c |    4 +-
 drm_drv.c     |    9 +++--
 drm_fops.c    |   14 +++-----
 drm_irq.c     |    2 -
 drm_lock.c    |   12 +++++--
 drm_memory.c  |   13 --------
 drm_proc.c    |    2 -
 drm_stub.c    |   92 ++++++++++++++++++++++++++++------------------------------
 drm_vm.c      |   10 +++---
 i810_dma.c    |   24 +++++++--------
 i810_drv.h    |    1
 i830_dma.c    |   20 ++++++------
 i830_drv.c    |    2 -
 i830_drv.h    |    2 -
 i830_irq.c    |    5 +--
 i915_dma.c    |   60 +++++++++++++++----------------------
 i915_drv.c    |    2 -
 i915_drv.h    |   10 ------
 i915_irq.c    |    4 +-
 r128_state.c  |    2 -
 25 files changed, 146 insertions(+), 194 deletions(-)
