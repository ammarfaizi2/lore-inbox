Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUJTTOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUJTTOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJTTNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:13:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19626 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269140AbUJTTJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:09:02 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] snsc needs asm/sn/io.h
Date: Wed, 20 Oct 2004 12:08:59 -0700
User-Agent: KMail/1.7
Cc: Greg Howard <ghoward@sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LfrdBlYSTFnf/Bg"
Message-Id: <200410201208.59105.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LfrdBlYSTFnf/Bg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The sn system controller driver needs asm/sn/io.h in order to build correctly 
(it was missing the numionodes declaration).

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_LfrdBlYSTFnf/Bg
Content-Type: text/plain;
  charset="us-ascii";
  name="snsc-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snsc-build-fix.patch"

===== drivers/char/snsc.c 1.2 vs edited =====
--- 1.2/drivers/char/snsc.c	2004-10-11 13:04:12 -07:00
+++ edited/drivers/char/snsc.c	2004-10-20 11:59:13 -07:00
@@ -21,6 +21,7 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <asm/sn/io.h>
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/module.h>
 #include <asm/sn/geo.h>

--Boundary-00=_LfrdBlYSTFnf/Bg--
