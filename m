Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUEVAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUEVAGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265014AbUEVAFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:05:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13252 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265493AbUEVABj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:01:39 -0400
Date: Wed, 19 May 2004 20:14:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] hotplug: add missing Configure.help entries
Message-ID: <20040519181441.GI22742@fs.tum.de>
References: <20040503230911.GE7068@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503230911.GE7068@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 08:09:12PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.27-pre1 to v2.4.27-pre2
> ============================================
>...
> Dely Sy:
>   o SHPC and PCI Express hot-plug drivers for 2.4 kernel
>...

People seem to tend to forget Configure.help entries for new drivers...

Below is a patch to add Configure.help entries based on the entries 
in 2.6 .

Please apply
Adrian

--- linux-2.4.27-pre3-full/Documentation/Configure.help.old	2004-05-19 20:04:49.000000000 +0200
+++ linux-2.4.27-pre3-full/Documentation/Configure.help	2004-05-19 20:10:22.000000000 +0200
@@ -4300,6 +4300,26 @@
   The module will be called acpiphp.o. If you want to compile it
   as a module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_HOTPLUG_PCI_SHPC
+  Say Y here if you have a motherboard with a SHPC PCI Hotplug
+  controller.
+
+CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE
+  Say Y here if you want to use the polling mechanism for hot-plug 
+  events for early platform testing.
+
+CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY
+  Say Y here for AMD SHPC. You have to select this option if you are 
+  using this driver on platform with AMD SHPC.
+
+CONFIG_HOTPLUG_PCI_PCIE
+  Say Y here if you have a motherboard that supports PCI Express Native
+  Hotplug
+
+CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
+  Say Y here if you want to use the polling mechanism for hot-plug 
+  events for early platform testing.
+
 MCA support
 CONFIG_MCA
   MicroChannel Architecture is found in some IBM PS/2 machines and
