Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHQPby>; Sat, 17 Aug 2002 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSHQPby>; Sat, 17 Aug 2002 11:31:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:45277 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S310190AbSHQPbx>;
	Sat, 17 Aug 2002 11:31:53 -0400
Date: Sat, 17 Aug 2002 17:34:15 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: Linux 2.4.20-pre3
In-Reply-To: <20020817155733.A13576@infradead.org>
Message-ID: <Pine.GSO.4.21.0208171731390.12155-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Christoph Hellwig wrote:
> On Sat, Aug 17, 2002 at 04:12:03PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 16 Aug 2002, Marcelo Tosatti wrote:
> > > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > >   o files_init - set file limit based on ram
> > 
> > Add missing prototype (cfr. 2.5.x).
> > BTW, the one is 2.5.x is wrong because it lacks the __init
> 
> The prototype doesn't need the __init, and consensus is to not add it.

IC. Then please apply this one instead:

--- linux-2.4.20-pre3/include/linux/fs.h	Sat Aug 17 14:11:08 2002
+++ linux-m68k-2.4.20-pre3/include/linux/fs.h	Sat Aug 17 15:58:51 2002
@@ -206,6 +206,7 @@
 extern void buffer_init(unsigned long);
 extern void inode_init(unsigned long);
 extern void mnt_init(unsigned long);
+extern void files_init(unsigned long mempages);
 
 /* bh state bits */
 enum bh_state_bits {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

