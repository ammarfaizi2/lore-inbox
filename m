Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbTGDVHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbTGDVHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 17:07:14 -0400
Received: from qlink.QueensU.CA ([130.15.126.18]:55504 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S266181AbTGDVHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 17:07:14 -0400
Subject: [PATCH] rpm release number
From: Nathan Fredrickson <8nrf@qlink.queensu.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1057353620.5390.20.camel@rocky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jul 2003 17:20:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I needed this patch to the Makefile to get the RPM release number to
correctly increment on successive builds.


--- linux-2.5.74/Makefile       2003-07-04 16:58:51.034025712 -0400
+++ linux/Makefile      2003-07-04 16:41:39.012916768 -0400
@@ -781,7 +781,8 @@
        tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz
$(KERNELPATH)/. ; \
        rm $(KERNELPATH) ; \
        cd $(TOPDIR) ; \
-       $(CONFIG_SHELL) $(srctree)/scripts/mkversion > .version ; \
+       $(CONFIG_SHELL) $(srctree)/scripts/mkversion > .tmp_version ; \
+       mv -f .tmp_version .version; \
        $(RPM) -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
        rm $(TOPDIR)/../$(KERNELPATH).tar.gz
  


