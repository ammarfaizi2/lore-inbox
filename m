Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWAPQ5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWAPQ5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWAPQ5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:57:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48071 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751114AbWAPQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:57:36 -0500
Subject: PATCH: Remove riotime.h from rio driver (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:01:41 +0000
Message-Id: <1137430901.15553.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/riotime.h linux-2.6.15-git12/drivers/char/rio/riotime.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/riotime.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/riotime.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,63 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******            T I M E
- *******                                                              *******
- ****************************************************************************
-
- Author  : Jeremy Rolls
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
-
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef _riotime_h
-#define _riotime_h 1
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_riotime_h_sccs = "@(#)riotime.h	1.1";
-#endif
-#endif
-
-#define TWO_POWER_FIFTEEN (ushort)32768
-#define RioTime()    riotime
-#define RioTimeAfter(time1,time2) ((ushort)time1 - (ushort)time2) < TWO_POWER_FIFTEEN
-#define RioTimePlus(time1,time2) ((ushort)time1 + (ushort)time2)
-
-/**************************************
- * Convert a RIO tick (1/10th second)
- * into transputer low priority ticks
- *************************************/
-#define RioTimeToLow(time) (time*(100000 / 64))
-#define RioLowToTime(time) ((time*64)/100000)
-
-#define RIOTENTHSECOND (ushort)1
-#define RIOSECOND (ushort)(RIOTENTHSECOND * 10)
-#endif
-
-/*********** end of file ***********/

