Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTHOSqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270740AbTHOSen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:55684 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270757AbTHOSdN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:33:13 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1060972406382@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test3
In-Reply-To: <1060972406359@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:33:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.18.4, 2003/08/11 15:22:22-07:00, greg@kroah.com

i2c: move w83481d to top of link order due to chip address takeover ability.

Fixes http://bugme.osdl.org/show_bug.cgi?id=1066


 drivers/i2c/chips/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Fri Aug 15 11:27:01 2003
+++ b/drivers/i2c/chips/Makefile	Fri Aug 15 11:27:01 2003
@@ -2,10 +2,12 @@
 # Makefile for the kernel hardware sensors chip drivers.
 #
 
+# w83781d goes first, as it can override other driver's addresses.
+obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
+
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
 obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
-obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o

