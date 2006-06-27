Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWF0IlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWF0IlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWF0IlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:41:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55986 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751263AbWF0IlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:41:00 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [klibc 37/43] x86_64 support for klibc
References: <klibc.200606251757.37@tazenda.hos.anvin.org>
From: Andi Kleen <ak@suse.de>
Date: 27 Jun 2006 10:40:58 +0200
In-Reply-To: <klibc.200606251757.37@tazenda.hos.anvin.org>
Message-ID: <p73zmfzt2hx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> +
> +#include <asm/signal.h>
> +/* The x86-64 headers defines NSIG 32, but it's actually 64 */
> +#undef  _NSIG
> +#undef  NSIG
> +#define _NSIG 64
> +#define NSIG  _NSIG

If it's really wrong it should be fixed, not workarounded.

> +
> +/* The x86-64 syscall headers are needlessly inefficient */
> +
> +#undef _syscall0
> +#undef _syscall1
> +#undef _syscall2
> +#undef _syscall3
> +#undef _syscall4
> +#undef _syscall5
> +#undef _syscall6

What do you mean with that?

-Andi
