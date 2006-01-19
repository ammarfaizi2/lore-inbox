Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWASDY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWASDY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWASDY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:24:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46090 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964947AbWASDYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:24:25 -0500
Date: Thu, 19 Jan 2006 04:24:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, pfg@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org
Subject: [2.6 patch] drivers/sn/ must be entered for CONFIG_SGI_IOC3
Message-ID: <20060119032423.GI19398@stusta.de>
References: <20060117235521.GA14298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117235521.GA14298@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 06:55:21PM -0500, Dave Jones wrote:

> kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_unregister_submodule
> 
> CONFIG_SERIAL_SGI_IOC3=m
> CONFIG_SGI_IOC3=m

The untested patch below should fix it.

> 		Dave

cu
Adrian


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm1-full/drivers/Makefile.old	2006-01-19 04:14:24.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/Makefile	2006-01-19 04:14:57.000000000 +0100
@@ -70,6 +70,7 @@
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
+obj-$(CONFIG_SGI_IOC3)		+= sn/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/

