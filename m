Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSKOEGa>; Thu, 14 Nov 2002 23:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSKOEGa>; Thu, 14 Nov 2002 23:06:30 -0500
Received: from ns.suse.de ([213.95.15.193]:60939 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265713AbSKOEG3>;
	Thu, 14 Nov 2002 23:06:29 -0500
To: Richard Henderson <rth@twiddle.net>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
References: <20021114143701.A30355@twiddle.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2002 05:13:23 +0100
In-Reply-To: Richard Henderson's message of "14 Nov 2002 23:41:01 +0100"
Message-ID: <p73wunfv5b0.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson <rth@twiddle.net> writes:

>  These will affect at least Alpha, IA-64, and MIPS.
> 
>  (3) Alpha and MIPS64 absolutely require that the core and init allocations
>      are "close" (within 2GB).  I don't see how this can be guaranteed with
>      two different vmalloc calls.

In x86-64 (and I think sparc64) the modules (both data and code) also need
to be within 2GB of the main kernel code. This is done to avoid needing
a GOT for calls between main kernel and modules. In the old module code that
is done with a custom module_map() function. I have not looked yet on how
that could be implemented in the new code.

-Andi


