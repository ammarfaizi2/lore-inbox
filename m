Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130998AbQLQJB1>; Sun, 17 Dec 2000 04:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLQJBS>; Sun, 17 Dec 2000 04:01:18 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:63831
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130998AbQLQJA5>; Sun, 17 Dec 2000 04:00:57 -0500
Date: Sun, 17 Dec 2000 09:30:24 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: link failure (drivers/char/riscom8.c) (240test13p2)
Message-ID: <20001217093024.A612@jaquet.dk>
In-Reply-To: <20001216225222.D609@jaquet.dk> <E147Pxr-0003IA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E147Pxr-0003IA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 16, 2000 at 10:37:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 10:37:59PM +0000, Alan Cox wrote:
> Remove the call from tty_init. riscom8 now uses the new style initialisers

I guess this would do it then.


--- linux-240-t13-pre2-clean/drivers/char/tty_io.c	Thu Dec 14 20:13:29 2000
+++ linux/drivers/char/tty_io.c	Sun Dec 17 09:27:32 2000
@@ -2319,9 +2319,6 @@
 #ifdef CONFIG_DIGIEPCA
 	pc_init();
 #endif
-#ifdef CONFIG_RISCOM8
-	riscom8_init();
-#endif
 #ifdef CONFIG_SPECIALIX
 	specialix_init();
 #endif


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Cutler Webster's Law: There are two sides to every argument, unless a 
person is personally involved, in which case there is only one. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
