Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSEUCnE>; Mon, 20 May 2002 22:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316493AbSEUCnD>; Mon, 20 May 2002 22:43:03 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:45800 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316492AbSEUCnB>;
	Mon, 20 May 2002 22:43:01 -0400
Date: Tue, 21 May 2002 12:43:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH] Missing init.h in drivers/pci/power.c
Message-ID: <20020521024324.GF4745@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This adds a #include to drivers/pci/power.c to
define __init.  At least on PPC4xx this fixes compile problems.

diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/pci/power.c linux-bluefish/drivers/pci/power.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/pci/power.c	Fri May 10 16:27:35 2002
+++ linux-bluefish/drivers/pci/power.c	Mon May 13 14:46:16 2002
@@ -1,5 +1,6 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
+#include <linux/init.h>
 
 /*
  * PCI Power management..


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
