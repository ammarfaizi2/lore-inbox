Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUIAJiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUIAJiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 05:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUIAJiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 05:38:24 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:48107 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S265489AbUIAJiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 05:38:18 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Timothy Miller <miller@techsource.com>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Date: Wed, 1 Sep 2004 02:38:16 -0700
User-Agent: KMail/1.7
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com> <cgvpb4$ljq$1@news.cistron.nl> <4134FFC3.50409@techsource.com>
In-Reply-To: <4134FFC3.50409@techsource.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JiZNBjtdzq24K8l"
Message-Id: <200409010238.17514.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_JiZNBjtdzq24K8l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tim,

Try this patch , it seems to help with my 3ware 7000-2 controller card. 

matt h.


--Boundary-00=_JiZNBjtdzq24K8l
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="3ware-64-lun.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3ware-64-lun.patch"

diff -urpN linux-2.6.9-base/drivers/scsi/3w-xxxx.h linux-2.6.9/drivers/scsi/3w-xxxx.h
--- linux-2.6.9-base/drivers/scsi/3w-xxxx.h	2004-08-28 22:03:22.000000000 -0700
+++ linux-2.6.9/drivers/scsi/3w-xxxx.h	2004-09-01 01:25:21.166428080 -0700
@@ -214,7 +214,7 @@ static unsigned char tw_sense_table[][4]
 #define TW_MAX_PCI_BUSES		      255
 #define TW_MAX_RESET_TRIES		      3
 #define TW_UNIT_INFORMATION_TABLE_BASE	      0x300
-#define TW_MAX_CMDS_PER_LUN		      254 /* 254 for io, 1 for
+#define TW_MAX_CMDS_PER_LUN		      64 /* 64 for io, 1 for
                                                      chrdev ioctl, one for
                                                      internal aen post */
 #define TW_BLOCK_SIZE			      0x200 /* 512-byte blocks */

--Boundary-00=_JiZNBjtdzq24K8l--
