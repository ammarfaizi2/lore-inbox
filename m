Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSGXTIk>; Wed, 24 Jul 2002 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSGXTIk>; Wed, 24 Jul 2002 15:08:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:29703 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317538AbSGXTIj>;
	Wed, 24 Jul 2002 15:08:39 -0400
Date: Wed, 24 Jul 2002 12:11:38 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.5.27
Message-ID: <20020724191138.GC11015@kroah.com>
References: <20020724190922.GA11015@kroah.com> <20020724191010.GB11015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724191010.GB11015@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 17:59:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.403.129.6 -> 1.403.129.7
#	drivers/hotplug/pci_hotplug_core.c	1.18    -> 1.19   
#	drivers/hotplug/pci_hotplug_util.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/07	greg@kroah.com	1.403.129.7
# PCI Hotplug: fix the dbg() macro to work properly on older versions of gcc
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Wed Jul 24 12:00:08 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Wed Jul 24 12:00:08 2002
@@ -48,7 +48,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Wed Jul 24 12:00:08 2002
+++ b/drivers/hotplug/pci_hotplug_util.c	Wed Jul 24 12:00:08 2002
@@ -41,7 +41,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
