Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbULXXcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbULXXcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbULXXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 18:32:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:8907 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261457AbULXXci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 18:32:38 -0500
Date: Fri, 24 Dec 2004 15:32:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: VM fixes [4/4]
In-Reply-To: <20041224174156.GE13747@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0412241530150.2353@ppc970.osdl.org>
References: <20041224174156.GE13747@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Dec 2004, Andrea Arcangeli wrote:
>
>  /*
> + * All archs should support atomic ops with
> + * 1 byte granularity.
> + */
> +	unsigned char memdie;

This simply fundamentally isn't true, last I looked.

At least older alphas do _not_ support atomic byte accesses, and if you
want atomic accesses you need to either use the defined smp-atomic
functions (ie things like the bit set operations), or you need to use 
"int", which afaik all architectures _do_ support atomic accesses to. 

		Linus
