Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274203AbSITAuT>; Thu, 19 Sep 2002 20:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274207AbSITAuM>; Thu, 19 Sep 2002 20:50:12 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:38666 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274203AbSITAtw>;
	Thu, 19 Sep 2002 20:49:52 -0400
Date: Thu, 19 Sep 2002 17:54:44 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005444.GC18583@kroah.com>
References: <20020920005408.GA18583@kroah.com> <20020920005428.GB18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005428.GB18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.558   -> 1.559  
#	      kernel/ksyms.c	1.130   -> 1.131  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.559
# export __inode_dir_notify so that dnotify can be called from filesystems in modules.
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Sep 19 17:50:50 2002
+++ b/kernel/ksyms.c	Thu Sep 19 17:50:50 2002
@@ -53,6 +53,7 @@
 #include <linux/root_dev.h>
 #include <linux/percpu.h>
 #include <linux/smp_lock.h>
+#include <linux/dnotify.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -560,6 +561,7 @@
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
+EXPORT_SYMBOL(__inode_dir_notify);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
