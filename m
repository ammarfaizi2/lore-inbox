Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUFEIiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUFEIiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 04:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUFEIiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 04:38:11 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:21188 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264596AbUFEIiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 04:38:07 -0400
Date: Sat, 5 Jun 2004 09:38:06 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] drm tree update and bugfix..
Message-ID: <Pine.LNX.4.58.0406050934540.21707@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

There is an issue with the last merge and AGP in certain situations, this
merge fixes that, adds some missing macros and adds a new feature to the
r200 drm,

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drm_agpsupport.h |    2 --
 drivers/char/drm/r128_state.c     |    8 ++++----
 drivers/char/drm/radeon.h         |    4 +++-
 drivers/char/drm/radeon_drm.h     |    3 ++-
 drivers/char/drm/radeon_drv.h     |    1 +
 drivers/char/drm/radeon_mem.c     |    4 ++--
 drivers/char/drm/radeon_state.c   |    2 ++
 7 files changed, 14 insertions(+), 10 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/06/06 1.1608.1.13)
   Remove check that is needed only for 2.4 kernel fixes bug reports on lk.

   Signed-off-by: Colin Leroy <colin@colino.net>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/06/01 1.1608.1.12)
   add R200_EMIT_RB3D_BLENDCOLOR state packet to support GL_EXT_blend_color, GL_EXT_blend_func_separate and GL_EXT_blend_equation_separate on r200
   from Roland Scheidegger

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/06/01 1.1608.1.11)
   fix missing DRM_ERR()s - Eric Anholt

   Signed-off-by: Dave Airlie <airlied@linux.ie>

