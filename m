Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLPXGM>; Sat, 16 Dec 2000 18:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbQLPXGC>; Sat, 16 Dec 2000 18:06:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48141 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129704AbQLPXF4>; Sat, 16 Dec 2000 18:05:56 -0500
Subject: Re: link failure (drivers/char/riscom8.c) (240test13p2)
To: rasmus@jaquet.dk (Rasmus Andersen)
Date: Sat, 16 Dec 2000 22:37:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, pgmdsg@ibi.com
In-Reply-To: <20001216225222.D609@jaquet.dk> from "Rasmus Andersen" at Dec 16, 2000 10:52:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147Pxr-0003IA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/char.o: In function `tty_init':
> drivers/char/char.o(.text.init+0x259): undefined reference to `riscom8_init'
> 
> I guess this is bacause riscom8_init is now a static function and thus
> tty_init cannot see it. If this is intentional or nat I cannot judge
> but I guess the fix is either to remove the static or the initcall from
> tty_init. The decision I leave with those who know what to do.

Remove the call from tty_init. riscom8 now uses the new style initialisers

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
