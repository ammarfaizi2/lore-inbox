Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUEEOKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUEEOKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 10:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbUEEOKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 10:10:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34992 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264685AbUEEOK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 10:10:27 -0400
Date: Wed, 5 May 2004 15:51:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] mxcsr patch for i386 & x86-64
Message-ID: <20040505135102.GC3339@openzaurus.ucw.cz>
References: <E305A4AFB7947540BC487567B5449BA802CA7BEC@scsmsx402.sc.intel.com> <Pine.LNX.4.58.0405041201440.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405041225080.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405041322570.3271@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405041322570.3271@ppc970.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> @@ -550,4 +559,11 @@
>  		memcpy(fpu, &tsk->thread.i387.fxsave, sizeof(*fpu));
>  	}
>  	return fpvalid;
> +}
> +
> +void __init fpu_init(void)
> +{
> +	clts();
> +	mxcsr_feature_mask_init();
> +	stts();
>  }

i386/kernel/power/cpu.c now probably wants fpu_init, too...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

