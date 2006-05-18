Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWERLRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWERLRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWERLRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:17:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39836 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932069AbWERLRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:17:10 -0400
Date: Thu, 18 May 2006 13:16:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 1/3] reliable stack trace support
Message-ID: <20060518111625.GA2026@elf.ucw.cz>
References: <4469FC07.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4469FC07.76E4.0078.0@novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 16-05-06 16:21:27, Jan Beulich wrote:
> These are the generic bits needed to enable reliable stack traces based
> on Dwarf2-like (.eh_frame) unwind information. Subsequent patches will
> enable x86-64 and i386 to make use of this.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> --- linux-2.6.17-rc4/include/asm-generic/unwind.h	1970-01-01 01:00:00.000000000 +0100
> +++ 2.6.17-rc4-unwind-generic/include/asm-generic/unwind.h	2006-05-16 14:36:21.000000000 +0200
> @@ -0,0 +1,119 @@
> +#ifndef _ASM_GENERIC_UNWIND_H
> +#define _ASM_GENERIC_UNWIND_H
> +
> +/*
> + * Copyright (C) 2002-2006 Novell, Inc.
> + *	Jan Beulich <jbeulich@novell.com>
> + *
> + * A simple API for unwinding kernel stacks.  This is used for
> + * debugging and error reporting purposes.  The kernel doesn't need
> + * full-blown stack unwinding with all the bells and whistles, so there
> + * is not much point in implementing the full Dwarf2 unwind API.

Missing GPL?

> --- linux-2.6.17-rc4/kernel/unwind.c	1970-01-01 01:00:00.000000000 +0100
> +++ 2.6.17-rc4-unwind-generic/kernel/unwind.c	2006-05-16 14:36:08.000000000 +0200
> @@ -0,0 +1,876 @@
> +/*
> + * Copyright (C) 2002-2006 Novell, Inc.
> + *	Jan Beulich <jbeulich@novell.com>
> + *
> + * A simple API for unwinding kernel stacks.  This is used for
> + * debugging and error reporting purposes.  The kernel doesn't need
> + * full-blown stack unwinding with all the bells and whistles, so there
> + * is not much point in implementing the full Dwarf2 unwind API.
> + */

...more than once, I'd say.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
