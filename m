Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTKCOhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTKCOhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:37:12 -0500
Received: from math.ut.ee ([193.40.5.125]:27778 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262040AbTKCOhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:37:09 -0500
Date: Mon, 3 Nov 2003 16:36:56 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: James Simmons <simmons@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
In-Reply-To: <E1AFJKq-0000Lb-7o@rhn.tartu-labor>
Message-ID: <Pine.GSO.4.44.0311031623480.12665-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have fixed the problems you have reported. I have a newer patch. Note
> this is updated with the LCD support. I like to see if the patch works on
> sparc. I has updates from the latest 2.4.X kernels. Please give it a try.

sparc64 (Ultra 5 with onboard mach64), debian unstable.

With all Mach64 suboptions set to Yes:

drivers/video/aty/atyfb_base.c: In function `atyfb_init':
drivers/video/aty/atyfb_base.c:2476: error: `XL_CHIP_ID' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:2476: error: (Each undeclared identifier is reported only once
drivers/video/aty/atyfb_base.c:2476: error: for each function it appears in.)
drivers/video/aty/atyfb_base.c:2552: warning: implicit declaration of function `aty_ld_pll_ct'
drivers/video/aty/atyfb_base.c:2341: warning: unused variable `lcd_ofs'
drivers/video/aty/atyfb_base.c:2342: warning: unused variable `driv_inf_tab'
drivers/video/aty/atyfb_base.c:2342: warning: unused variable `sig'
drivers/video/aty/atyfb_base.c:2342: warning: unused variable `rom_addr'

There are actually 2 lines with XL_CHIP_ID and this is not seen in any
other place under drivers/video/aty nor in include directory. Maybe
IS_XL(pdev->device) is the right thing?

-- 
Meelis Roos (mroos@linux.ee)

