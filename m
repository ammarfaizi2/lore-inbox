Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTEKDx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 23:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTEKDx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 23:53:27 -0400
Received: from smtp1.wanadoo.es ([62.37.236.135]:13777 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S262231AbTEKDx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 23:53:26 -0400
Message-ID: <3EBDCC2B.3040509@wanadoo.es>
Date: Sun, 11 May 2003 06:06:03 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       marcelo <marcelo@conectiva.com.br>
Subject: [PATCH] kbuild ppc64 fix
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

for 2.4.21-rc2:

--cut--
diff -Nuar linux/drivers/char/Config.in linux.xose/drivers/char/Config.in
--- linux/drivers/char/Config.in        2003-05-11 02:53:29.000000000 +0200
+++ linux.xose/drivers/char/Config.in   2003-05-11 05:59:30.000000000 +0200
@@ -158,7 +158,7 @@
    dep_tristate 'Texas Instruments parallel link cable support' CONFIG_TIPAR $CONFIG_PARPORT
 fi

-if [ "$CONFIG_PPC64" ] ; then
+if [ "$CONFIG_PPC64" = "y"] ; then
    bool 'pSeries Hypervisor Virtual Console support' CONFIG_HVC_CONSOLE
 fi
--end--

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

