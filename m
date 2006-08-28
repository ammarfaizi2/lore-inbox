Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWH1UiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWH1UiG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWH1UiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:38:05 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:7046 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751499AbWH1UiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:38:02 -0400
Date: Mon, 28 Aug 2006 16:35:14 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Message-ID: <20060828203514.GC6728@ccure.user-mode-linux.org>
References: <20060821215641.GQ11651@stusta.de> <200608261256.36654.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608261256.36654.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 12:56:36PM +0200, Blaisorblade wrote:
> Can anybody explain me how can we use REGPARM if we have to link with host 
> glibc?

Umm, yeah, good point.  This regparam behavior is different from the old
behavior, where regparam functions had to be declared as such.

However, this is a potential problem with all regparam users, who all
presumably use libc, so I'd imagine it works somehow.

> If we are going to use klibc instead of glibc that's ok (and this is not the 
> case I'm talking about), but I do not know that plan (and nobody discussed 
> the implications).

I've been idly considering that, but it's no more than idle consideration
right now.

				Jeff
