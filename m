Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTIOWcC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbTIOWcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:32:02 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:51329
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S261662AbTIOWb7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:31:59 -0400
Date: Tue, 16 Sep 2003 00:31:59 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] status update of loop
Message-ID: <20030915223159.GA2594@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1064529119.5c8a@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in 

http://marc.theaimsgroup.com/?l=linux-kernel&m=106275365925769&w=2

loop.c is broken. Apparently nobody is interested in fixing the problem (0
replies) and Linux is still to immature to have a central bugtracking
database (one which is regularly checked by developers), here is the
appropriate patch:

--- linux-2.6.0-test5/drivers/block/Kconfig~    Sun Jul 27 18:58:50 2003
+++ linux-2.6.0-test5/drivers/block/Kconfig     Tue Sep 16 00:23:54 2003
@@ -221,7 +221,8 @@
          for the device number
  
 config BLK_DEV_LOOP
-       tristate "Loopback device support"
+       tristate "Loopback device support (EXPERIMENTAL)"
+       depends on EXPERIMENTAL
        ---help---
          Saying Y here will allow you to use a regular file as a block
          device; you can then create a file system on that block device and
