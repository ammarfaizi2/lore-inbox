Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSHQOJH>; Sat, 17 Aug 2002 10:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHQOJH>; Sat, 17 Aug 2002 10:09:07 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:35542 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S318009AbSHQOJG>;
	Sat, 17 Aug 2002 10:09:06 -0400
Date: Sat, 17 Aug 2002 16:12:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: Linux 2.4.20-pre3
In-Reply-To: <Pine.LNX.4.44.0208162231060.8044-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0208171603260.12155-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Marcelo Tosatti wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>   o files_init - set file limit based on ram

Add missing prototype (cfr. 2.5.x).
BTW, the one is 2.5.x is wrong because it lacks the __init

--- linux-2.4.20-pre3/include/linux/fs.h	Sat Aug 17 14:11:08 2002
+++ linux-m68k-2.4.20-pre3/include/linux/fs.h	Sat Aug 17 15:58:51 2002
@@ -206,6 +206,7 @@
 extern void buffer_init(unsigned long);
 extern void inode_init(unsigned long);
 extern void mnt_init(unsigned long);
+extern void __init files_init(unsigned long mempages);
 
 /* bh state bits */
 enum bh_state_bits {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

