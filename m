Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSEIVoL>; Thu, 9 May 2002 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSEIVoK>; Thu, 9 May 2002 17:44:10 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:32265 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314395AbSEIVni>;
	Thu, 9 May 2002 17:43:38 -0400
Date: Thu, 9 May 2002 13:43:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.5.14
Message-ID: <20020509204332.GC18958@kroah.com>
In-Reply-To: <20020509204205.GA18958@kroah.com> <20020509204312.GB18958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 11 Apr 2002 19:39:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.557   -> 1.558  
#	drivers/hotplug/pci_hotplug_core.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/09	greg@kroah.com	1.558
# PCI Hotplug core
# 
# removed pcihpfs_statfs(), as it's not used anymore.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu May  9 14:21:11 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu May  9 14:21:11 2002
@@ -86,14 +86,6 @@
 LIST_HEAD(pci_hotplug_slot_list);
 
 
-static int pcihpfs_statfs (struct super_block *sb, struct statfs *buf)
-{
-	buf->f_type = PCIHPFS_MAGIC;
-	buf->f_bsize = PAGE_CACHE_SIZE;
-	buf->f_namelen = 255;
-	return 0;
-}
-
 static struct inode *pcihpfs_get_inode (struct super_block *sb, int mode, int dev)
 {
 	struct inode *inode = new_inode(sb);
