Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSFFAOG>; Wed, 5 Jun 2002 20:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSFFAOF>; Wed, 5 Jun 2002 20:14:05 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:46585 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316577AbSFFAOE>; Wed, 5 Jun 2002 20:14:04 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15614.43338.841104.697862@wombat.chubb.wattle.id.au>
Date: Thu, 6 Jun 2002 10:14:02 +1000
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
CC: jdthood@mail.com, dahinds@users.sourceforge.net
Subject: [PATCH] pnpbios_proc.c needs init.h
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without init.h, pnpbios_proc.c won't compile (2.5.20), as it has a
function declared __init.


===== linux/drivers/pnp/pnpbios_proc.c 1.2 vs edited =====
--- 1.2/drivers/pnp/pnpbios_proc.c      Sun Mar 24 09:55:28 2002
+++ edited/drivers/pnp/pnpbios_proc.c   Thu Jun  6 10:06:31 2002
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/pnpbios.h>
+#include <linux/init.h>
 
 static struct proc_dir_entry *proc_pnp = NULL;
 static struct proc_dir_entry *proc_pnp_boot = NULL;


--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
