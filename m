Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWFUV5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWFUV5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWFUV5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:57:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46602 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030321AbWFUV5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:57:18 -0400
Date: Wed, 21 Jun 2006 23:57:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [-mm patch] drivers/acpi/scan.c: make acpi_bus_type static
Message-ID: <20060621215717.GJ9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-acpi.patch
>...
>  git trees
>...

This patch makes the needlessly global acpi_bus_type static.

I'd also suggest to rename this struct, since although it's named 
acpi_bus_type, it's of type "struct bus_type",
not "struct acpi_bus_type" as defined in include/acpi/acpi_bus.h .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/drivers/acpi/scan.c.old	2006-06-21 22:35:30.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/acpi/scan.c	2006-06-21 22:35:40.000000000 +0200
@@ -1450,7 +1450,7 @@
 }
 
 
-struct bus_type acpi_bus_type = {
+static struct bus_type acpi_bus_type = {
 	.name		= "acpi",
 	.suspend	= acpi_device_suspend,
 	.resume		= acpi_device_resume,

