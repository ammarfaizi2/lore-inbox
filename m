Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbSJLUw5>; Sat, 12 Oct 2002 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSJLUw5>; Sat, 12 Oct 2002 16:52:57 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:23182 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261459AbSJLUw4>; Sat, 12 Oct 2002 16:52:56 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Art Haas <ahaas@neosoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C99 designated initializers for arch/i386
References: <20021012192154.GB2682@debian>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 12 Oct 2002 22:59:03 +0200
In-Reply-To: <20021012192154.GB2682@debian>
Message-ID: <87of9zs7ag.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Haas <ahaas@neosoft.com> writes:

> Here's a set of patches that switch arch/i386 to use C99 named
> initiailzers. The patches are all against 2.5.42.
> 
> 
> --- linux-2.5.42/arch/i386/kernel/cpu/intel.c.old	2002-10-12 09:46:27.000000000 -0500
> +++ linux-2.5.42/arch/i386/kernel/cpu/intel.c	2002-10-12 09:53:20.000000000 -0500
> @@ -366,7 +366,7 @@
>  static struct cpu_dev intel_cpu_dev __initdata = {
>  	.c_vendor	= "Intel",
>  	.c_ident 	= { "GenuineIntel" },
> -	c_models: {
> +	.c_models = {
>  		{ X86_VENDOR_INTEL,	4,
>  		  { 
>  			  [0] "486 DX-25/33", 
                             ^

C99 doesn't allow not having a '=' there.

-- 
	Falk
