Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136264AbRD0XrV>; Fri, 27 Apr 2001 19:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136263AbRD0XrM>; Fri, 27 Apr 2001 19:47:12 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:13518 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S136264AbRD0XrA>; Fri, 27 Apr 2001 19:47:00 -0400
Message-ID: <3AEA04EA.95B53094@bigfoot.com>
Date: Fri, 27 Apr 2001 16:46:50 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-intel-smp-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andre@linux-ide.org
Subject: [PATCH] hpt366.c, *bad_ata66_4 additions (2.2.19 + 
 ide.2.2.19.04092001.patch)
In-Reply-To: <20010426131846.A29148@tetsuo.applianceware.com> <3AE9AC84.B0D8682A@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2.2.19 + ide.2.2.19.04092001.patch)

--- drivers/block/hpt366.c      Fri Apr 20 14:23:54 2001
+++ drivers/block/hpt366.new.c  Fri Apr 27 16:30:13 2001
@@ -56,8 +56,11 @@
 
 const char *bad_ata66_4[] = {
        "IBM-DTLA-307075",
+       "IBM-DTLA-307060",
        "IBM-DTLA-307045",
        "IBM-DTLA-307030",
+       "IBM-DTLA-307020",
+       "IBM-DTLA-307015",
        "WDC AC310200R",
        NULL
 };

Can we assume the rest of the Deskstar 75GXP family has the same problems?

hdg: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=39870/16/63, UDMA(66)
hdh: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=39870/16/63, UDMA(66)

http://www.storage.ibm.com/hardsoft/diskdrdl/desk/ds75gxp.htm

Deskstar 75GXP      Interface     Capacity (GB)   RPM
  DTLA-307015       Ultra ATA/100       15.36      7200
  DTLA-307020       Ultra ATA/100       20.57      7200
  DTLA-307030       Ultra ATA/100       30.73      7200
  DTLA-307045       Ultra ATA/100       46.11      7200
  DTLA-307060       Ultra ATA/100       61.49      7200
  DTLA-307075       Ultra ATA/100       76.86      7200

rgds,
tim.
--
