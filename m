Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbSAELFM>; Sat, 5 Jan 2002 06:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287648AbSAELEx>; Sat, 5 Jan 2002 06:04:53 -0500
Received: from [194.162.148.192] ([194.162.148.192]:45812 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S287645AbSAELEh>; Sat, 5 Jan 2002 06:04:37 -0500
Date: Sat, 5 Jan 2002 12:04:05 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <kkeil@suse.de>, <linux-kernel@vger.kernel.org>,
        <kai.germaschewski@gmx.de>, <torvalds@transmeta.com>
Subject: Re: Patch: linux-2.5.2-pre8/drivers/isdn/sc/commands.c bug exposed
 by kdev_t changes
In-Reply-To: <20020104235426.A17712@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0201051203150.3975-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Adam J. Richter wrote:

> 	The kdev_t changes have exposed an amusing bug in
> linux-2.5.2-pre8/drivers/isdn/sc/command.c.  A routine that
> was intended to return the error "-ENODEV" was actually
> returning "-NODEV" (prevously zero, now a compilation error).
> Here is the fix.

Looks good.

Attached again for easier applying.

--Kai

--- linux-2.5.2-pre8/drivers/isdn/sc/command.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/sc/command.c	Fri Jan  4 23:47:36 2002
@@ -95,7 +95,7 @@
 		if(adapter[i]->driverId == driver)
 			return i;
 	}
-	return -NODEV;
+	return -ENODEV;
 }
 
 /* 

