Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTILQM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTILQM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:12:29 -0400
Received: from mail32.messagelabs.com ([62.173.108.211]:8396 "HELO
	mail32.messagelabs.com") by vger.kernel.org with SMTP
	id S261748AbTILQMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:12:24 -0400
X-VirusChecked: Checked
X-Env-Sender: liam.girdwood@wolfsonmicro.com
X-Msg-Ref: server-11.tower-32.messagelabs.com!1063383263!1236140
X-StarScan-Version: 5.0.7; banners=wolfsonmicro.com,-,-
Subject: [PATCH] 2.4.23-pre3 WM97xx AC97 plugin - Documentation
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Content-Type: text/plain
Message-Id: <1063383140.7795.30.camel@caernarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Sep 2003 17:12:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds some documentation to the kernel configuration system
for the WM97xx AC97 touchscreen plugin.

Cheers

Liam


diff -urN linux-2.4.23-pre3/Documentation/Configure.help
linux-2.4.23-pre3-lg1/Documentation/Configure.help
--- linux-2.4.23-pre3/Documentation/Configure.help      2003-09-12
15:05:19.000000000 +0100
+++ linux-2.4.23-pre3-lg1/Documentation/Configure.help  2003-09-12
17:05:16.000000000 +0100
@@ -28274,6 +28274,28 @@
  
 CONFIG_CRYPTO_TEST
   Quick & dirty crypto test module.
+
+CONFIG_SOUND_WM97XX
+  Say Y here to support the Wolfson WM9705 and WM9712 touchscreen
+  controllers. These controllers are mainly found in PDA's
+  i.e. Dell Axim and Toshiba e740
+
+  This is experimental code.
+  Please see Documentation/wolfson-touchscreen.txt for
+  a complete list of parameters.
+
+  In order to use this driver, a char device called wm97xx with a major
+  number of 10 and minor number 16 will have to be created under
+  /dev/touchscreen.
+
+  e.g.
+  mknod /dev/touchscreen/wm97xx c 10 16
+
+  If you want to compile this as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here.  The module will be called ac97_plugin_wm97xx.o.
+
+  If unsure, say N.
  
 #
 # A couple of things I keep forgetting:

-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>


Wolfson Microelectronics plc
www.wolfsonmicro.com
T +44 131 272 7000
F +44 131 272 7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender, except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free. However, we cannot accept responsibility for any virus transmitted by us and recommend that you subject any incoming Email to your own virus checking procedures.
