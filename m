Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTLJPKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTLJPKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:10:43 -0500
Received: from math.ut.ee ([193.40.5.125]:20112 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263591AbTLJPKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:10:41 -0500
Date: Wed, 10 Dec 2003 15:22:31 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23+BK: PPC compile error
In-Reply-To: <20031208152954.GY912@stop.crashing.org>
Message-ID: <Pine.GSO.4.44.0312101521540.26871-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PPC32: Fix a thinko in arch/ppc/kernel/cpu_setup_6xx.S
>
> --- 1.6/arch/ppc/kernel/cpu_setup_6xx.S	Wed Dec  3 08:48:47 2003
> +++ edited/arch/ppc/kernel/cpu_setup_6xx.S	Mon Dec  8 08:26:37 2003
> @@ -161,7 +161,7 @@
>  	rlwinm	r3,r10,16,16,31
>  	cmplwi	r3,0x000c
>  	bne	1f			/* Not a 7400. */
> -	andi	r3,r10,0x0f0f
> +	andi.	r3,r10,0x0f0f
>  	cmpwi	0,r3,0x0200
>  	bgt	1f			/* Rev >= 2.1 */
>  	li	r3,HID0_SGE		/* 7400 rev < 2.1, clear SGE. */

This fix works fine, thanks!

-- 
Meelis Roos (mroos@linux.ee)

