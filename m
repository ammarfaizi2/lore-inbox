Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030715AbWLAPeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbWLAPeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030722AbWLAPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:34:15 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:31108 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030715AbWLAPeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:34:14 -0500
Date: Fri, 1 Dec 2006 10:30:21 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `make checkstack' and cross-compilation
Message-ID: <20061201153021.GA4332@ccure.user-mode-linux.org>
References: <Pine.LNX.4.62.0612011455040.19178@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0612011455040.19178@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 02:58:16PM +0100, Geert Uytterhoeven wrote:
> Makefile has:
> | # Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
> | # In the UML case, $(SUBARCH) is the name of the underlying
> | # architecture, while for all other arches, it is the same as $(ARCH).
> | checkstack:
> |         $(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> |         $(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
> 
> While this may fix `make checkstack' for UML, it breaks cross-compilation.
> E.g. when cross-compiling for PPC on ia32, ARCH=powerpc, but SUBARCH=i386.
> 
> Probably it should use SUBARCH if ARCH=um, and ARCH otherwise?

Whoops, you're right.  

Do you have a patch?  If not, I'll make one.

And, do you have a cross-compilation environment which tests this?

				Jeff

-- 
Work email - jdike at linux dot intel dot com
