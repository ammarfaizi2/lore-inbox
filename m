Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263421AbTHXLvw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTHXLvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:51:52 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:53398 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263421AbTHXLvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:51:35 -0400
Date: Sun, 24 Aug 2003 13:51:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] macide (was: Re: Linux 2.6.0-test4)
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0308241342190.14814-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Linus Torvalds wrote:
> Bartlomiej Zolnierkiewicz:
>   o ide: disk geometry/capacity cleanups
>   o ide: always store disk capacity in u64

You forgot to update the Macintosh IDE driver:

--- linux-2.6.0-test4/drivers/ide/legacy/macide.c	Tue Feb 25 10:21:12 2003
+++ linux-m68k-2.6.0-test4/drivers/ide/legacy/macide.c	Sun Aug 24 12:37:06 2003
@@ -126,7 +126,7 @@
 			/* probing the drive which freezes a 190.	*/
 
 			ide_drive_t *drive = &ide_hwifs[index].drives[0];
-        		drive->capacity = drive->cyl*drive->head*drive->sect;
+			drive->capacity64 = drive->cyl*drive->head*drive->sect;
 
 #ifdef CONFIG_BLK_DEV_MAC_MEDIABAY
 			request_irq(IRQ_BABOON_2, macide_mediabay_interrupt,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


