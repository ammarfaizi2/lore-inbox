Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUANKBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUANKBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:01:21 -0500
Received: from colin2.muc.de ([193.149.48.15]:34569 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265692AbUANKBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:01:19 -0500
Date: 14 Jan 2004 11:02:16 +0100
Date: Wed, 14 Jan 2004 11:02:16 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: [PATCH] string fixes for gcc 3.4
Message-ID: <20040114100216.GD19652@colin2.muc.de>
References: <20040114091543.GA2024@averell> <20040114094305.GQ31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114094305.GQ31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 04:43:05AM -0500, Jakub Jelinek wrote:
> On Wed, Jan 14, 2004 at 10:15:43AM +0100, Andi Kleen wrote:
> > 
> > gcc 3.4 optimizes sprintf(foo,"%s",string) into strcpy. Unfortunately
> > that isn't seen by the inliner and linux/i386 has no out-of-line strcpy
> > so you end up with a linker error.
> 
> The other alternative is -ffreestanding.  Kernel in its current shape
> certainly is not a hosted environment.

Good point.

> But I agree GCC does a better job with string/memory functions
> than kernel with its inlines.

If anybody wants to try it:
cp include/asm-x86_64/string.h include/asm-i386/string.h 
should do approximately the right thing.

-Andi
