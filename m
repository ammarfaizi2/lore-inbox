Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTKCOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKCOl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:41:56 -0500
Received: from math.ut.ee ([193.40.5.125]:35980 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262061AbTKCOlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:41:55 -0500
Date: Mon, 3 Nov 2003 16:41:49 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: James Simmons <simmons@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
In-Reply-To: <Pine.GSO.4.44.0311031623480.12665-100000@math.ut.ee>
Message-ID: <Pine.GSO.4.44.0311031640380.12665-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/video/aty/atyfb_base.c: In function `atyfb_init':
> drivers/video/aty/atyfb_base.c:2476: error: `XL_CHIP_ID' undeclared (first use in this function)

These went away with IS_XL(...), I don't know if this is actually
correct change.

> drivers/video/aty/atyfb_base.c:2552: warning: implicit declaration of function `aty_ld_pll_ct'
> drivers/video/aty/atyfb_base.c:2341: warning: unused variable `lcd_ofs'
> drivers/video/aty/atyfb_base.c:2342: warning: unused variable `driv_inf_tab'
> drivers/video/aty/atyfb_base.c:2342: warning: unused variable `sig'
> drivers/video/aty/atyfb_base.c:2342: warning: unused variable `rom_addr'

These of course remain.

Since the error is now go I get to a next bug:

make -f scripts/Makefile.build obj=drivers/video/console
/bin/sh: -c: line 1: unexpected EOF while looking for matching `''
/bin/sh: -c: line 2: syntax error: unexpected end of file
make[3]: *** [drivers/video/console/promcon_tbl.c] Error 2


-- 
Meelis Roos (mroos@linux.ee)

