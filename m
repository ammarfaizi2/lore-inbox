Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRHWUdC>; Thu, 23 Aug 2001 16:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRHWUcm>; Thu, 23 Aug 2001 16:32:42 -0400
Received: from mailf.telia.com ([194.22.194.25]:63456 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S270271AbRHWUc2>;
	Thu, 23 Aug 2001 16:32:28 -0400
Message-Id: <200108232032.f7NKWR017382@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: [PATCH] Sony Handycam USB and Linux 2.4.8-pre3 and later
Date: Thu, 23 Aug 2001 22:27:40 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <200108230944.f7N9isp22201@mailgate3.cinetic.de> <200108231956.f7NJuNj17557@mailc.telia.com> <20010823130003.F2564@one-eyed-alien.net>
In-Reply-To: <20010823130003.F2564@one-eyed-alien.net>
Cc: Thomas Davis <tadavis@lbl.gov>, Klaus Mueller <klmuell@web.de>,
        linux-usb-users@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursdayen den 23 August 2001 22:00, you wrote:
> Nono... try it with a later kernel, which doesn't work.  That is, go into a
> 2.4.9 kernel and remove the MODE_XLATE flag.
>
> Matt

Did it!



-- 
Roger Larsson
Skellefteå
Sweden


*******************************************
Patch prepared by: roger.larsson@norran.net
Name of file: /home/roger/patches/patch-2.4.8-pre3-Sony_PC110

--- linux/drivers/usb/storage/unusual_devs.h.orig	Thu Aug 23 22:02:24 2001
+++ linux/drivers/usb/storage/unusual_devs.h	Thu Aug 23 22:02:44 2001
@@ -166,7 +166,7 @@
 		"Sony",
 		"Handycam",
 		US_SC_SCSI, US_PR_CB, NULL,
-		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE),
+		US_FL_SINGLE_LUN | US_FL_START_STOP ),
 
 UNUSUAL_DEV(  0x054c, 0x0032, 0x0000, 0x9999,
                 "Sony",
