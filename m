Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132175AbRAASgo>; Mon, 1 Jan 2001 13:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRAASgf>; Mon, 1 Jan 2001 13:36:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15375 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132243AbRAASgX>; Mon, 1 Jan 2001 13:36:23 -0500
Subject: Re: 2.4.0-pre compile err (pcxx)
To: apgarcia@uwm.edu (A. P. Garcia)
Date: Mon, 1 Jan 2001 18:07:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <87snn3f9rz.fsf@uwm.edu> from "A. P. Garcia" at Jan 01, 2001 05:43:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14D9My-00017N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when i make bzimage with the pc/xx driver configured as a module, it
> compiles ok.  configuring it as built-in gives the following error:

Im amazed it built as a module - thats why I missed the error

> pcxx.c:1826: `mseconds' undeclared (first use in this function)
> pcxx.c:1826: (Each undeclared identifier is reported only once


--- drivers/char/pcxx.c~	Sat Dec 30 01:07:21 2000
+++ drivers/char/pcxx.c	Mon Jan  1 17:12:05 2001
@@ -1823,7 +1823,7 @@
  */
 static void pcxxdelay(int msec)
 {
-	mdelay(mseconds);
+	mdelay(msec);
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
