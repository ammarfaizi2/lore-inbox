Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269598AbUIRRqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269598AbUIRRqs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269597AbUIRRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 13:46:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269609AbUIRRq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 13:46:28 -0400
Date: Sat, 18 Sep 2004 12:05:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial patch for 2.4: always inline __constant_*
Message-ID: <20040918150505.GC3435@logos.cnet>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua> <200409172155.29561.vda@port.imtp.ilyichevsk.odessa.ua> <200409181657.23833.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409181657.23833.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks Denis.

> Most of them can be fixed with a single #include <compiler.h>
> in <string.h>. Along the way, I fixed some non-compilation buglets.
> I will submit those patches as replies now.
> --
> vda

> diff -urpN linux-2.4.27-pre3.org/include/linux/string.h linux-2.4.27-pre3.fix/include/linux/string.h
> --- linux-2.4.27-pre3.org/include/linux/string.h	Sat Sep 18 16:52:10 2004
> +++ linux-2.4.27-pre3.fix/include/linux/string.h	Fri Sep 17 23:19:23 2004
> @@ -7,6 +7,7 @@
>  
>  #include <linux/types.h>	/* for size_t */
>  #include <linux/stddef.h>	/* for NULL */
> +#include <linux/compiler.h>	/* for inline ((always_inline)) */
>  
>  #ifdef __cplusplus
>  extern "C" {

