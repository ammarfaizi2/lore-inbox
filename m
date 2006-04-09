Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDIOut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDIOut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 10:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDIOut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 10:50:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25605 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750751AbWDIOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 10:50:49 -0400
Date: Sun, 9 Apr 2006 16:50:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [-mm patch] drivers/pci/hotplug/acpiphp_glue.c: make a function static
Message-ID: <20060409145047.GC8454@stusta.de>
References: <20060408031405.5e5131da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408031405.5e5131da.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 03:14:05AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc1-mm1:
>...
> +gregkh-pci-acpiphp-configure-_prt-v3.patch
>...
>  PCI tree updates
>...

This patch makes the needlessly global acpiphp_bus_trim() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/drivers/pci/hotplug/acpiphp_glue.c.old	2006-04-09 16:13:00.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/pci/hotplug/acpiphp_glue.c	2006-04-09 16:13:13.000000000 +0200
@@ -928,7 +928,7 @@
  * @handle: handle to acpi namespace
  *
  */
-int acpiphp_bus_trim(acpi_handle handle)
+static int acpiphp_bus_trim(acpi_handle handle)
 {
 	struct acpi_device *device;
 	int retval;

