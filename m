Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290009AbSAWTZo>; Wed, 23 Jan 2002 14:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290011AbSAWTZ1>; Wed, 23 Jan 2002 14:25:27 -0500
Received: from ida-89-127.Reshall.Berkeley.EDU ([169.229.89.127]:10245 "HELO
	ida-89-127.reshall.berkeley.edu") by vger.kernel.org with SMTP
	id <S289988AbSAWTYw>; Wed, 23 Jan 2002 14:24:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jonathan Terhorst <terhorst@uclink.berkeley.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/sound/nm256_audio.c -- fixes hard freeze on Dell laptops
Date: Wed, 23 Jan 2002 11:24:46 -0800
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020123192447.948101C25B@ida-89-127.reshall.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked and looked but can't find the proper person to send this to, so 
I'm throwing it out here. There's one offending line that causes mine and 
others' Dell Latitde LS(t) laptops to freeze up. Remove it and everything 
works perfectly. I'm using 2.4.17 but I think this driver has remained the 
same for quite some time now.

*** nm256_audio.c.old   Sun Sep 30 12:26:08 2001
--- nm256_audio.c       Sun Dec 16 23:02:34 2001
***************
*** 896,902 ****

      /* Reset the mixer.  'Tis magic!  */
      nm256_writePort8 (card, 2, 0x6c0, 1);
-     nm256_writePort8 (card, 2, 0x6cc, 0x87);
      nm256_writePort8 (card, 2, 0x6cc, 0x80);
      nm256_writePort8 (card, 2, 0x6cc, 0x0);

--- 896,901 ----

Jonathan
terhorst@uclink.berkeley.edu
