Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVCYSXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVCYSXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCYSXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:23:42 -0500
Received: from grerelbul01.net.external.hp.com ([155.208.255.36]:17888 "EHLO
	grerelbul01.net.external.hp.com") by vger.kernel.org with ESMTP
	id S261729AbVCYSXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:23:34 -0500
Date: Fri, 25 Mar 2005 19:22:52 +0100
From: Bruno Cornec <Bruno.Cornec@hp.com>
To: jejb@steeleye.com, linux-kernel@vger.kernel.org
Cc: tvignaud@mandrakesoft.com, Bruno.Cornec@hp.com
Subject: megaraid driver (proposed patch)
Message-ID: <20050325182252.GA4268@morley.grenoble.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Humor: Linux is to Windows what early music is to military music
X-Operating-System: Linux morley.grenoble.hp.com 2.6.8.1-24mdk
X-Current-Uptime: 19:03:52 up 21 days,  4:47,  1 user,  load average: 0.18, 0.24, 0.25
X-HP-HOWTO-URL: http://www.HyPer-Linux.org/HP-HOWTO/current
X-URL: http://eurolinux.grenoble.hp.com/
X-eurolinux: ftp://eurolinux.grenoble.hp.com/pub/linux
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've noticed that since recent kernel versions, it's not possible
anymore to use simultaneously new and old megaraid driver. 

It seems to have been introduced by that changeset:
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/scsi/megaraid/Kconfig.megaraid@1.1??nav=index.html|src/.|src/drivers|src/drivers/scsi|src/drivers/scsi/megaraid|hist/drivers/scsi/megaraid/Kconfig.megaraid

It particularly makes life of people developing kernel for distro
difficult as it forces them to drop support for legacy hardware which is
working just fine with 2.6, or to patch their own kernel build.
As well it prevents simultaneous usage of new and old cards in the same
system.

Would you consider to apply the following patch proposed by Thierry
Vignaud as a solution for the MandrakeSoft kernel in the mainstream 2.6 
kernel ?

Thanks in advance,
Bruno.

--- ./drivers/scsi/megaraid/Kconfig.megaraid	2005-03-02
08:37:49.000000000 +0100
+++ ./drivers/scsi/megaraid/Kconfig.megaraid	2005-03-25
18:36:37.809994244 +0100
@@ -64,7 +64,6 @@
 	To compile this driver as a module, choose M here: the
 	module will be called megaraid_mbox
 
-if MEGARAID_NEWGEN=n
 config MEGARAID_LEGACY
 	tristate "LSI Logic Legacy MegaRAID Driver"
 	depends on PCI && SCSI
@@ -75,4 +74,3 @@
 
 	To compile this driver as a module, choose M here: the
 	module will be called megaraid
-endif
-- 
Linux Solution Consultant   /   Open Source Evangelist   \    HP C&I EMEA ISG
HP/Intel Solution Center http://hpintelco.net Hewlett-Packard Grenoble/France
Des infos sur Linux?  http://www.HyPer-Linux.org      http://www.hp.com/linux
La musique ancienne?  http://www.musique-ancienne.org http://www.medieval.org
