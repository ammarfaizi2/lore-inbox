Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTJET1L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTJET1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:27:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:59025 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263798AbTJET1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:27:08 -0400
Date: Sun, 5 Oct 2003 21:26:58 +0200 (MEST)
Message-Id: <200310051926.h95JQwlf009299@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.1 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.1 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.6.1, 2003-10-05
- Opening a process' virtual perfctrs is now done via
  /dev/perfctr instead of /proc/<pid>/perfctr. This is needed
  due to the changed semantics for /proc/self and /proc/<pid>/
  in kernel 2.6.0-test6. User-space is not affected since the
  perfctr-2.6 API and user-space library was prepared for
  this access method change.
  User-space code monitoring other processes should use
  gettid() to identify tasks in 2.6 kernels, since getpid()
  does the wrong thing for process threads.
- Driver cleanups from obsoleting 2.4.15 and older kernels.
- Made examples/global/global.c more robust.
- Simplified usage with 2.6 kernels: it's no longer necessary
  to add an 'alias' declaration in /etc/modprobe.conf.
- Added support for AMD K8 Revision C processors.

/ Mikael Pettersson
