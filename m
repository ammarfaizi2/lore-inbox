Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbQKLTXc>; Sun, 12 Nov 2000 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQKLTXX>; Sun, 12 Nov 2000 14:23:23 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:2132
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129281AbQKLTXR>; Sun, 12 Nov 2000 14:23:17 -0500
Date: Sun, 12 Nov 2000 20:15:27 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: john slee <indigoid@higherplane.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, dake@staszic.waw.pl,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3 [gus_midi.c breakage]
Message-ID: <20001112201527.A740@jaquet.dk>
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com> <20001112205848.E19275@higherplane.net> <20001112121707.B637@jaquet.dk> <20001112123126.C637@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001112123126.C637@jaquet.dk>; from rasmus@jaquet.dk on Sun, Nov 12, 2000 at 12:31:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 12:31:26PM +0100, Rasmus Andersen wrote:
> On Sun, Nov 12, 2000 at 12:17:07PM +0100, Rasmus Andersen wrote:
> > On Sun, Nov 12, 2000 at 08:58:48PM +1100, john slee wrote:
> > > On Sat, Nov 11, 2000 at 07:22:06PM -0800, Linus Torvalds wrote:
> > > >-----
> > > >  - pre3:
> > > >     - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
> > > >       cleanups
> > > 
> 
> It seems like this touched more than just gus_midi.c. The following
> patch are similarly trivial as the previously posted and therefore
> are bunched together. They should fix the sound/ drivers.
> 

Hrmmm. Missed one that pops up when I compile for modules. Patch
attached.

--- linux-240-t11-pre3-clean/drivers/sound/yss225.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/yss225.c	Sun Nov 12 20:12:24 2000
@@ -1,3 +1,5 @@
+#include <linux/init.h>
+
 unsigned char page_zero[] __initdata = {
 0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
 0x11, 0x00, 0x20, 0x00, 0x32, 0x00, 0x40, 0x00, 0x13, 0x00, 0x00,

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Real computer scientists don't program in assembler. They don't write in 
anything less portable than a number two pencil.   -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
