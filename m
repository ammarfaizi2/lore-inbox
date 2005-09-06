Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVIFU4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVIFU4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVIFU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:56:11 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:47089 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S1750822AbVIFU4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:56:10 -0400
Date: Tue, 06 Sep 2005 13:55:26 -0700
From: Terrence Miller <Terrence.Miller@Sun.COM>
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" ->
 "static inline"
In-reply-to: <200509062223.50747.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Jakub Jelinek <jakub@redhat.com>,
       Adrian Bunk <bunk@stusta.de>, Michael Matz <matz@suse.de>,
       linux-kernel@vger.kernel.org
Reply-to: Terrence.Miller@Sun.COM
Message-id: <431E023E.3050301@Sun.COM>
Organization: Sun Microsystems
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.4) Gecko/20041214
References: <20050902203123.GT3657@stusta.de>
 <20050905184740.GF7403@devserv.devel.redhat.com> <431DD7BE.7060504@Sun.COM>
 <200509062223.50747.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I don't think the functionality of having single copies in case 
> an out of line version was needed was ever required by the Linux kernel.

But shouldn't the compiler that compiles Linux be C99 compliant?

> extern inline was used in the kernel a long time ago as a "poor man's 
> -Winline". Basically the intention was to get an linker error 
> if the inlining didn't work for some reason because if we say
> inline we mean inline.
> 
> But that's long obsolete because the requirements of the C++ "template is 
> turing complete" people has broken inlining so badly (they want a lot of 
> inlining, but not too much inlining because otherwise their compile times 
> explode and the heuristics needed for making some of these pathologic cases 
> work seems to break a lot of other sane code)  that the kernel was forced to 
> define inline to __attribute__((always_inline)). And with that you get an 
> error if inlining
> fails. 
> 
> So the original purpose if extern inline is fulfilled by static inline now.
> However extern inline also doesn't hurt, it really makes no difference now.
> 
> -Andi
>  

-- 

                              Terrence

        ****************************************************
        | Terrence C. Miller      |  Sun Microsystems      |
        | terrence.miller@Sun.COM |  M.S. MPK16-303        |
        | 650-786-9192            |  16 Network Circle     |
        |                         |  Menlo Park, CA 94025  |
        ****************************************************


