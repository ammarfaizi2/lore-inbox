Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTEVGRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTEVGRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:17:33 -0400
Received: from dp.samba.org ([66.70.73.150]:12448 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262306AbTEVGRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:17:32 -0400
Date: Thu, 22 May 2003 16:22:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Squash warning in ppc64 addnote tool
Message-ID: <20030522062251.GB14009@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, please apply.  addnote in arch/ppc64/boot (a userspace tool,
not kernel code) uses exit() without including stdlib.h.

diff -urN for-linus-ppc64/arch/ppc64/boot/addnote.c linux-congo/arch/ppc64/boot/addnote.c
--- for-linus-ppc64/arch/ppc64/boot/addnote.c	2003-05-07 15:10:18.000000000 +1000
+++ linux-congo/arch/ppc64/boot/addnote.c	2003-05-22 16:04:07.000000000 +1000
@@ -14,6 +14,7 @@
  * Usage: addnote zImage
  */
 #include <stdio.h>
+#include <stdlib.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
