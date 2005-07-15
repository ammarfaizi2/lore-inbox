Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263266AbVGOK3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbVGOK3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVGOK3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:29:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263266AbVGOK1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:27:47 -0400
Date: Fri, 15 Jul 2005 12:27:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, andrew.vasquez@qlogic.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: 2.6.13-rc3-mm1: horribly drivers/scsi/qla2xxx/Makefile
Message-ID: <20050715102744.GA3569@stusta.de>
References: <20050715013653.36006990.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc2-mm2:
>...
>  git-scsi-misc.patch
>...
>  Subsystem trees
>...

--- linux-2.6.13-rc3/drivers/scsi/qla2xxx/Makefile      2005-06-17 16:04:01.000000000 -0700
+++ devel/drivers/scsi/qla2xxx/Makefile 2005-07-15 00:46:18.000000000 -0700
@@ -1,4 +1,6 @@
 EXTRA_CFLAGS += -DUNIQUE_FW_NAME
+CONFIG_SCSI_QLA24XX=m
+EXTRA_CFLAGS += -DCONFIG_SCSI_QLA24XX -DCONFIG_SCSI_QLA24XX_MODULE
 
 qla2xxx-y := qla_os.o qla_init.o qla_mbx.o qla_iocb.o qla_isr.o qla_gs.o \
                qla_dbg.o qla_sup.o qla_rscn.o qla_attr.o
@@ -14,3 +16,4 @@ obj-$(CONFIG_SCSI_QLA22XX) += qla2xxx.o 
 obj-$(CONFIG_SCSI_QLA2300) += qla2xxx.o qla2300.o
 obj-$(CONFIG_SCSI_QLA2322) += qla2xxx.o qla2322.o
 obj-$(CONFIG_SCSI_QLA6312) += qla2xxx.o qla6312.o
+obj-$(CONFIG_SCSI_QLA24XX) += qla2xxx.o


I don't know what exactly you want to achieve, but this is so horribly 
wrong.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

