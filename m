Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUD3Tbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUD3Tbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUD3Tbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:31:49 -0400
Received: from vena.lwn.net ([206.168.112.25]:64423 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264909AbUD3T3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:29:12 -0400
Message-ID: <20040430192911.14289.qmail@lwn.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@csd.uu.se>,
       ak@suse.de
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 30 Apr 2004 11:27:04 PDT."
             <20040430112704.3dca3c4c.akpm@osdl.org> 
Date: Fri, 30 Apr 2004 13:29:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this fix?
> 
> diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
> --- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
> +++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
> @@ -20,6 +20,8 @@
>  #include <asm/mmsegment.h>
>  #include <linux/personality.h>
>  
> +#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
> +

That made my x86_64 boot problem go away; with that patch the system comes
up just fine.

Now I have weird display problems with my Radeon card instead.  Ever seen X
running 100% in kernel space, unkillable?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
