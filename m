Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTLBO2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLBO2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:28:35 -0500
Received: from www.serverart.com ([62.99.220.250]:429 "EHLO www.serverart.com")
	by vger.kernel.org with ESMTP id S262127AbTLBO2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:28:34 -0500
Message-ID: <3FCCA18F.2030803@serverart.org>
Date: Tue, 02 Dec 2003 15:28:31 +0100
From: David Eitzinger <twig@serverart.org>
Organization: ServerArt
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.6a) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Typo in bttv-driver.c in versions 2.4.21 to 2.4.23
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I just encountered that there is an equal sign missing in bttv-driver.c 
on line 564. - Which gives a parse error when one tries to compile.

The bug was introduced in 2.4.21 and is still there in the latest 2.4 
build but it's fixed in 2.6-test11, as I could see.
A search on google showed that the bug was already documented by Kyle 
Davenport (kdd@tvmax.net) on 2003-07-03 17:10:09 PST.

Cheers, David

Patch:

--- linux-2.4.23/drivers/media/video/bttv-driver.c      Fri Nov 28 
19:26:20 2003
+++ linux/drivers/media/video/bttv-driver.c     Tue Dec  2 14:13:53 2003
@@ -558,7 +558,7 @@
                 .sram           = -1,
         },{
                 /* PAL-N */
-               .Fsc             35468950,
+               .Fsc            = 35468950,
                 .swidth         = 768,
                 .sheight        = 576,
                 .totalwidth     = 1135,


