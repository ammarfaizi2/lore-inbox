Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264703AbTFASdj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFASdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:33:39 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:16877 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264703AbTFASdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:33:37 -0400
Date: Sun, 1 Jun 2003 19:43:35 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70: scripts/Makefile.build fix
Message-ID: <20030601184335.GA31452@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch seems to fix `make V=0' for me.


--- scripts/Makefile.build.orig	2003-06-01 19:35:38.000000000 +0100
+++ scripts/Makefile.build	2003-06-01 19:38:33.000000000 +0100
@@ -112,8 +112,7 @@
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		      \
 			-T $(@D)/.tmp_$(@F:.o=.ver);			      \
 		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);	      \
-	fi;			
-					      \
+	fi;								      \
 	scripts/fixdep $(depfile) $@ '$(cmd_vcc_o_c)' > $(@D)/.$(@F).tmp;     \
 	rm -f $(depfile);						      \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd


Stig
-- 
brautaset.org
