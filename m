Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbQLPWXQ>; Sat, 16 Dec 2000 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbQLPWXG>; Sat, 16 Dec 2000 17:23:06 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:36950
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129927AbQLPWW4>; Sat, 16 Dec 2000 17:22:56 -0500
Date: Sat, 16 Dec 2000 22:52:22 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Cc: pgmdsg@ibi.com
Subject: link failure (drivers/char/riscom8.c) (240test13p2)
Message-ID: <20001216225222.D609@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In the link phase of a kernel 240t13p2 build I get the following:

drivers/char/char.o: In function `tty_init':
drivers/char/char.o(.text.init+0x259): undefined reference to `riscom8_init'

I guess this is bacause riscom8_init is now a static function and thus
tty_init cannot see it. If this is intentional or nat I cannot judge
but I guess the fix is either to remove the static or the initcall from
tty_init. The decision I leave with those who know what to do.

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

           My other .sig is a porsche
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
