Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbTI2Pyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTI2Pyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:54:45 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:11729 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263640AbTI2Px0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:53:26 -0400
Date: Mon, 29 Sep 2003 17:38:15 +0200
From: Smurf <smurf@play.smurf.noris.de>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] No forced rebuilding of ikconfig.h
Message-ID: <20030929153815.GA16685@play.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0-gpgme-021125a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does ikconfig.h require forced rebuilding?
I can't think of a reason...

diff -xCVS -ru linux-2.5-m68k-cvs-orig/kernel/Makefile linux-2.5-m68k-cvs/kernel/Makefile
--- linux-2.5-m68k-cvs-orig/kernel/Makefile	2003-09-28 04:28:45.000000000 +0200
+++ linux-2.5-m68k-cvs/kernel/Makefile	2003-09-29 12:17:19.000000000 +0200
@@ -44,7 +44,8 @@
       cmd_ikconfig = $(CONFIG_SHELL) $< .config $(srctree)/Makefile > $@
 
 targets += ikconfig.h
-$(obj)/ikconfig.h: scripts/mkconfigs .config Makefile FORCE
+
+$(obj)/ikconfig.h: scripts/mkconfigs .config Makefile
 	$(call if_changed,ikconfig)
 
 # config_data.h contains the same information as ikconfig.h but gzipped.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
History is made at night. Character is what you are in the dark.
