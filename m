Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbSITAxV>; Thu, 19 Sep 2002 20:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274260AbSITAwt>; Thu, 19 Sep 2002 20:52:49 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:42250 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274205AbSITAwG>;
	Thu, 19 Sep 2002 20:52:06 -0400
Date: Thu, 19 Sep 2002 17:56:58 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005658.GG18583@kroah.com>
References: <20020920005408.GA18583@kroah.com> <20020920005428.GB18583@kroah.com> <20020920005444.GC18583@kroah.com> <20020920005500.GD18583@kroah.com> <20020920005517.GE18583@kroah.com> <20020920005555.GF18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005555.GF18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.562   -> 1.563  
#	drivers/hotplug/pci_hotplug_core.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.563
# PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio Cesare
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:36 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:50:36 2002
@@ -621,7 +621,7 @@
 
 	if (*offset < 0)
 		return -EINVAL;
-	if (count <= 0)
+	if (count == 0 || count > 16384)
 		return 0;
 	if (*offset != 0)
 		return 0;
@@ -732,7 +732,7 @@
 
 	if (*offset < 0)
 		return -EINVAL;
-	if (count <= 0)
+	if (count == 0 || count > 16384)
 		return 0;
 	if (*offset != 0)
 		return 0;
@@ -970,7 +970,7 @@
 
 	if (*offset < 0)
 		return -EINVAL;
-	if (count <= 0)
+	if (count == 0 || count > 16384)
 		return 0;
 	if (*offset != 0)
 		return 0;
