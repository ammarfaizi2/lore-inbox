Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262124AbSJIVxG>; Wed, 9 Oct 2002 17:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJIVxF>; Wed, 9 Oct 2002 17:53:05 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:456 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S262157AbSJIVxD>; Wed, 9 Oct 2002 17:53:03 -0400
Date: Wed, 9 Oct 2002 16:58:46 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@tux.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-scsi@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] megaraid 2.00rc5 as 'megaraid2' for kernel 2.5.x
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68BC0257@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0210091649180.8828-100000@tux.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend without patch attached - it's 170K and didn't seem to make it through)

Posted to
  http://domsch.com/linux/megaraid/linux-2.5-megaraid-2.00rc5.patch
  http://domsch.com/linux/megaraid/linux-2.5-megaraid-2.00rc5.patch.asc

is a patch to create 'megaraid2', the megaraid 2.00rc5 driver which
includes fixups such that it works on kernel 2.5.41.   The v2.00 
has significant code path cleanups (easier to read and maintain),
support for SCSI reservations (needed for shared storage clustering),
and will soon have an improved higher performance interface to card
firmware.  This driver is being developed by LSI, with assistance from
Red Hat and Dell.

By providing this as a megaraid2 driver, it allows development to
continue on it separate from the stable megaraid (based on 1.18)
driver already present in the 2.5.41 kernel.  This driver works at
least somewhat for me, with slighly increased performance over the
1.18-based driver.  It still likely has bugs related to being 
ported to 2.5.x.  Mike Anderson has already caught one such bug - (use
page_address(page)+offset) - fixed internally.

 MAINTAINERS              |    8 
 arch/i386/defconfig      |    1 
 drivers/scsi/Config.help |   11 
 drivers/scsi/Config.in   |    3 
 drivers/scsi/Makefile    |    3 
 drivers/scsi/megaraid2.c | 5611 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/megaraid2.h | 1175 +++++++++
 7 files changed, 6809 insertions, 3 deletions

If there are no objections, I'll submit this to Linus and Dave Jones 
later this week for inclusion.  This has been posted to 
linux-megaraid-devel@dell.com as well.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

