Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUA0Jki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUA0Jki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:40:38 -0500
Received: from scrat.hensema.net ([62.212.82.150]:29084 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S262569AbUA0Jkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:40:37 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Tue, 27 Jan 2004 09:40:33 +0000 (UTC)
Message-ID: <slrnc1ccgg.1mo.erik@bender.home.hensema.net>
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu> <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL> <20040125202557.GD16962@colin2.muc.de> <16404.10496.50601.268391@gargle.gargle.HOWL> <20040125220027.30e8cdf3.akpm@osdl.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@osdl.org) wrote:
> "John Stoffel" <stoffel@lucent.com> wrote:
>>
>> Sure, the darn thing wouldn't boot, it kept Oopsing with the
>>  test_wp_bit oops (that I just posted more details about).
> 
> Does this fix the test_wp_bit oops?
> 
> --- 25/init/main.c~test_wp_bit-oops-fix	2004-01-25 15:29:53.000000000 -0800
> +++ 25-akpm/init/main.c	2004-01-25 15:30:03.000000000 -0800
> @@ -434,9 +434,9 @@ asmlinkage void __init start_kernel(void
>  	}
>  #endif
>  	page_address_init();
> +	sort_main_extable();
>  	mem_init();
>  	kmem_cache_init();
> -	sort_main_extable();
>  	if (late_time_init)
>  		late_time_init();
>  	calibrate_delay();

This makes 2.6.2-rc2 boot for me.

-- 
Erik Hensema <erik@hensema.net>
