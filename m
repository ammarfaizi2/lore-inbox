Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVBFMeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVBFMeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVBFMeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:34:20 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:57729 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261193AbVBFMeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:34:12 -0500
Date: Sun, 6 Feb 2005 13:33:55 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206123355.GB30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206114758.GA8437@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your main objection is that *incorrect* programs that assume they can
> execute malloc() code without PROT_EXEC protection. For legacy binaries
> keeping this behavior makes sense, no objection from me.
> 
> For newly compiled programs this is just wrong and incorrect.

That's not true as the grub/mono/... experience shows. 


> You mention grub (which has RWE and the patch below thus makes that work)
> and mono. mono has patches for this on their mailinglist and bugzilla since
> 2003 according to google, I'm surprised the novell mono guys haven't fixed
> this bug in their code.

There are probably more.

> FWIW all jvm's don't suffer from this. They are either legacy binaries or
> mprotect properly (only i386 traditionally had this behavior, all others
> already required PROT_EXEC anyway so any half portable app already did this,
> as well as any app portable to BSD since they enforce this on x86 as well)
> 
> So I rather see the patch below merged instead; it fixes the worst problems
> (RWE not marking the heap executable) while keeping this useful feature
> enabled.

It still keeps x86-64 32bit emulation as a proving point for experimental
i386 features which is really not its purpose.

-Andi
