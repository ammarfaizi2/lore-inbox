Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274474AbSITAzy>; Thu, 19 Sep 2002 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274557AbSITAy5>; Thu, 19 Sep 2002 20:54:57 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:49162 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274474AbSITAyW>;
	Thu, 19 Sep 2002 20:54:22 -0400
Date: Thu, 19 Sep 2002 17:59:13 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] More PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020920005913.GN18583@kroah.com>
References: <20020920005749.GI18583@kroah.com> <20020920005806.GJ18583@kroah.com> <20020920005823.GK18583@kroah.com> <20020920005840.GL18583@kroah.com> <20020920005857.GM18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005857.GM18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.687   -> 1.688  
#	      kernel/ksyms.c	1.63    -> 1.64   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/18	greg@kroah.com	1.688
# add export for __inode_dir_notify so dnotify can be used from filesystems in a modules.
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Sep 19 17:18:57 2002
+++ b/kernel/ksyms.c	Thu Sep 19 17:18:57 2002
@@ -47,6 +47,7 @@
 #include <linux/in6.h>
 #include <linux/completion.h>
 #include <linux/seq_file.h>
+#include <linux/dnotify.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -531,6 +532,7 @@
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
 EXPORT_SYMBOL(brw_page);
+EXPORT_SYMBOL(__inode_dir_notify);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
