Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUEVO7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUEVO7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUEVO7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:59:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:2995 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261468AbUEVO7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:59:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Trivial patch for quiet_cmd_modules_install_extra
From: Andreas Schwab <schwab@suse.de>
X-Yow: The entire CHINESE WOMEN'S VOLLEYBALL TEAM all share ONE personality
 --
 and have since BIRTH!!
Date: Sat, 22 May 2004 16:59:41 +0200
Message-ID: <jey8nkzew2.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a cosmetical bug in the external module support during
modules_install, so that the name of the installed module is actually
displayed.

Andreas.

--- linux-2.6.5/scripts/Makefile.modinst.~1~	2004-05-21 14:25:54.000000000 +0200
+++ linux-2.6.5/scripts/Makefile.modinst	2004-05-22 16:25:41.439829965 +0200
@@ -27,7 +27,7 @@ $(filter-out ../% /%,$(modules)):
 
 # Modules built outside just go into extra
 
-quiet_cmd_modules_install_extra = INSTALL $(obj-m:.o=.ko)
+quiet_cmd_modules_install_extra = INSTALL $@
       cmd_modules_install_extra = mkdir -p $(MODLIB)/extra; \
 			    	  cp $@ $(MODLIB)/extra
 

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
