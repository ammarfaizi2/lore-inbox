Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSLGT1M>; Sat, 7 Dec 2002 14:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSLGT1M>; Sat, 7 Dec 2002 14:27:12 -0500
Received: from MUNSTER-178.ubishops.ca ([207.162.100.178]:4 "EHLO cort.ws")
	by vger.kernel.org with ESMTP id <S264686AbSLGT1L>;
	Sat, 7 Dec 2002 14:27:11 -0500
Date: Sat, 7 Dec 2002 14:36:20 +0000 (/etc/localtime)
From: Thomas Cort <tcort@cort.ws>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com, alan@lxorguk.ukuu.org.uk, tsbogend@alpha.franken.de
Subject: [PATCH] Linux-2.2.23 drivers/net/lance.c unused variable 
Message-ID: <Pine.LNX.4.21.0212071426250.106-100000@cort.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch to remove unused variable "int i" from
static int lance_close(struct device *dev) in
drivers/net/lance.c. I checked 2.5.50 and this variable is _not_
present. Kernel compiles and works fine with the following patch:

/** SNIP **/

--- /usr/src/linux/drivers/net/lance.c  Sun Mar 25 16:37:34 2001
+++ /usr/src/linux/drivers/net/lance.c  Sat Dec  7 13:14:18 2002
@@ -1174,7 +1174,6 @@
 {
        int ioaddr = dev->base_addr;
        struct lance_private *lp = (struct lance_private *)dev->priv;
-       int i;

        dev->start = 0;
        dev->tbusy = 1;

/** SNIP **/

Please apply the patch to the next version of the 2.2 Kernel.

-Thomas Cort <tcort@cort.ws>

