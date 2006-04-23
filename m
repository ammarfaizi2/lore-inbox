Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDWIbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDWIbR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 04:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDWIbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 04:31:17 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:13510 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750782AbWDWIbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 04:31:17 -0400
Date: Sun, 23 Apr 2006 09:31:14 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] more drm patch for 2.6.17
Message-ID: <Pine.LNX.4.64.0604230929470.3835@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
 	One bug fix for PPC for r300 and some cleanups to exported 
symbols..

Please pull the drm-patches branch from:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

  drmP.h           |    1 -
  drm_agpsupport.c |    2 --
  drm_bufs.c       |    5 +----
  drm_stub.c       |    2 --
  r300_cmdbuf.c    |    2 +-
  5 files changed, 2 insertions(+), 10 deletions(-)

commit 5d23fafb1bf8ef071738026c2e5071a92186d5f8
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Apr 23 18:26:40 2006 +1000

     drm: possible cleanups

     This patch contains the following possible cleanups:
     - make the following needlessly global function static:
      - drm_bufs.c: drm_addbufs_fb()
     - remove the following unused EXPORT_SYMBOL's:
      - drm_agpsupport.c: drm_agp_bind_memory
      - drm_bufs.c: drm_rmmap_locked
      - drm_bufs.c: drm_rmmap
      - drm_stub.c: drm_get_dev

     Signed-off-by: Adrian Bunk <bunk@stusta.de>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit caa98c41c0db9bfda5bc9a0e680f304283089268
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Apr 23 18:14:00 2006 +1000

     drm: fixup r300 scratch on BE machines

     This fixes the r300 scratch stuff to work on PPC,
     from Ben Herrenschmidt on IRC.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

