Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVLPWdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVLPWdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVLPWdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:33:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:25512 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932550AbVLPWde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:33:34 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com>
Subject: [PATCH 2.6] Altix - ioc3 serial support
To: linux-kernel@vger.kernel.org
Date: Fri, 16 Dec 2005 16:33:26 -0600 (CST)
Cc: linux-ia64@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch adds driver support for a 2 port PCI IOC3-based
serial card on Altix boxes:

ftp://oss.sgi.com/projects/sn2/sn2-update/044-ioc3-support

 arch/ia64/configs/gensparse_defconfig |    2 
 arch/ia64/configs/sn2_defconfig       |    2 
 drivers/serial/Kconfig                |    9 
 drivers/serial/Makefile               |    1 
 drivers/serial/ioc3_serial.c          | 2231 ++++++++++++++++++++++++++++++++++
 drivers/sn/Kconfig                    |   14 
 drivers/sn/Makefile                   |    1 
 drivers/sn/ioc3.c                     |  851 ++++++++++++
 include/asm-ia64/sn/ioc3.h            |  241 +++
 include/linux/ioc3.h                  |   93 +



This is a re-submission. On the original submission I was asked to
organize the code so that the MIPS ioc3 ethernet and serial parts could
be used with this driver. Stanislaw Skowronek was kind enough to
provide the shim layer for this - thanks Stanislaw. This patch includes
the shim layer and the Altix PCI ioc3 serial driver. The MIPS merged
ioc3 ethernet and serial support is forthcoming.

Signed-off-by: Patrick Gefre <pfg@sgi.com>

-- 

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054
