Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbSI0Tlr>; Fri, 27 Sep 2002 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSI0Tkz>; Fri, 27 Sep 2002 15:40:55 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:4366 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262598AbSI0Tje>;
	Fri, 27 Sep 2002 15:39:34 -0400
Date: Fri, 27 Sep 2002 12:43:14 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194314.GG12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com> <20020927194240.GE12909@kroah.com> <20020927194258.GF12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194258.GF12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.5 -> 1.611.1.6
#	drivers/usb/storage/unusual_devs.h	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	rgcrettol@datacomm.ch	1.611.1.6
# [PATCH] USB 2.0 HDD Walker / ST-HW-818SLIM usb-storage fix
# 
# --------------------------------------------
#
diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	Fri Sep 27 12:30:14 2002
+++ b/drivers/usb/storage/unusual_devs.h	Fri Sep 27 12:30:14 2002
@@ -331,8 +331,10 @@
  * Like the SIIG unit above, this unit needs an INQUIRY to ask for exactly
  * 36 bytes of data.  No more, no less. That is the only reason this entry
  * is needed.
- */
-UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0xffff,
+ *
+ * ST818 slim drives (rev 0.02) don't need special care.
+*/
+UNUSUAL_DEV(  0x05e3, 0x0702, 0x0000, 0x0001,
 		"EagleTec",
 		"External Hard Disk",
 		US_SC_SCSI, US_PR_BULK, NULL,
