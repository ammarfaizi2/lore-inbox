Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318958AbSIIWW6>; Mon, 9 Sep 2002 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318944AbSIIWV1>; Mon, 9 Sep 2002 18:21:27 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:17419 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318945AbSIIWTw>;
	Mon, 9 Sep 2002 18:19:52 -0400
Date: Mon, 9 Sep 2002 15:21:42 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909222142.GM7433@kroah.com>
References: <20020909221627.GE7433@kroah.com> <20020909221955.GG7433@kroah.com> <20020909222016.GH7433@kroah.com> <20020909222037.GI7433@kroah.com> <20020909222057.GJ7433@kroah.com> <20020909222112.GK7433@kroah.com> <20020909222128.GL7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909222128.GL7433@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.630   -> 1.631  
#	drivers/hotplug/pci_hotplug.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	greg@kroah.com	1.631
# PCI Hotplug: remove pci_*_nodev() prototypes as the functions are gone.
# 
# The pci_bus_* functions should be used instead.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Mon Sep  9 15:09:32 2002
+++ b/drivers/hotplug/pci_hotplug.h	Mon Sep  9 15:09:32 2002
@@ -141,20 +141,5 @@
 				 struct pci_dev_wrapped *wrapped_dev,
 				 struct pci_bus_wrapped *wrapped_parent);
 
-extern int pci_read_config_byte_nodev	(struct pci_ops *ops, u8 bus, u8 device,
-					 u8 function, int where, u8 *val);
-extern int pci_read_config_word_nodev	(struct pci_ops *ops, u8 bus, u8 device,
-					 u8 function, int where, u16 *val);
-extern int pci_read_config_dword_nodev	(struct pci_ops *ops, u8 bus, u8 device,
-					 u8 function, int where, u32 *val);
-
-extern int pci_write_config_byte_nodev	(struct pci_ops *ops, u8 bus, u8 device,
-					 u8 function, int where, u8 val);
-extern int pci_write_config_word_nodev	(struct pci_ops *ops, u8 bus, u8 device,
-					 u8 function, int where, u16 val);
-extern int pci_write_config_dword_nodev	(struct pci_ops *ops, u8 bus, u8 device,
-					 u8 function, int where, u32 val);
-
-
 #endif
 
