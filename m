Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbULFAyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbULFAyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbULFAmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:42:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22027 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261444AbULFAle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:41:34 -0500
Date: Mon, 6 Dec 2004 01:41:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/moxa.c: #if 0 an unused function
Message-ID: <20041206004130.GI2953@stusta.de>
References: <20041205170247.GR2953@stusta.de> <Pine.LNX.4.61L.0412052112080.11466@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0412052112080.11466@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 09:14:08PM +0100, Tomasz K?oczko wrote:
>...
> >- *	5.  MoxaPortGetCurBaud(int port);				     
> >*
> > *	6.  MoxaPortSetBaud(int port, long baud);			     
> > *
> > *	7.  MoxaPortSetMode(int port, int databit, int stopbit, int parity); 
> > *
> > *	8.  MoxaPortSetTermio(int port, unsigned char *termio); 	     
> > *
> [..]
> 
> Prabaly it will be good renumber this or make unnumbered (and all other 
> comments with "Function <num>:" :)


Perhaps the following patch is the best solution:


diffstat output:
 drivers/char/moxa.c |    2 ++
 1 files changed, 2 insertions(+)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/drivers/char/moxa.c.old	2004-12-06 01:30:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/char/moxa.c	2004-12-06 01:30:39.000000000 +0100
@@ -3090,6 +3090,7 @@
 	return (0);
 }
 
+#if 0
 long MoxaPortGetCurBaud(int port)
 {
 
@@ -3097,6 +3098,7 @@
 		return (0);
 	return (moxaCurBaud[port]);
 }
+#endif  /*  0  */
 
 static void MoxaSetFifo(int port, int enable)
 {



