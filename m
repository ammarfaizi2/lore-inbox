Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbRAGKoA>; Sun, 7 Jan 2001 05:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRAGKnl>; Sun, 7 Jan 2001 05:43:41 -0500
Received: from cs16028-106.austin.rr.com ([24.160.28.106]:18631 "EHLO
	confucius.gnacademy.org") by vger.kernel.org with ESMTP
	id <S130110AbRAGKn3>; Sun, 7 Jan 2001 05:43:29 -0500
Date: Sun, 7 Jan 2001 04:33:01 -0600
Message-Id: <200101071033.f07AX1w14897@confucius.gnacademy.org>
From: Joseph Wang <joe@gnacademy.tzo.org>
To: linux-kernel@vger.kernel.org
Subject: Pcnet32 patch to get HomePNA working
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a patch here to the pcnet32 driver that is needed to get
HomePNA cards working under 2.4.  I was working with the maintainer of
the driver to test this, but this does not seem to have made it into 
the 2.4.0 kernel.

Any ideas as to what I should do?

*** pcnet32.c~	Mon Dec 11 15:38:29 2000
--- pcnet32.c	Sat Dec 16 03:43:22 2000
***************
*** 582,593 ****
  	 */
  	/* switch to home wiring mode */
  	media = a->read_bcr (ioaddr, 49);
- #if 0
  	if (pcnet32_debug > 2)
  	    printk(KERN_DEBUG "pcnet32: pcnet32 media value %#x.\n",  media);
  	media &= ~3;
  	media |= 1;
! #endif
  	if (pcnet32_debug > 2)
  	    printk(KERN_DEBUG "pcnet32: pcnet32 media reset to %#x.\n",  media);
  	a->write_bcr (ioaddr, 49, media);
--- 582,592 ----
  	 */
  	/* switch to home wiring mode */
  	media = a->read_bcr (ioaddr, 49);
  	if (pcnet32_debug > 2)
  	    printk(KERN_DEBUG "pcnet32: pcnet32 media value %#x.\n",  media);
  	media &= ~3;
  	media |= 1;
! 
  	if (pcnet32_debug > 2)
  	    printk(KERN_DEBUG "pcnet32: pcnet32 media reset to %#x.\n",  media);
  	a->write_bcr (ioaddr, 49, media);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
