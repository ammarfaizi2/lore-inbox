Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWCDS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWCDS1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWCDS1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:27:16 -0500
Received: from aun.it.uu.se ([130.238.12.36]:7587 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932283AbWCDS1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:27:16 -0500
Date: Sat, 4 Mar 2006 19:27:03 +0100 (MET)
Message-Id: <200603041827.k24IR3OR018829@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.4.33-pre2] preliminary gcc-4.1 fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preliminary patches allowing gcc-4.1 to compile the 2.4 kernel
are now available:

<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc4-fixes-v14-2.4.33-pre2>
Baseline patches for gcc-4.0.2, known to work on i386, x86_64, and ppc32.

<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc41-fixes-v1-2.4.33-pre2>
Add-on patches (on top of the gcc-4.0.2 patches) for gcc-4.1.0.

The status of the gcc-4.1.0 patches right now is that:
- gcc-4.1.0 is known to work on i386 and x86_64. i386 worked as-is,
  but x86_64 needed -fno-strict-aliasing while compiling
  arch/x86_64/boot/compressed/misc.c in order to avoid massive
  memory corruption at boot. The bulk of the patches just silence
  tons of warnings.
- gcc-4.1.0 is known to NOT work on ppc32. The kernel compiles
  cleanly and boots OK, but running a big 'patch' job (e.g. to
  prepare a 2.6.16-rc5 source tree) causes a repeatable oops in
  shrink_dcache_parent().

gcc-4.1.0 does generate noticeably smaller kernels than gcc-4.0.2.

/Mikael
