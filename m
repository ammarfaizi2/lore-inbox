Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUAZRoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUAZRoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:44:06 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63930 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264437AbUAZRoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:44:02 -0500
Date: Mon, 26 Jan 2004 18:43:56 +0100 (MET)
Message-Id: <200401261743.i0QHhuxN022892@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.5 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.5 of perfctr, the Linux performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.6.5, 2004-01-26
- Relaxed and corrected control checks on Pentium 4:
  * Allow ESCR.CPL_T1 to be non-zero when using global-mode
    counters on HT processors.
  * Don't require ESCR.CPL_T0 to be non-zero. CPL_T0==0b00
    is safe and potentially useful (global counters on HT).
  * Require CCCR.ACTIVE_THREAD==0b11 on non-HT processors, as
    documented in the IA32 Volume 3 manual. Old non-HT P4s
    seem to work Ok for all four values, but this is neither
    guaranteed nor useful.
- Per-process counters driver updated for filp->f_mapping
  change in 2.6.2-rc kernels.
- Support 2.4.21-9.EL (RHEL3) and 2.4.22-1.2149.nptl (FC1) kernels.
- Library updates for PowerPC:
  * Added cpu_type constants for struct perfctr_info.
  * Decode PVR and define perfctr_info.cpu_type accordingly.
  * Added event set descriptions for 604/604e/750.

/ Mikael Pettersson
