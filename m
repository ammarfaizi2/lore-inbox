Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271941AbRH2KoS>; Wed, 29 Aug 2001 06:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271943AbRH2KoJ>; Wed, 29 Aug 2001 06:44:09 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:36356 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271941AbRH2KoD>; Wed, 29 Aug 2001 06:44:03 -0400
Date: Wed, 29 Aug 2001 12:44:03 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vga16fb.c, length should be 65536
Message-ID: <20010829124403.A25494@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares agreed too, so I'm forwarding this :-)
Please apply

----- Forwarded message from Tobias Diedrich <ranma@gmx.at> -----

Message-ID: <20010829011707.A1984@router.ranmachan.dyndns.org>
User-Agent: Mutt/1.3.20i
Date: Wed, 29 Aug 2001 01:17:07 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: Martin Mares <mj@suse.cz>
Cc: linux-video@atrey.karlin.mff.cuni.cz
Subject: [PATCH] vga16fb.c, length should be 65536
Content-Type: text/plain; charset=us-ascii

I noticed that the vga16 framebuffer driver returns a smem_len of
65535. Shouldn't that be 65536 ? (Realmode Segment A000-AFFF)

I already wrote about this to Ben Pfaff <pfaffen@msu.edu>, who is listed
at the top of this file, some time ago, to which he ansered
"I think you're right.". 

I recently looked at the source of a newer tree again to check wether he
did forward it, but appearently he did not. After looking at the
MAINTAINERS File again I found you being listed for "SVGA HANDLING",
so I'm sending this to you.

Should I forward this to Linus & linux-kernel ?

--- linux-2.4.8-ac11/drivers/video/vga16fb.c.orig	Wed Aug 29 01:04:04 2001
+++ linux-2.4.8-ac11/drivers/video/vga16fb.c	Wed Aug 29 01:04:12 2001
@@ -33,7 +33,7 @@
 #define dac_val	(0x3c9)
 
 #define VGA_FB_PHYS 0xA0000
-#define VGA_FB_PHYS_LEN 65535
+#define VGA_FB_PHYS_LEN 65536
 
 /* --------------------------------------------------------------------- */
 
-- 
Tobias							     PGP-Key: 0x9AC7E0BC
