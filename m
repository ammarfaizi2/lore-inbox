Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268891AbTCCXXJ>; Mon, 3 Mar 2003 18:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268892AbTCCXXI>; Mon, 3 Mar 2003 18:23:08 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:16271 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268891AbTCCXXH>;
	Mon, 3 Mar 2003 18:23:07 -0500
Date: Tue, 4 Mar 2003 00:33:13 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303032333.h23NXD5U012478@harpo.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.0-pre2 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.0-pre2 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

This is hopefully the last major update before 2.5.0 final.

The ABI version query should help avoid some common user
mistakes. In an ideal world it shouldn't be needed, but
a driver maintained outside of the standard kernel, with
an API still under development, needs these safety checks.

Version 2.5.0-pre2, 2003-03-03
- Added a way for user-space to query the driver's ABI version,
  and updated the library to check it.
- Fixed <linux/perfctr.h> to not include <asm/perfctr.h> when
  perfctr hasn't been configured. This allows the patched kernel
  source to compile cleanly also in archs not supported by perfctr.
- Major patch kit overhaul. Updated configuration help texts.
  Removed unnecessary features and patches. Some cleanups. Added
  aliasing support to the 'update-kernel' script, which allows a
  patch to serve several kernels (when applicable).
- The perfctr configuration option was poorly placed. It is now
  at the end of the "Processor type and features" menu.
- Removed "notsc" kernel option support from the 2.2 kernel patches.
  To use the driver with an IDT WinChip (Centaur C6/2/3) CPU now
  requires a newer kernel with native "notsc" support.
- Driver fixes for changes in the 2.4.21-pre5 and 2.5.63 kernels.

/ Mikael Pettersson
