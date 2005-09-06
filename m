Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIFTSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIFTSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVIFTSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:18:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63661 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750812AbVIFTSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:18:02 -0400
Date: Tue, 6 Sep 2005 20:53:38 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: vortex@scyld.com
Cc: becker@scyld.com, jgarzik@pobox.com, andrewm@uow.edu.au
Subject: wakeup on lan enable without compiling as module
Message-ID: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I would like to build the 3c59x vortex module into the kernel (not as
module) but don't loose the ability to use wakeup-on-lan. Because it
seems to be impossible to specify 'module parameters' to a built-in
kernel module I tried the following patch, which doesn't work for me.
Could someone enlighten me how I can get the expected behaviour?

Thanks,
	Thomas

[PATCH] Try to enable wakeup-on-lan per default. (doesn't work)

--- a/drivers/net/3c59x.c
+++ b/drivers/net/3c59x.c
@@ -906,7 +906,7 @@
 static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int hw_checksums[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int flow_ctrl[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int enable_wol[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int enable_wol[MAX_UNITS] = {1, 1, 1, 1, 1, 1, 1, 1};
 static int global_options = -1;
 static int global_full_duplex = -1;
 static int global_enable_wol = -1;
