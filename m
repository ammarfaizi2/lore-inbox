Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSLTUD3>; Fri, 20 Dec 2002 15:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSLTUD3>; Fri, 20 Dec 2002 15:03:29 -0500
Received: from smtp-03.inode.at ([62.99.194.5]:14038 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S261463AbSLTUD1> convert rfc822-to-8bit;
	Fri, 20 Dec 2002 15:03:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: Vojtech Pavlik <vojtech@suse.cz>, John Reiser <jreiser@BitWagon.com>,
       AnonimoVeneziano <voloterreno@tin.it>,
       Roland Quast <rquast@hotshed.com>
Subject: Re: vt8235 fix, hopefully last variant
Date: Fri, 20 Dec 2002 21:12:58 +0100
User-Agent: KMail/1.4.3
References: <20021219112640.A21164@ucw.cz>
In-Reply-To: <20021219112640.A21164@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212202112.58475.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for not replying this week, but I was not at home...now back to 
business:

I tried the last patch, but it didn't work - I got Hunk messages:

starbase:/usr/src/linux-2.4.20# patch -p1 < vt8235-atapi 
patching file drivers/ide/via82cxxx.c
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 141.
Hunk #3 succeeded at 283 (offset -57 lines).
2 out of 3 hunks FAILED -- saving rejects to file 
drivers/ide/via82cxxx.c.rej
starbase:/usr/src/linux-2.4.20# cat drivers/ide/via82cxxx.c.rej 
***************
*** 1,16 ****
  /*
-  * $Id: via82cxxx.c,v 3.35-ac2 2002/09/111 Alan Exp $
-  *
-  *  Copyright (c) 2000-2001 Vojtech Pavlik
-  *
-  *  Based on the work of:
-  *    Michel Aubry
-  *    Jeff Garzik
-  *    Andre Hedrick
-  */
- 
- /*
-  * Version 3.35
   *
   * VIA IDE driver for Linux. Supported southbridges:
   *
--- 1,5 ----
  /*
+  * Version 3.36
   *
   * VIA IDE driver for Linux. Supported southbridges:
   *
***************
*** 152,158 ****
        via_print("----------VIA BusMastering IDE Configuration"
                "----------------");
  
-       via_print("Driver Version:                     3.35-ac");
        via_print("South Bridge:                       VIA %s",
                via_config->name);
  
--- 141,147 ----
        via_print("----------VIA BusMastering IDE Configuration"
                "----------------");
  
+       via_print("Driver Version:                     3.36");
        via_print("South Bridge:                       VIA %s",
                via_config->name);
  
starbase:/usr/src/linux-2.4.20# 

MSI KT3Ultra2, TOSHIBA DVD-ROM SD-M1302
So far my kernel is running your first patch and it works fine. Would 
love to get the final patch running too, but I don't know what that 
messages in via82cxxx.c.rej mean and how to modify the patch so that it 
works - ah, btw: I tried to apply it to a clean 2.4.20 kernel source.

Thanks so far for your great work.

Patrick


