Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbULZPc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbULZPc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULZPc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:32:58 -0500
Received: from coderock.org ([193.77.147.115]:30176 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261670AbULZPcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:32:54 -0500
Subject: [patch 2/6] delete unused file
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sun, 26 Dec 2004 16:32:59 +0100
Message-Id: <20041226153243.BD3701F125@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/drivers/char/rio/cdproto.h |   55 ------------------------------------------
 1 files changed, 55 deletions(-)

diff -L drivers/char/rio/cdproto.h -puN drivers/char/rio/cdproto.h~remove_file-drivers_char_rio_cdproto.h /dev/null
--- kj/drivers/char/rio/cdproto.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,55 +0,0 @@
-/* 
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *
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
-*/
-#ifndef _cirrusprots_h
-#define _cirrusprots_h
-
-#ifdef RTA
-extern void cd1400_reset ( int uart) ;
-extern void cd1400_init ( int uart ) ;
-extern void ccr_wait ( int priority, int port) ;
-extern void cd1400_txstart( int port) ;
-extern void cd1400_rxstart ( int port) ;
-extern void command_acknowledge ( PHB *port_header ) ;
-extern int close_port ( ushort port, PHB *port_header, ushort preemptive, int pseudo) ;
-extern void command_preemptive ( PKT *packet) ;
-extern void rup_service ( void ) ;
-extern ushort GetModemLines(struct PHB *, register short *);
-extern void cd1400_intr (Process *cirrus_p, ushort *RtaType) ;
-extern void cd1400_mdint ( short port) ;
-extern void cd1400_rxint ( short port) ;
-extern void cd1400_rxexcept ( short port) ;
-extern void cd1400_txdata ( short port, PHB *port_header, PKT *packet) ;
-extern void cd1400_fast_clock(void);
-extern void cd1400_map_baud ( ushort host_rate, ushort *prescaler, ushort *divisor) ;
-extern void cd1400_modem ( ushort port, ushort way) ;
-extern void cd1400_txcommand ( short port, PHB *port_header, PKT *packet) ;
-extern void cd1400_txint ( int port) ;
-void Rprintf( char *RIOPrBuf, char *Str, ... );
-#if defined(DCIRRUS)
-void debug_packet(PKT *pkt, int option, char *string, int channel);
-#endif	/* defined(DCIRRUS) */
-#endif
-
-#ifdef HOST
-extern void wflush (PHB *);
-extern void command_preemptive (PKT *);
-#endif
-
-#endif /* _cirrusprots_h */
_
