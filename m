Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUENOGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUENOGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUENOGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:06:31 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56806 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261159AbUENOGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:06:30 -0400
Date: Fri, 14 May 2004 16:06:22 +0200 (MEST)
Message-Id: <200405141406.i4EE6MkD018375@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.7.2 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.7.2 of perfctr, the Linux performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

This version changes the user/kernel interface from ioctl()s
to syscalls. Requested by Andrew Morton (2.6-mm kernel maintainer).

This breaks compatibility with perfctr-2.6 user-space code,
so don't even think about using this except for testing.
It also only works in the 2.6.6 and 2.6.6-mm2 kernels.

The new user-space syscall() wrappers only work with certain
gcc versions and gcc options: x86 without -fPIC and ppc
with gcc-3.2 work, while x86 with -fPIC, x86_64, and ppc
with gcc-3.4.0 don't. This will be fixed in the next release.

Version 2.7.2, 2004-05-14
- Changes for submission to 2.6.6-mm kernel. Replaced
  ioctl() interface by new syscall (by request, not choice).
  Eliminated module support and backwards compatibility.
  Many other cleanups.

/ Mikael Pettersson
