Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274557AbSITAz4>; Thu, 19 Sep 2002 20:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbSITAyw>; Thu, 19 Sep 2002 20:54:52 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:50186 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274493AbSITAyj>;
	Thu, 19 Sep 2002 20:54:39 -0400
Date: Thu, 19 Sep 2002 17:59:30 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] More PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020920005929.GO18583@kroah.com>
References: <20020920005749.GI18583@kroah.com> <20020920005806.GJ18583@kroah.com> <20020920005823.GK18583@kroah.com> <20020920005840.GL18583@kroah.com> <20020920005857.GM18583@kroah.com> <20020920005913.GN18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005913.GN18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.688   -> 1.689  
#	drivers/hotplug/pci_hotplug_core.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.689
# PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio Cesare
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:18:55 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Sep 19 17:18:55 2002
@@ -615,7 +615,7 @@
 
 	if (*offset < 0)
 		return -EINVAL;
-	if (count <= 0)
+	if (count == 0 || count > 16384)
 		return 0;
 	if (*offset != 0)
 		return 0;
@@ -726,7 +726,7 @@
 
 	if (*offset < 0)
 		return -EINVAL;
-	if (count <= 0)
+	if (count == 0 || count > 16384)
 		return 0;
 	if (*offset != 0)
 		return 0;
@@ -964,7 +964,7 @@
 
 	if (*offset < 0)
 		return -EINVAL;
-	if (count <= 0)
+	if (count == 0 || count > 16384)
 		return 0;
 	if (*offset != 0)
 		return 0;
