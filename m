Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWI2Cxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWI2Cxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWI2Cxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:53:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61111 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751377AbWI2Cxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:53:33 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:53:22 +1000
Message-Id: <1060929025322.15302@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 6] md: Allow SET_BITMAP_FILE to work on 64bit kernel with 32bit userspace.
References: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Clements <paul.clements@steeleye.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/compat_ioctl.h |    1 +
 1 file changed, 1 insertion(+)

diff .prev/include/linux/compat_ioctl.h ./include/linux/compat_ioctl.h
--- .prev/include/linux/compat_ioctl.h	2006-09-29 11:49:49.000000000 +1000
+++ ./include/linux/compat_ioctl.h	2006-09-29 11:49:49.000000000 +1000
@@ -125,6 +125,7 @@ COMPATIBLE_IOCTL(RUN_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY_RO)
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)
+ULONG_IOCTL(SET_BITMAP_FILE)
 /* DM */
 COMPATIBLE_IOCTL(DM_VERSION_32)
 COMPATIBLE_IOCTL(DM_REMOVE_ALL_32)
