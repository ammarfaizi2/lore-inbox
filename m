Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWGCHbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWGCHbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWGCHbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:31:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:21317 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWGCHbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:31:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C2xqL7+1o6Wdsy1uFOoJlm0YdGi3FZB1FCuYn3IQVgC4x12g3DWsIHVYXEpkU4OM6B7OzCIOdtrcxiMv8r1kN+WB9/MXNPJeOivGqD7efK22YlMzKePT73Hlcp2KZ8mjFPhId/5CmMgU1bYcr+dFvk0Czz1xzPsnn+366aN4htw=
Message-ID: <aec7e5c30607030031p2cb27c0bt3486740a923a61e0@mail.gmail.com>
Date: Mon, 3 Jul 2006 16:31:19 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Chase Venters" <chase.venters@clientec.com>
Subject: Re: .exit.text section in vmlinux
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606301111370.21298@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aec7e5c30606292354x3831f550y9ac2387f2fa56679@mail.gmail.com>
	 <Pine.LNX.4.64.0606301111370.21298@turbotaz.ourhouse>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, Chase Venters <chase.venters@clientec.com> wrote:
> On Fri, 30 Jun 2006, Magnus Damm wrote:
> > The linker script arch/i386/kernel/vmlinux.lds.S mentions the following:
> >
> >  /* .exit.text is discard at runtime, not link time, to deal with references
> >     from .altinstructions and .eh_frame */
>
> .altinstructions is for alternatives code (code that is rewritten at
> runtime based on some factor such as UP-vs-SMP). .eh_frame has call
> framing information used for unwinding. I think it's copied into the
> vsyscall page (not entirely familiar with this mechanism though).

Thanks for clarifying.

> > The text above seems to answer my question, but I cannot say I fully
> > understand the comment. I'd appreciate if someone could explain a bit
> > more if possible.
> >
> > Ok, so the section should be discarded at runtime. Sounds ok. But
> > where in the code is this section discarded? -ENOSYS?
>
> When you see "Freeing unused kernel memory", the memory between
> __init_begin and __init_end (as marked in vmlinux.ld.S) is released. See
> arch-specific mm/init.c.

Oh, I see. It looks like things are working as expected then. Thank you!

Cheers,

/ magnus
