Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSH3WNP>; Fri, 30 Aug 2002 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSH3WMc>; Fri, 30 Aug 2002 18:12:32 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:4 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317694AbSH3WJh>;
	Fri, 30 Aug 2002 18:09:37 -0400
Date: Fri, 30 Aug 2002 15:13:00 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221300.GL10783@kroah.com>
References: <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com> <20020830221044.GF10783@kroah.com> <20020830221107.GG10783@kroah.com> <20020830221127.GH10783@kroah.com> <20020830221157.GI10783@kroah.com> <20020830221220.GJ10783@kroah.com> <20020830221239.GK10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221239.GK10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.552   -> 1.553  
#	  drivers/pci/pool.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	greg@kroah.com	1.553
# PCI: compile time fix for the pci pool patch.
# --------------------------------------------
#
diff -Nru a/drivers/pci/pool.c b/drivers/pci/pool.c
--- a/drivers/pci/pool.c	Fri Aug 30 15:00:09 2002
+++ b/drivers/pci/pool.c	Fri Aug 30 15:00:09 2002
@@ -80,7 +80,7 @@
 
 	return count - size;
 }
-static DEVICE_ATTR (pools, "pools", S_IRUGO, show_pools, NULL);
+static DEVICE_ATTR (pools, S_IRUGO, show_pools, NULL);
 
 /**
  * pci_pool_create - Creates a pool of pci consistent memory blocks, for dma.
