Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUH2IXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUH2IXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 04:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUH2IXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 04:23:39 -0400
Received: from cnk208.neoplus.adsl.tpnet.pl ([83.31.164.208]:24070 "EHLO
	cnj25.neoplus.adsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S267351AbUH2IXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 04:23:37 -0400
Date: Sun, 29 Aug 2004 10:25:47 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] missing include in farsync WAN driver
Message-ID: <20040829082547.GF32736@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

drivers/net/wan/farsync.c is missing <asm/io.h> include, which leads to
unresolved symbols on some archs (e.g. alpha).

Patch attached.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux24-farsync.patch"

--- linux-2.4.27/drivers/net/wan/farsync.c.orig	2004-08-08 01:26:05.000000000 +0200
+++ linux-2.4.27/drivers/net/wan/farsync.c	2004-08-28 22:17:02.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/if.h>
 #include <linux/hdlc.h>
 #include <asm/delay.h>
+#include <asm/io.h>
 
 #include "farsync.h"
 

--7JfCtLOvnd9MIVvH--
