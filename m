Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270279AbSISIAR>; Thu, 19 Sep 2002 04:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270311AbSISIAR>; Thu, 19 Sep 2002 04:00:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33981 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S270279AbSISIAQ>;
	Thu, 19 Sep 2002 04:00:16 -0400
Date: Thu, 19 Sep 2002 10:05:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Wes Kurdziolek <wkurdzio@cs.vt.edu>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Compile problem w/ 2.4.20-pre7-ac2
Message-ID: <20020919080500.GB936@suse.de>
References: <1032409341.6480.2.camel@yavin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032409341.6480.2.camel@yavin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19 2002, Wes Kurdziolek wrote:
> Found a compile problem w/ 2.4.20-pre7-ac2 when attempting to compile
> the PIIX driver:
> 
> make[4]: Entering directory
> `/usr/src/linux-2.4.20-pre7-ac2/drivers/ide/pci'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre7-ac2/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
> -I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=piix  -c -o
> piix.o piix.c
> piix.c: In function `init_chipset_piix':
> piix.c:533: init_chipset_piix causes a section type conflict
> piix.c: In function `piix_init_one':
> piix.c:677: piix_init_one causes a section type conflict
> piix.c: At top level:
> piix.c:696: warning: `piix_remove_one' defined but not used


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.536.9.8 -> 1.536.9.9
#	drivers/ide/pci/piix.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/16	axboe@burns.home.kernel.dk	1.536.9.9
# piix_pci_info() needs to be __initdata, not __devinit
# --------------------------------------------
#
diff -Nru a/drivers/ide/pci/piix.h b/drivers/ide/pci/piix.h
--- a/drivers/ide/pci/piix.h	Thu Sep 19 10:04:36 2002
+++ b/drivers/ide/pci/piix.h	Thu Sep 19 10:04:36 2002
@@ -38,7 +38,7 @@
  *
  */
  
-static ide_pci_device_t piix_pci_info[] __devinit = {
+static ide_pci_device_t piix_pci_info[] __initdata = {
 	{	/* 0 */
 		vendor:		PCI_VENDOR_ID_INTEL,
 		device:		PCI_DEVICE_ID_INTEL_82371FB_0,


-- 
Jens Axboe

