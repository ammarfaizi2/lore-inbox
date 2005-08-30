Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVH3JTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVH3JTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVH3JTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:19:04 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:61879 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751294AbVH3JTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:19:02 -0400
Date: Tue, 30 Aug 2005 10:18:49 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: [git tree] DRM tree for 2.6.14 (fwd)
Message-ID: <Pine.LNX.4.58.0508301018330.1102@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI.. I cc'ed the wrong list.. doh..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


---------- Forwarded message ----------
Date: Tue, 30 Aug 2005 10:18:19 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@csn.ul.ie
Subject: [git tree] DRM tree for 2.6.14


Hi Linus,
	Please pull the drm-latest branch from
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

The tree contains the following patches:

commit 7a9aff3cff807261e476a1719273a4ac5d254ecb
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Aug 23 12:15:43 2005 +1000

    drm: fix a bad VERSION check.

    I found why my G5 was crashing when using the linux-2.6 version of the
    DRM + git-drm.patch from 2.6.13-rc6-mm1, but not with the CVS DRM.
    The reason was that dev->agp->cant_use_aperture wasn't getting set,
    and the reason for that was that <linux/version.h> no longer gets
    included and the #if LINUX_VERSION_CODE < 0x020408 in drm_agpsupport.c
    was going the wrong way.  With this patch (and a few others) a 32-bit
    server works correctly, as does DRI.

    From: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 88f399cd0a5a540db2815eee3002f8f00ef6461e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sat Aug 20 17:43:33 2005 +1000

    drm: fixes for powerpc

    Remove a bogus check on whether an area is memory (we need a better interface)
    also change pgprot flags for powerpc
    don't check on x86-64 either

    From: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit ffbbf7a3ccdcac7526296a55968e5dac0626fd9e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sat Aug 20 17:40:04 2005 +1000

    drm: add new texture upload code from r300 project

    Paul Mackerras did some new upload code for r300, I forgot to add it
    to the kernel with r300 merge.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit c8b432dc0c8d635254010513ca1a3a10a77037a1
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Aug 16 20:54:18 2005 +1000

    drm: update pci ids for savage and via

    Fixup savage and via pci ids

    From: Dave Airlie <airlied@linux.ie>

commit 414ed537995617f4cbcab65e193f26a2b2dcfa5e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Tue Aug 16 20:43:16 2005 +1000

    drm: add initial r300 3D support.

    This adds initial r300 3D support to the radeon DRM.

    From: Nicolai Haehnle, Vladimir Dergachev, and others.
    Signed-off-by: David Airlie <airlied@linux.ie>

commit 282a16749ba63256bcdce2766817f46aaac4dc20
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Aug 7 15:43:54 2005 +1000

    drm: add savage driver

    Add driver for savage chipsets.

    From: Felix Kuehling
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d27c9b548ad79c14830c57355dbe3a35f970532a
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Aug 7 15:19:58 2005 +1000

    drm: remove version.h and any version checks..

    This patch removes all the drm kernel conditionals from the kernel DRM tree.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit aa0ca6b4bb818406d4769edb9ff115500c8e4090
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Aug 5 23:09:14 2005 +1000

    drm: fix warning in drm_pci.c

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 1fad99499afdd2730adb1d53413b91580b1f0662
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Aug 5 22:40:34 2005 +1000

    drm: remove the gamma driver

    The gamma driver has been broken for quite a while, it doesn't build,
    we don't have a userspace, mine is in Ireland etc...

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit db215327c62c2db533afb322761fa04ea6244164
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Aug 5 22:13:15 2005 +1000

    drm: switch drm_handle_t to unsigned int

    This converts the drm_handle_t to unsigned int.
    This is currently safe to do as we don't pass these across the kernel/user
    boundary, but userspace does use these, but no-one builds userspace against
    the kernel headers at present so it is okay to switch over the kernel copy
    of drm.h at this point. (The CVS tree will switch over soon in sync with
    some Mesa changes)

    From: Egbert Eich <eich@suse.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d1f2b55ad2c11f46e30547a9f7754e99b478348e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Aug 5 22:11:22 2005 +1000

    drm: updated DRM map patch for 32/64 bit systems

    I basically combined Paul's patches with additions that I had made
    for PCI scatter gather.
    I also tried more carefully to avoid problems with the same token
    assigned multiple times while trying to use the base address in the
    token if possible to gain as much backward compatibility as possible
    for broken DRI clients.

    From: Paul Mackerras <paulus@samba.org> and Egbert Eich <eich@suse.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit c73681e77b40697d16ada777adf2c6dc4db05917
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Aug 5 22:02:48 2005 +1000

    drm: copy the right data back to userspace for getreserved contexts ioctl

    This fixes the information copied back to userspace by the get reserved
    contexts ioctl.

    From: Egbert Eich <eich@suse.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 24d109422787119337cd83732feef930d6a23f5c
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Aug 5 21:52:18 2005 +1000

    drm: fix ioctl direction in r128 getparam

    Set the IOWR correctly for r128 getparam.

    From: Egbert Eich <eich@suse.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 727e6e932d76f05f8691a32bbeabd1061b051a3b
Merge: bdf242eeb0f69567fe43eba93889d80ecacbfe94 889371f61fd5bb914d0331268f12432590cf7e85
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 31 13:34:09 2005 +1000

    Merge ../linux-2.6/

commit bdf242eeb0f69567fe43eba93889d80ecacbfe94
Merge: 836cf0465c422ee6d654060edd7c620d9cf0c09c b0825488a642cadcf39709961dde61440cb0731c
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sat Jul 30 14:37:43 2005 +1000

    Merge ../linux-2.6/

commit 836cf0465c422ee6d654060edd7c620d9cf0c09c
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 19:27:04 2005 +1000

    drm: cleanup buffer/map code

    This is a patch from DRM CVS that cleans up some code that was in CVS
    that I never moved to the kernel, this patch produces the result of the
    cleanups and puts it into the kernel drm.

    From: Eric Anholt <anholt@freebsd.org>, Jon Smirl, Dave Airlie
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d01cff408057fa925b2f766fa1fd5a305fd1acbf
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 19:24:35 2005 +1000

    drm: add mga driver callbacks

    Add some missing driver callback for the PCI support

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 6795c985a648d1e90b367cc1387c18205ecca4b8
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 18:20:09 2005 +1000

    Add support for PCI MGA cards to MGA DRM.

    This patch adds serveral new ioctls and a new query to get_param query to
    support PCI MGA cards.

    Two ioctls were added to implement interrupt based waiting.  With this change,
    the client-side driver no longer needs to map the primary DMA region or the
    MMIO region.  Previously, end-of-frame waiting was done by busy waiting in the
    client-side driver until one of the MMIO registers (the current DMA pointer)
    matched a pointer to the end of primary DMA space.  By using interrupts, the
    busy waiting and the extra mappings are removed.

    A third ioctl was added to bootstrap DMA.  This ioctl, which is used by the
    X-server, moves a *LOT* of code from the X-server into the kernel.  This allows
    the kernel to do whatever needs to be done to setup DMA buffers.  The entire
    process and the locations of the buffers are hidden from user-mode.

    Additionally, a get_param query was added to differentiate between G4x0 cards
    and G550 cards.  A gap was left in the numbering sequence so that, if needed,
    G450 cards could be distinguished from G400 cards.  According to Ville
    Syrjälä, the G4x0 cards and the G550 cards handle anisotropic filtering
    differently.  This seems the most compatible way to let the client-side driver
    know which card it's own.  Doing this very small change now eliminates the
    need to bump the DRM minor version twice.

    http://marc.theaimsgroup.com/?l=dri-devel&m=106625815319773&w=2

    (airlied - this may not work at this point, I think the follow on buffer
     cleanup patches will be needed)

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b5d499cfdeebcb71f00f3513045796ccae718140
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 18:17:42 2005 +1000

    drm: make drm_alloc_agp take a dev arg.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 93f453f3ffd8f4dbb0311b58b854e7655da3d601
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 17:45:34 2005 +1000

    drm: add new mga ids and types

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit cda173806644d2af22ffd9896eed8ef99b97d356
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 17:31:26 2005 +1000

    drm: add test for AGP devices and driver override for it.

    Added device_is_agp callback to drm_driver.  This function is called by the
    platform-specific drm_device_is_agp function.  Added implementation of this
    function the the Linux-specific portion of the MGA driver to detect PCI G450
    cards.  Added code to the Linux-specific portion of the generic DRM layer to
    not initialize AGP infrastructure if the card is not AGP (this matches what
    already existed in BSD).

    Fix up i810/i830 and i915 drivers to always return AGP as they don't always
    report the capability.

    Fix the MGA to not report AGP for a card that has an AGP chip behind a PCI
    bridge.

    From: Ian Romanick, Dave Airlie, Alan Hourihane
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit ceb9c27aa7d61c70f4c75f017d9fbc9de50034f1
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 17:07:23 2005 +1000

    drm: destatic exported function.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d84f76d37c5eebb94c48337958d5a2ff2965c02d
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 17:04:22 2005 +1000

    drm: export symbols for use by drivers

    This just exports symbols for use in drivers.

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit aff138ab8ec340c23e7c6e1a95c1518ee832a8c6
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 16:58:40 2005 +1000

    drm: fix minor function header issue

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 7ab984012a879a53abb56abfe03b0c686f42b281
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 16:56:52 2005 +1000

    drm: update some function so a driver can call them

    This patch splits some ioctl functions so that they can be called
    in-kernel by a DRM driver. The driver will use them later.

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 9c8da5ebbf6f87293cf8555182da271449889a69
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 15:38:56 2005 +1000

    drm: update support for drm pci buffers

    The DRM needs to change the drm_pci interface for FreeBSD compatiblity,
    this patch introduces the drm_dma_handle_t and uses it in the Linux code.

    From: Tonnerre Lombard, Eric Anholt, and Sergey Vlasov
    Signed-off-by: David Airlie <airlied@linux.ie>

commit d59431bf96d1e8a3d6d240343f559f5e2ace7f1d
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 15:00:06 2005 +1000

    Refactor common, boilerplate ioctl code from drm_addbufs_* functions into
    drm_addbufs. This makes the code more like the BSD code, and makes the
    drm_addbufs_* functions callable in-kernel.

    From: Ian Romanick <idr@us.ibm.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b84397d6390ef04e8080d66bf528418ab5e75dc0
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 14:46:12 2005 +1000

    drm: add framebuffer maps

    The patch makes drmAddBufs/drmMapBufs can handle buffers in video memory

    The attached patch adds a new buffer type DRM_FB_BUFFER. It works like
    AGP memory but uses video memory.

    From: Austin Yuan <austinyuan@viatech.com.cn>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2d0f9eaff8e1d08b9707f5d24fe6b0ac95d231e3
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Jul 10 14:34:13 2005 +1000

    drm: add _DRM_CONSISTENT map type

    Added a new DRM map type _DRM_CONSISTENT for consistent PCI memory. It
    uses drm_pci_alloc/free for allocating/freeing the memory.

    From: Felix Kuhling <fxkuehl@gmx.de>
    Signed-off-by: David Airlie <airlied@linux.ie>


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

