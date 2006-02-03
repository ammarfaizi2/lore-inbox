Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945966AbWBCVJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945966AbWBCVJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945964AbWBCVJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:09:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60429 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945966AbWBCVJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:09:04 -0500
Date: Fri, 3 Feb 2006 22:09:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make some "struct clocksource" static
Message-ID: <20060203210903.GN4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
> +time-i386-clocksource-drivers.patch
>...
>  Bring back John's time-reqork patches.  New, improved, fixed.
>...


This patch makes some needlessly global structs static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/hpet.c       |    2 +-
 drivers/clocksource/acpi_pm.c |    2 +-
 drivers/clocksource/cyclone.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/hpet.c.old	2006-02-03 16:33:22.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/hpet.c	2006-02-03 16:33:32.000000000 +0100
@@ -19,7 +19,7 @@
 	return (cycle_t)readl(hpet_ptr);
 }
 
-struct clocksource clocksource_hpet = {
+static struct clocksource clocksource_hpet = {
 	.name		= "hpet",
 	.rating		= 250,
 	.read		= read_hpet,
--- linux-2.6.16-rc1-mm5-full/drivers/clocksource/acpi_pm.c.old	2006-02-03 16:36:43.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/clocksource/acpi_pm.c	2006-02-03 16:36:51.000000000 +0100
@@ -70,7 +70,7 @@
 	return (cycle_t)read_pmtmr();
 }
 
-struct clocksource clocksource_acpi_pm = {
+static struct clocksource clocksource_acpi_pm = {
 	.name		= "acpi_pm",
 	.rating		= 200,
 	.read		= acpi_pm_read,
--- linux-2.6.16-rc1-mm5-full/drivers/clocksource/cyclone.c.old	2006-02-03 16:37:01.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/clocksource/cyclone.c	2006-02-03 16:37:11.000000000 +0100
@@ -24,7 +24,7 @@
 	return (cycle_t)readl(cyclone_ptr);
 }
 
-struct clocksource clocksource_cyclone = {
+static struct clocksource clocksource_cyclone = {
 	.name		= "cyclone",
 	.rating		= 250,
 	.read		= read_cyclone,

