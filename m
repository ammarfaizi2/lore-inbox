Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUAZGCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 01:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUAZGCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 01:02:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:10627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265507AbUAZGB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 01:01:58 -0500
Date: Sun, 25 Jan 2004 22:00:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: "John Stoffel" <stoffel@lucent.com>
Cc: ak@muc.de, stoffel@lucent.com, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040125220027.30e8cdf3.akpm@osdl.org>
In-Reply-To: <16404.10496.50601.268391@gargle.gargle.HOWL>
References: <200401232253.08552.eric@cisu.net>
	<200401251639.56799.cova@ferrara.linux.it>
	<20040125162122.GJ513@fs.tum.de>
	<200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> wrote:
>
> Sure, the darn thing wouldn't boot, it kept Oopsing with the
>  test_wp_bit oops (that I just posted more details about).

Does this fix the test_wp_bit oops?

--- 25/init/main.c~test_wp_bit-oops-fix	2004-01-25 15:29:53.000000000 -0800
+++ 25-akpm/init/main.c	2004-01-25 15:30:03.000000000 -0800
@@ -434,9 +434,9 @@ asmlinkage void __init start_kernel(void
 	}
 #endif
 	page_address_init();
+	sort_main_extable();
 	mem_init();
 	kmem_cache_init();
-	sort_main_extable();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();

_

