Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbTDJVDH (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTDJVDH (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:03:07 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:13579 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264175AbTDJVDC (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:03:02 -0400
Date: Thu, 10 Apr 2003 23:14:23 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
In-Reply-To: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.51L.0304102312090.626@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003, James Simmons wrote:
> Here are the latest framebuffer changes. Some driver updates and a
> massive cleanup of teh cursor code. Tony please test it on the i810
> chipset. I tested it on the Riva but there is one bug I can't seem to
> find. Please test this patch. It is against 2.5.67 BK. It shoudl work
> against 2.5.67 as well.

No, it doesn't. On clean 2.5.67:

# zcat fbdev.diff.gz |patch -p0
patching file linus-2.5/Documentation/devices.txt
patching file linus-2.5/drivers/video/aty/aty128fb.c
patching file linus-2.5/drivers/video/cfbimgblt.c
patching file linus-2.5/drivers/video/console/fbcon.c
patching file linus-2.5/drivers/video/console/fbcon.h
patching file linus-2.5/drivers/video/controlfb.c
patching file linus-2.5/drivers/video/fbcmap.c
patching file linus-2.5/drivers/video/fbmem.c
Hunk #3 FAILED at 639.
Hunk #4 succeeded at 705 (offset 1 line).
Hunk #6 succeeded at 848 (offset 1 line).
Hunk #8 succeeded at 931 (offset 1 line).
Hunk #10 succeeded at 974 (offset 1 line).
Hunk #12 succeeded at 997 (offset 1 line).
Hunk #14 succeeded at 1151 (offset 1 line).
1 out of 15 hunks FAILED -- saving rejects to file 
linus-2.5/drivers/video/fbmem.c.rej
patching file linus-2.5/drivers/video/i810/i810.h
patching file linus-2.5/drivers/video/i810/i810_accel.c
patching file linus-2.5/drivers/video/i810/i810_dvt.c
patching file linus-2.5/drivers/video/i810/i810_gtf.c
patching file linus-2.5/drivers/video/i810/i810_main.c
patching file linus-2.5/drivers/video/i810/i810_main.h
patching file linus-2.5/drivers/video/imsttfb.c
patching file linus-2.5/drivers/video/logo/logo.c
Hunk #1 FAILED at 33.
1 out of 1 hunk FAILED -- saving rejects to file linus-2.5/drivers/video/logo/logo.c.rej
The next patch would create the file 
linus-2.5/drivers/video/logo/logo_linux_clut224.c, which already exists!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file linus-2.5/drivers/video/logo/logo_linux_clut224.c.rej
patching file linus-2.5/drivers/video/logo/logo_linux_mono.c
patching file linus-2.5/drivers/video/platinumfb.c
patching file linus-2.5/drivers/video/radeonfb.c
patching file linus-2.5/drivers/video/riva/fbdev.c
patching file linus-2.5/drivers/video/softcursor.c
patching file linus-2.5/drivers/video/tdfxfb.c
patching file linus-2.5/drivers/video/tgafb.c
patching file linus-2.5/drivers/video/vga16fb.c
patching file linus-2.5/include/linux/fb.h
patching file linus-2.5/include/linux/linux_logo.h


-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
