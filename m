Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVKAJp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVKAJp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVKAJp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:45:57 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:18858 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750704AbVKAJp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:45:56 -0500
Date: Tue, 1 Nov 2005 09:45:45 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] drm tree for 2.6.15
Message-ID: <Pine.LNX.4.58.0511010934060.13867@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you pull the drm-linus branch from

	www.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It is mainly a lindenting of the DRM along with an updated radeon DRM to
support PCI Express R300 cards, along with some sparse fixes..

The diffstat isn't of great use, every drm file changes due to the
lindent.. some quite a bit...

I've got some more changes in CVS but I may as well get these ones pushed,
they've been in -mm for a while..

Regards,
Dave.

commit a4e62fa031a9681477207b08391c3a5c5c831ce7
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Oct 24 18:45:11 2005 +1000

    drm: remove unused components of drm structures

    These haven't been used in quite a long time, takes 1K buffer out of structures.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 67e1a014fbc0e472ccc55766a63640a767ede3bf
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Oct 24 18:41:39 2005 +1000

    drm: fix warning on 64-bit platforms..

    This looks ugly, but it is the only thing that makes sense that doesn't
    change the API.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 5fb4dc9bf5e3af1ae91be97108bc3b1233252ddf
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sat Oct 22 15:25:01 2005 +1000

    merge linus head to drm-mm branch

commit 23bfc1a339e98510f2ce25a2764a0cfe195faa9e
Merge: 312f5726055534be1dc9dd369be13aabd2943fcb 63172cb3d5ef762dcb60a292bc7f016b85cf6e1f
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sat Oct 22 15:24:35 2005 +1000

    merge linus head to drm-mm branch

commit 312f5726055534be1dc9dd369be13aabd2943fcb
Merge: 3d5efad953c6d5ba11d5bcb584ef8e906f953a73 93918e9afc76717176e9e114e79cdbb602a45ae8
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Thu Oct 20 18:21:33 2005 +1000

    merge Linus head tree into my drm tree and fix up conflicts

commit 3d5efad953c6d5ba11d5bcb584ef8e906f953a73
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Sep 30 19:12:46 2005 +1000

    drm: fix drm PCIGART

    PCI Express support broke PCIGART

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b3a83639895a422b25f72eec0a5d1d88c3ac4e9e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Sep 30 18:37:36 2005 +1000

    drm: fix all sparse warning on 32-bit x86

    Finally cleaned up the sparse warnings for the drm.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 689b9d74b1c00e1316fbb7d1e912fe1227fdb1ab
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Fri Sep 30 17:09:07 2005 +1000

    drm: add option to force writeback off.

    In order to get some better debugging from people about certain hangs/crashes
    we need to be able to turn AGP writeback off permanently...

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b6ce156c415544f900e031890c78eba8bc92f9b3
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 25 15:07:24 2005 +1000

    drm: fix some lindent damage

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 13e4a9c85152a49ec10e682308581ab13b437470
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 25 14:30:09 2005 +1000

    drm: cast handle to a pointer to avoid warning

    Andrew reported a warning on this line, just case to void *.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit b5e89ed53ed8d24f83ba1941c07382af00ed238e
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 25 14:28:13 2005 +1000

    drm: lindent the drm directory.

    I've been threatening this for a while, so no point hanging around.
    This lindents the DRM code which was always really bad in tabbing department.
    I've also fixed some misnamed files in comments and removed some trailing
    whitespace.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 99a2657a29e2d623c3568cd86b27cac13fb63140
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 25 13:25:41 2005 +1000

    drm: use kernel macros

    Make some of the DRM_ macros use the real kernel macros.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 4e0c1159d83a658d1ffba5bc3442f4ec4cadb436
Merge: ea98a92ff18c03bf7f4d21536986cbbcb4c10cd9 ef6bd6eb90ad72ee8ee7ba8b271f27102e9a90c1
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 25 13:14:45 2005 +1000

    update from upstream

commit ea98a92ff18c03bf7f4d21536986cbbcb4c10cd9
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 11 20:28:11 2005 +1000

    drm: add radeon PCI express support

    Add support for Radeon PCI Express cards (needs a new X.org DDX)
    Also allows PCI GART table to be stored in VRAM for non PCIE cards

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 9d17601c4e132eee9fe450191f6866fb9fb5a762
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 11 19:55:53 2005 +1000

    drm: update radeon driver to 1.18

    Add support for GL_ATI_fragment_shader, new packets R200_EMIT_PP_AFS_0/1,
    R200_EMIT_PP_TXCTLALL_0-5 (replaces R200_EMIT_PP_TXFILTER_0-5, 2 more regs)
    and R200_EMIT_ATF_TFACTOR (replaces R200_EMIT_TFACTOR_0 (8 consts instead of 6)

    From: Roland Scheidegger, David Airlie
    Signed-off-by: David Airlie <airlied@linux.ie>

commit 70dfcfea4b728ab26af1a3e0f331cc63a7e3554b
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Sun Sep 11 19:37:29 2005 +1000

    drm: missing drm_vm.c changes for consistent maps

    This adds a missing change from CVS for consistent maps.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

